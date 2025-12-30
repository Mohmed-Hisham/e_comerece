import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/viwe/widget/shein/extension_geter_trending_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TrendingProductShein extends GetView<HomeSheinControllerImpl> {
  const TrendingProductShein({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: true,
      statusrequest: controller.statusrequestproduct,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 400.h,
        ),

        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];

          return InkWell(
            onTap: () {
              controller.gotoditels(
                goodssn: product.goodsSn ?? '',
                title: product.goodsName ?? '',
                goodsid: product.goodsId ?? '',
                categoryid: product.categoryId,
                lang: enOrArShein(),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: RepaintBoundary(
                    child: CustomCachedImage(imageUrl: product.mainImageUrl),
                  ),
                ),
                disc: calculateDiscountPercent(
                  product.salePrice?.amountWithSymbol.toString(),
                  product.retailPrice?.usdAmount.toString(),
                ),
                title: product.goodsName ?? '',
                price: product.salePrice?.amountWithSymbol.toString() ?? '',
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.goodsId.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.goodsId.toString(),
                          product.goodsName ?? '',
                          product.mainImageUrl,
                          product.salePrice?.amountWithSymbol.toString() ?? '',
                          "Shein",
                          goodsSn: product.goodsSn ?? "",
                          categoryid: product.categoryId,
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

                discprice: product.retailPrice?.usdAmount.toString() ?? '',
                countsall: product.brandName,
                rate: product.commentRankAverageValue.toString(),
                isAlibaba: true,
                images: SizedBox(
                  height: 38.h,
                  child: ListView.builder(
                    cacheExtent: 500,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: product.relatedColorImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          alignment: Alignment.center,
                          child: Text(
                            StringsKeys.allColors.trParams({
                              'number': product.relatedColorImages.length
                                  .toString(),
                            }),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Appcolor.primrycolor,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: RepaintBoundary(
                          child: CustomCachedImage(
                            radius: 50,
                            imageUrl: product.relatedColorImages[index - 1],
                            width: 37.w,
                            height: 35.h,
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
    );
  }
}
