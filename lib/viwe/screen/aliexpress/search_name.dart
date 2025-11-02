import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchName extends StatelessWidget {
  final HomePageControllerImpl controller;
  const SearchName({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!controller.isLoading) {
          final atEdge = scrollInfo.metrics.atEdge;
          final pixels = scrollInfo.metrics.pixels;
          final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
          if (atEdge && pixels == maxScrollExtent) {
            controller.loadMoreSearch(
              detectLangFromQuery(controller.searchController.text),
            );
          }
        }
        return true;
      },

      child: RefreshIndicator(
        onRefresh: () => controller.searshText(
          keyWord: controller.searchController.text,
          lang: detectLangFromQuery(controller.searchController.text),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 260,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.searchProducts[index].item!;

                  return InkWell(
                    onTap: () {
                      int id = item.itemId!;
                      controller.gotoditels(
                        id: id,
                        title: item.title!,
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
                            const Center(child: ShimmerImageProduct()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      disc: calculateDiscountPercent(
                        item.sku!.def!.price,
                        item.sku!.def!.promotionPrice,
                      ),
                      title: item.title!,
                      price: "${item.sku!.def!.promotionPrice} \$",
                      icon: GetBuilder<FavoritesController>(
                        builder: (isFavoriteController) {
                          bool isFav =
                              isFavoriteController.isFavorite[item.itemId
                                  .toString()] ??
                              false;

                          return IconButton(
                            onPressed: () {
                              isFavoriteController.toggleFavorite(
                                item.itemId!.toString(),
                                item.title!,
                                item.image!,
                                "\$${item.sku!.def!.price}",
                                "Aliexpress",
                              );
                            },
                            icon: FaIcon(
                              isFav
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isFav ? Appcolor.reed : Appcolor.reed,
                            ),
                          );
                        },
                      ),
                      discprice: "${item.sku!.def!.price} \$",
                      countsall: "${item.sales!} مبيعة",
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoading &&
                controller.hasMoresearch &&
                controller.pageIndexSearch > 0)
              ShimmerBar(height: 8, animationDuration: 1),
          ],
        ),
      ),
    );
  }
}
