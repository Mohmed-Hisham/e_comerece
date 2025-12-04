import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/extractn_umbers.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';

import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchAmazon extends StatelessWidget {
  final HomescreenControllerImple controller;
  const SearchAmazon({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        mainAxisExtent: 340.h,
      ),
      itemCount: controller.searchProducts.isEmpty
          ? controller.searchProducts.length
          : controller.lengthAmazon,
      itemBuilder: (context, index) {
        final item = controller.searchProducts[index];

        return InkWell(
          onTap: () {
            log(item.productUrl.toString());
            print(item.asin.toString());
            controller.gotoditels(
              platform: PlatformSource.amazon,
              asin: item.asin.toString(),
              title: item.productTitle!,
              lang: enOrArAmazon(),
            );
          },
          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: safeImageUrl(item.productPhoto!),
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
