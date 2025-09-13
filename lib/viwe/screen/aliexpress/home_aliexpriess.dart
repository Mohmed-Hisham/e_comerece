import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_grideviwe.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/screen/aliexpress/categories_list.dart';
import 'package:e_comerece/viwe/screen/aliexpress/hot_products_grid.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    Get.put(FavoritesController());
    print("build");
    return Scaffold(
      body: GetBuilder<HomePageControllerImpl>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: "Aliexpress", onPressed: Get.back),
              // NotificationListener<ScrollNotification>(
              //   onNotification: (scrollInfo) {
              //     print(
              //       'notif from: ${scrollInfo.context?.widget.runtimeType}, '
              //       'pixels=${scrollInfo.metrics.pixels}, '
              //       'max=${scrollInfo.metrics.maxScrollExtent}',
              //     );
              //     if (!controller.isLoading &&
              //         scrollInfo.metrics.pixels >=
              //             scrollInfo.metrics.maxScrollExtent * 0.8) {
              //       controller.loadMore();
              //     }
              //     return true;
              //   },
              //   child:
              Column(
                children: [
                  SizedBox(height: 65),
                  Custshearchappbar(
                    mycontroller: controller.searchController,
                    onChanged: (val) {
                      controller.onChangeSearch(val);
                      print(detectLangFromQuery(val));
                    },
                    onTapSearch: () {
                      controller.onTapSearch(
                        lang: detectLangFromQuery(
                          controller.searchController.text,
                        ),
                        keyWord: controller.searchController.text,
                      );
                    },
                    favoriteOnPressed: () {
                      controller.goTofavorite();
                    },
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequest,
                            widget: NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (!controller.isLoading &&
                                    scrollInfo.metrics.pixels >=
                                        scrollInfo.metrics.maxScrollExtent *
                                            0.8) {
                                  controller.loadMoreSearch(
                                    detectLangFromQuery(
                                      controller.searchController.text,
                                    ),
                                  );
                                }
                                return true;
                              },

                              child: RefreshIndicator(
                                onRefresh: () => controller.searshText(
                                  keyWord: controller.searchController.text,
                                  lang: detectLangFromQuery(
                                    controller.searchController.text,
                                  ),
                                ),
                                child: GridView.builder(
                                  padding: const EdgeInsets.all(15),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 260,
                                      ),
                                  itemCount: controller.searchProducts.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.searchProducts[index].item!;
                                    return InkWell(
                                      onTap: () {
                                        int id = item.itemId!;
                                        controller.gotoditels(
                                          id: id,
                                          lang: detectLangFromQuery(
                                            controller.searchController.text,
                                          ),
                                        );
                                      },
                                      child: Custgridviwe(
                                        image: CachedNetworkImage(
                                          imageUrl: "https:${item.image!}",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child: ShimmerImageProduct(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        disc:
                                            "${calculateDiscountPercent(item.sku!.def!.price, item.sku!.def!.promotionPrice)}%",
                                        title: item.title!,
                                        price:
                                            "${item.sku!.def!.promotionPrice} \$",
                                        icon: GetBuilder<FavoritesController>(
                                          builder: (isFavoriteController) {
                                            bool isFav =
                                                isFavoriteController
                                                    .isFavorite[item.itemId] ??
                                                false;

                                            return IconButton(
                                              onPressed: () {
                                                isFavoriteController
                                                    .toggleFavorite(
                                                      item.itemId!.toString(),
                                                      item.title!,
                                                      item.image!,
                                                      "\$${item.sku!.def!.price}",
                                                      "Aliexpress",
                                                    );
                                              },
                                              icon: Icon(
                                                isFav
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFav
                                                    ? Colors.red
                                                    : Colors.black,
                                                size: 25,
                                              ),
                                            );
                                          },
                                        ),
                                        discprice: "\$${item.sku!.def!.price}",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo is ScrollUpdateNotification) {
                                if (scrollInfo.metrics.axis == Axis.vertical) {
                                  if (!controller.isLoading &&
                                      controller.hasMore) {
                                    final pixels = scrollInfo.metrics.pixels;
                                    final max =
                                        scrollInfo.metrics.maxScrollExtent;

                                    if (max > 0 && pixels >= max * 0.8) {
                                      controller.loadMore();
                                    }
                                  }
                                }
                              }
                              return false;
                            },
                            child: RefreshIndicator(
                              onRefresh: () => controller.fetchOnrefresh(),
                              child: CustomScrollView(
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: Custcarouselslider(
                                      items: [AppImagesassets.tset],
                                    ),
                                  ),
                                  const SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                      ),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolor.black,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SliverToBoxAdapter(
                                    child: SizedBox(height: 8),
                                  ),

                                  const SliverToBoxAdapter(
                                    child: CategoriesList(),
                                  ),

                                  const SliverToBoxAdapter(
                                    child: Divider(height: 10),
                                  ),

                                  const SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        'Hot Deals',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolor.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SliverToBoxAdapter(
                                    child: SizedBox(height: 16),
                                  ),
                                  HotProductsGrid(),

                                  if (controller.hasMore &&
                                      controller.pageIndex > 0)
                                    const SliverToBoxAdapter(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
