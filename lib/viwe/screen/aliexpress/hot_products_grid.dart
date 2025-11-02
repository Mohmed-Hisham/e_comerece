import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductsGrid extends GetView<HomePageControllerImpl> {
  const HotProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: true,
      // shimmer: ShimmerSliverGridviwe(),
      statusrequest: controller.statusrequestHotProducts,
      widget: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 260,
        ),

        itemCount: controller.hotProducts.length,
        itemBuilder: (context, index) {
          final product = controller.hotProducts[index];

          return InkWell(
            onTap: () {
              int id = product.item!.itemId!;
              controller.gotoditels(
                id: id,
                title: product.item!.title!,
                lang: enOrAr(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custgridviwe(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "https:${product.item!.image!}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const ShimmerImageProduct(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                disc: calculateDiscountPercent(
                  product.item!.sku!.def!.price!,
                  product.item!.sku!.def!.promotionPrice!,
                ),
                title: product.item!.title!,
                price: "\$${product.item!.sku!.def!.promotionPrice!}",
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.item!.itemId
                            .toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.item!.itemId!.toString(),
                          product.item!.title!,
                          product.item!.image!,
                          product.item!.sku!.def!.promotionPrice!,
                          "Aliexpress",
                        );
                      },
                      icon: FaIcon(
                        isFav
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: isFav ? Appcolor.reed : Appcolor.reed,
                      ),

                      //  Icon(
                      //   isFav ? Icons.favorite : Icons.favorite_border,
                      //   color: isFav ? Colors.red : Colors.black,
                      //   size: 25,
                      // ),
                    );
                  },
                ),

                discprice: "\$${product.item!.sku!.def!.price!}",
                countsall: "${product.item!.sales!} مبيعة",
              ),
            ),
          );
        },
      ),
    );
  }
}
