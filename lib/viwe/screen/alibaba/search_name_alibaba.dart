import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/screen/alibaba/seetings_alibaba.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchNameAlibaba extends StatelessWidget {
  final ProductAlibabaHomeControllerImp controller;
  const SearchNameAlibaba({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            if (!controller.isLoadingSearch) {
              final atEdge = scrollInfo.metrics.atEdge;
              final pixels = scrollInfo.metrics.pixels;
              final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
              if (atEdge && pixels == maxScrollExtent) {
                controller.loadMoreSearch();
              }
            }
          }
        }
        return true;
      },

      child: RefreshIndicator(
        onRefresh: () =>
            controller.searshText(q: controller.searchController.text),
        child: Column(
          children: [
            SeetingsAlibaba(),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 280,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.searchProducts[index];

                  return InkWell(
                    onTap: () {
                      int id = item.itemid;
                      controller.gotoditels(
                        id: id,
                        Title: item.titel,
                        lang: detectLangFromQuery(
                          controller.searchController.text,
                        ),
                      );
                    },
                    child: Custgridviwe(
                      image: CachedNetworkImage(
                        imageUrl: "https:${item.mainImageUrl}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Loadingimage(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      disc: item.skuPriceFormatted,
                      title: item.titel,
                      price: item.skuPriceFormatted,
                      icon: GetBuilder<FavoritesController>(
                        builder: (isFavoriteController) {
                          bool isFav =
                              isFavoriteController.isFavorite[item.itemid] ??
                              false;

                          return IconButton(
                            onPressed: () {
                              isFavoriteController.toggleFavorite(
                                item.itemid.toString(),
                                item.titel,
                                item.mainImageUrl,
                                item.skuPriceFormatted,
                                "Alibaba",
                              );
                            },
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.black,
                              size: 25,
                            ),
                          );
                        },
                      ),
                      discprice: item.skuPriceFormatted,
                      countsall: item.minOrderFormatted,
                      isAlibaba: true,
                      images: SizedBox(
                        height: 30,
                        child: ListView.builder(
                          cacheExtent: 500,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: item.imageUrls.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(
                                  "all ${item.imageUrls.length} colors",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Appcolor.primrycolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              );
                            }

                            final img = item.imageUrls[index - 1];

                            return Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: img,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  placeholder: (c, u) =>
                                      const ShimmerImageProductSmall(),
                                  errorWidget: (c, u, e) => Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoadingSearch &&
                controller.hasMoresearch &&
                controller.pageIndexSearch > 0)
              ShimmerBar(height: 8, animationDuration: 1),
          ],
        ),
      ),
    );
  }
}
