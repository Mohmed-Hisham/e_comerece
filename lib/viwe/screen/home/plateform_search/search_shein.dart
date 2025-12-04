import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchShein extends StatelessWidget {
  final HomescreenControllerImple controller;
  const SearchShein({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        mainAxisExtent: 380.h,
      ),
      itemCount: controller.searchProductsShein.isEmpty
          ? controller.searchProductsShein.length
          : controller.lengthShein,
      itemBuilder: (context, index) {
        final product = controller.searchProductsShein[index];

        return InkWell(
          onTap: () {
            controller.gotoditelsShein(
              goodssn: product.goodsSn!,
              title: product.goodsName!,
              goodsid: product.goodsId!,
              categoryid: product.catId ?? "",
            );
          },
          child: Custgridviwe(
            image: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: safeImageUrl(product.goodsImg),
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => const Loadingimage(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            disc: calculateDiscountPercent(
              product.retailPrice!.amount.toString(),
              product.salePrice?.amount.toString(),
            ),
            title: product.goodsName!,
            price: product.salePrice!.amountWithSymbol.toString(),
            icon: GetBuilder<FavoritesController>(
              builder: (controller) {
                bool isFav =
                    controller.isFavorite[product.goodsId.toString()] ?? false;

                return IconButton(
                  onPressed: () {
                    controller.toggleFavorite(
                      product.goodsId.toString(),
                      product.goodsName!,
                      product.goodsImg!,
                      product.salePrice!.amountWithSymbol.toString(),
                      "Shein",
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

            discprice: product.retailPrice!.usdAmount.toString(),
            countsall: product.tag3PLabelName,
            rate: product.commentRankAverage.toString(),
            isAlibaba: true,
            images: SizedBox(
              height: 30,
              child: ListView.builder(
                cacheExtent: 500,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: product.relatedColorNew.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        "all ${product.relatedColorNew.length} colors",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolor.primrycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: safeImageUrl(
                          product.relatedColorNew
                              .map((e) => e.colorImage)
                              .toList()[index - 1],
                        ),
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
