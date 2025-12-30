import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/product_details_shein_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductFromDetails extends StatelessWidget {
  final String? tag;
  const ProductFromDetails({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      tag: tag,
      id: 'searchProducts',
      builder: (controller) => SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 400.h,
        ),
        itemCount: controller.searchProducts.length,
        itemBuilder: (context, index) {
          final product = controller.searchProducts[index];

          return InkWell(
            onTap: () {
              controller.gotoditels(
                goodssn: product.goodsSn!,
                title: product.goodsName!,
                goodsid: product.goodsId!,
                categoryid: product.catId!,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: CustomCachedImage(imageUrl: product.goodsImg ?? ""),
                disc: calculateDiscountPercent(
                  product.retailPrice!.amount.toString(),
                  product.salePrice?.amount.toString(),
                ),
                title: product.goodsName!,
                price: product.salePrice!.amountWithSymbol.toString(),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.goodsId.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.goodsId.toString(),
                          product.goodsName!,
                          product.goodsImg!,
                          product.salePrice!.amountWithSymbol.toString(),
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

                discprice: product.retailPrice?.usdAmount.toString() ?? "",
                countsall: product.premiumFlagNew?.seriesBadgeName ?? "",
                rate: product.commentRankAverage?.toString() ?? "",
                isAlibaba: true,
                images: SizedBox(
                  height: 33.h,
                  child: ListView.builder(
                    cacheExtent: 500,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: product.relatedColorNew.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          alignment: Alignment.center,
                          child: Text(
                            StringsKeys.allColors.trParams({
                              'number': product.relatedColorNew.length
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
                        padding: const EdgeInsets.only(left: 5),
                        child: ClipOval(
                          child: CustomCachedImage(
                            radius: 50,
                            imageUrl: product.relatedColorNew
                                .map((e) => e.colorImage)
                                .toList()[index - 1]
                                .toString(),
                            width: 33.w,
                            height: 33.h,
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

    // if (controller.isLoadingSearch &&
    //     controller.hasMoresearch &&
    //     controller.pageindex > 0)
    //   ShimmerBar(height: 8, animationDuration: 1),
  }
}
