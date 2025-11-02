import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductsAmazonView extends GetView<AmazonHomeControllerImpl> {
  const HotProductsAmazonView({super.key});

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

        itemCount: controller.hotDeals.length,
        itemBuilder: (context, index) {
          final product = controller.hotDeals[index];

          return InkWell(
            onTap: () {
              controller.gotoditels(
                asin: product.productAsin.toString(),
                title: product.dealTitle.toString(),
                lang: enOrArAmazon(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custgridviwe(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "${product.dealPhoto}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                disc: product.dealBadge.toString(),
                //  calculateDiscountPercent(product.item!.sku!.def!.price!,
                //   product.item!.sku!.def!.promotionPrice!,

                // ),
                title: product.dealTitle.toString(),
                price: product.dealPrice!.amount.toString(),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.productAsin.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.productAsin.toString(),
                          product.dealTitle.toString(),
                          product.dealPhoto.toString(),
                          product.dealPrice!.amount.toString(),
                          "Amazon",
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

                discprice: product.listPrice?.amount ?? "",
                countsall: "${product.dealType}",
              ),
            ),
          );
        },
      ),
    );
  }
}
