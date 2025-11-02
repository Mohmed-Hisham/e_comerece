import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/extractn_umbers.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class OthersProductAmazon extends StatelessWidget {
  final AmazonHomeControllerImpl controller;
  const OthersProductAmazon({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 260,
      ),
      itemCount: controller.otherProduct.length,
      itemBuilder: (context, index) {
        final item = controller.otherProduct[index];

        return InkWell(
          onTap: () {
            log(item.productUrl.toString());
            log(item.asin.toString());

            controller.gotoditels(
              asin: item.asin.toString(),
              title: item.productTitle!,
              lang: enOrArAmazon(),
            );
          },
          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: item.productPhoto!,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Loadingimage(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            disc: calculateDiscountPercent(
              extractNumbers(item.productPrice.toString()),
              extractNumbers(item.productOriginalPrice ?? ""),
            ),
            title: item.productTitle!,
            price: extractNumbers(item.productPrice.toString()),
            icon: GetBuilder<FavoritesController>(
              builder: (isFavoriteController) {
                bool isFav =
                    isFavoriteController.isFavorite[item.asin] ?? false;

                return IconButton(
                  onPressed: () {
                    isFavoriteController.toggleFavorite(
                      item.asin!,
                      item.productTitle!,
                      item.productPhoto!,
                      extractNumbers(item.productPrice.toString()),
                      "Amazon",
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
            isAmazon: true,
            rate: "${item.productStarRating ?? ""}   ",
            discprice: extractNumbers(item.productOriginalPrice ?? "") != ""
                ? extractNumbers(item.productOriginalPrice ?? "")
                : extractNumbers(item.productPrice.toString()),
          ),
        );
      },
    );
  }
}
