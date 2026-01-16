import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/shein/seetings_price_shein.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchSheinViwe extends StatelessWidget {
  final HomeSheinControllerImpl controller;
  const SearchSheinViwe({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            if (!controller.isLoadingSearch) {
              final atEdge = scrollInfo.metrics.atEdge;
              final pixels = scrollInfo.metrics.pixels;
              final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
              if (atEdge && pixels == maxScrollExtent) {
                controller.loadMoreSearch();
              }
            }
          }
        }
        return true;
      },

      child: RefreshIndicator(
        onRefresh: () => controller.searshProduct(),
        child: Column(
          children: [
            SeetingsPriceShein(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 450.h,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.searchProducts[index];
                  final currencyService = Get.find<CurrencyService>();
                  const sourceCurrency = 'USD';

                  return InkWell(
                    onTap: () {
                      controller.gotoditels(
                        goodssn: product.goodsSn ?? "",
                        title: product.goodsName ?? "",
                        goodsid: product.goodsId ?? "",
                        categoryid: product.catId ?? "",
                        lang: detectLangFromQueryShein(
                          controller.searchController.text,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Custgridviwe(
                        image: CustomCachedImage(
                          imageUrl: product.goodsImg ?? "",
                        ),
                        disc: calculateDiscountPercent(
                          extractPrice(product.retailPrice?.usdAmount),
                          extractPrice(product.salePrice?.usdAmount),
                        ),
                        title: product.goodsName ?? "",
                        price: currencyService.convertAndFormat(
                          amount: extractPrice(product.salePrice?.usdAmount),
                          from: sourceCurrency,
                        ),
                        icon: GetBuilder<FavoritesController>(
                          builder: (controller) {
                            bool isFav =
                                controller.isFavorite[product.goodsId
                                    .toString()] ??
                                false;

                            return IconButton(
                              onPressed: () {
                                controller.toggleFavorite(
                                  product.goodsId.toString(),
                                  product.goodsName ?? "",
                                  product.goodsImg ?? "",
                                  extractPrice(
                                    product.salePrice?.usdAmount,
                                  ).toString(),
                                  goodsSn: product.goodsSn ?? "",
                                  categoryid: product.catId ?? "",
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

                        discprice: currencyService.convertAndFormat(
                          amount: extractPrice(
                            product.retailPrice?.usdAmount ??
                                product.salePrice?.usdAmount,
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
                            physics: const BouncingScrollPhysics(),
                            itemCount: product.relatedColorNew.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                  ),
                                  child: Text(
                                    StringsKeys.allColors.trParams({
                                      'number': product.relatedColorNew.length
                                          .toString(),
                                    }),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Appcolor.primrycolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: ClipOval(
                                  child: CustomCachedImage(
                                    imageUrl:
                                        product.relatedColorNew
                                            .map((e) => e.colorImage)
                                            .toList()[index - 1] ??
                                        "",
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoadingSearch &&
                controller.hasMoresearch &&
                controller.pageindex > 0)
              ShimmerBar(height: 8, animationDuration: 1),
          ],
        ),
      ),
    );
  }
}
