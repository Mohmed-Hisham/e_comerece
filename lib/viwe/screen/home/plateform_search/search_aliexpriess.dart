import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchAliexpriess extends StatelessWidget {
  final HomescreenControllerImple controller;
  const SearchAliexpriess({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        mainAxisExtent: 330.h,
      ),
      itemCount: controller.searchProductsAliExpress.isEmpty
          ? controller.searchProductsAliExpress.length
          : controller.lengthAliexpress,
      itemBuilder: (context, index) {
        final item = controller.searchProductsAliExpress[index].item!;

        return InkWell(
          onTap: () {
            int id = item.itemId!;
            controller.gotoditels(
              platform: PlatformSource.aliexpress,
              id: id,
              title: item.title!,
              lang: detectLangFromQuery(controller.searchController.text),
            );
          },
          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: safeImageUrl(item.image!),
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Loadingimage(),
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
                    isFavoriteController.isFavorite[item.itemId.toString()] ??
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
            countsall: "${item.sales!} ${StringsKeys.sales.tr}",
          ),
        );
      },
    );
  }
}
