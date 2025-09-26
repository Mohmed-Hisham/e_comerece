import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/aliexpress/categories_list.dart';
import 'package:e_comerece/viwe/screen/aliexpress/hot_products_grid.dart';
import 'package:e_comerece/viwe/screen/aliexpress/search_name.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custcarouselaliexpriss.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    Get.put(FavoritesController());
    Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      body: GetBuilder<HomePageControllerImpl>(
        builder: (controller) {
          print("build");
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: "Aliexpress", onPressed: Get.back),

              Column(
                children: [
                  SizedBox(height: 65),
                  Custshearchappbar(
                    mycontroller: controller.searchController,
                    onChanged: (val) {
                      controller.onChangeSearch(val);
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
                    imageOnPressed: () {
                      controller.goToSearchByimage();
                    },
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            // shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchName(controller: controller),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo is ScrollUpdateNotification) {
                                if (scrollInfo.metrics.axis == Axis.vertical) {
                                  if (!controller.isLoading &&
                                      controller.hasMore) {
                                    // final pixels = scrollInfo.metrics.pixels;
                                    // final max =
                                    // scrollInfo.metrics.maxScrollExtent;
                                    final atEdge = scrollInfo.metrics.atEdge;
                                    final pixels = scrollInfo.metrics.pixels;
                                    final maxScrollExtent =
                                        scrollInfo.metrics.maxScrollExtent;
                                    if (atEdge && pixels == maxScrollExtent) {
                                      controller.loadMore();
                                    }

                                    // if (max > 0 && pixels >= max * 0.8) {
                                    //   controller.loadMore();
                                    // }
                                  }
                                }
                              }
                              return false;
                            },
                            child: RefreshIndicator(
                              onRefresh: () =>
                                  controller.fetchHomePageData(isrefresh: true),
                              child: CustomScrollView(
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: Custcarouselaliexpriss(
                                      items: [
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                      ],
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
                                      child: ShimmerBar(
                                        height: 8,
                                        animationDuration: 1,
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
