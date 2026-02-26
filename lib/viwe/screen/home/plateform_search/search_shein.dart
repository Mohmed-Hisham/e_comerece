import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:get/get.dart';

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
        mainAxisExtent: 450.h,
      ),
      itemCount: controller.searchProductsShein.isEmpty
          ? controller.searchProductsShein.length
          : controller.lengthShein,
      itemBuilder: (context, index) {
        final product = controller.searchProductsShein[index];
        final currencyService = Get.find<CurrencyService>();
        const sourceCurrency = 'USD';

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
              extractPrice(product.retailPrice?.usdAmount),
              extractPrice(product.salePrice?.usdAmount),
            ),
            title: product.goodsName!,
            price: currencyService.convertAndFormat(
              amount: extractPrice(product.salePrice?.usdAmount),
              from: sourceCurrency,
            ),
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
                      extractPrice(product.salePrice?.usdAmount).toString(),
                      "Shein",
                      goodsSn: product.goodsSn!,
                      categoryid: product.catId ?? "",
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

            discprice: currencyService.convertAndFormat(
              amount: extractPrice(
                product.retailPrice?.usdAmount ?? product.salePrice?.usdAmount,
              ),
              from: sourceCurrency,
            ),
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
                        StringsKeys.allColorsCount.tr.replaceAll(
                          '@number',
                          product.relatedColorNew.length.toString(),
                        ),
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
