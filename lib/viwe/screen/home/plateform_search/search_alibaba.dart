import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchAlibaba extends StatelessWidget {
  final HomescreenControllerImple controller;
  const SearchAlibaba({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        mainAxisExtent: 335.h,
      ),
      itemCount: controller.searchProductsAlibaba.isEmpty
          ? controller.searchProductsAlibaba.length
          : controller.lengthAlibaba,
      itemBuilder: (context, index) {
        final item = controller.searchProductsAlibaba[index];

        return InkWell(
          onTap: () {
            int id = item.itemid;
            controller.gotoditels(
              platform: PlatformSource.alibaba,
              id: id,
              title: item.titel,
              lang: detectLangFromQuery(controller.searchController.text),
            );
          },
          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: safeImageUrl(item.mainImageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Loadingimage(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            disc: item.skuPriceFormatted,
            title: item.titel,
            price: item.skuPriceFormatted,
            icon: GetBuilder<FavoritesController>(
              builder: (isFavoriteController) {
                bool isFav =
                    isFavoriteController.isFavorite[item.itemid.toString()] ??
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
                  icon: FaIcon(
                    isFav
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: isFav ? Appcolor.reed : Appcolor.reed,
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
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        "all ${item.imageUrls.length} colors",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        imageUrl: safeImageUrl(img),
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        placeholder: (c, u) => const ShimmerImageProductSmall(),
                        errorWidget: (c, u, e) => Container(
                          width: 30,
                          height: 30,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, size: 16),
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
    );
  }
}
