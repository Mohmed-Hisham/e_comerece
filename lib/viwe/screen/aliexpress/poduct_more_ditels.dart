import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PoductMoreDitels extends StatelessWidget {
  final ProductDetailsControllerImple controller;
  const PoductMoreDitels({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      shimmer: ShimmerBar(height: 8, animationDuration: 1),
      statusrequest: controller.statusrequestsearch,
      isSliver: true,
      widget: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 300,
        ),
        itemCount: controller.searchProducts.length,
        itemBuilder: (context, index) {
          final item = controller.searchProducts[index].item!;

          return InkWell(
            onTap: () {
              int id = item.itemId!;
              controller.chaingPruduct(id: id, titleReload: item.title!);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Custgridviwe(
                image: CachedNetworkImage(
                  imageUrl: "https:${item.image!}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: ShimmerImageProduct()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        isFavoriteController.isFavorite[item.itemId] ?? false;

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
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.black,
                        size: 25,
                      ),
                    );
                  },
                ),
                discprice: "${item.sku!.def!.price} \$",
                countsall: "${item.sales!} مبيعة",
              ),
            ),
          );
        },
      ),
    );
  }
}
