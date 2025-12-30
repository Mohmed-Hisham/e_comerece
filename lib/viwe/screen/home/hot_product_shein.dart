import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/widget/shein/extension_geter_trending_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';

class HotProductShein extends StatelessWidget {
  const HotProductShein({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'shein',
      builder: (controller) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo is ScrollUpdateNotification) {
              if (scrollInfo.metrics.axis == Axis.horizontal &&
                  scrollInfo.depth == 0) {
                if (!controller.amazonHomeCon.isLoading &&
                    controller.amazonHomeCon.hasMore) {
                  final atEdge = scrollInfo.metrics.atEdge;
                  final pixels = scrollInfo.metrics.pixels;
                  final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
                  if (atEdge && pixels == maxScrollExtent) {
                    controller.sheinHomController.loadMoreproductShein();
                  }
                }
              }
            }
            return false;
          },
          child: Handlingdataviwe(
            ontryagain: () {
              controller.sheinHomController.fetchproducts();
            },

            shimmer: ShimmerListHorizontal(isSlevr: false),
            statusrequest: controller.sheinHomController.statusrequestproduct,
            widget: Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              height: 400.h,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList.builder(
                    itemCount: controller.sheinHomController.products.length,
                    itemBuilder: (context, index) {
                      final product =
                          controller.sheinHomController.products[index];

                      return InkWell(
                        onTap: () {
                          // print(product.productUrl);
                          // print(product.productId);
                          // print("product.goodsSn => ${product.goodsSn}");
                          // print("product.goodsId => ${product.goodsId}");
                          // print("product.categoryId => ${product.categoryId}");

                          controller.gotoditelsShein(
                            goodssn: product.goodsSn!,
                            title: product.goodsName!,
                            goodsid: product.goodsId!,
                            categoryid: product.categoryId,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SizedBox(
                            width: 200.w,
                            child: Custgridviwe(
                              image: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CustomCachedImage(
                                  imageUrl: product.mainImageUrl,
                                ),
                              ),
                              disc: calculateDiscountPercent(
                                product.salePrice?.amountWithSymbol.toString(),
                                product.retailPrice?.usdAmount.toString(),
                              ),
                              title: product.goodsName!,
                              price: product.salePrice!.amountWithSymbol
                                  .toString(),
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
                                        product.goodsName!,
                                        product.mainImageUrl,
                                        product.salePrice!.amountWithSymbol
                                            .toString(),
                                        goodsSn: product.goodsSn,
                                        categoryid: product.categoryId,
                                        "Shein",
                                      );
                                    },
                                    icon: FaIcon(
                                      isFav
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      color: isFav
                                          ? Appcolor.reed
                                          : Appcolor.reed,
                                    ),
                                  );
                                },
                              ),

                              discprice: product.retailPrice!.usdAmount
                                  .toString(),
                              countsall: product.brandName,
                              rate: product.commentRankAverageValue.toString(),
                              isAlibaba: true,
                              images: SizedBox(
                                height: 35.h,
                                child: ListView.builder(
                                  cacheExtent: 500,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount:
                                      product.relatedColorImages.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                        ),
                                        child: Text(
                                          StringsKeys.allColors.trParams({
                                            'number': product
                                                .relatedColorImages
                                                .length
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
                                      padding: EdgeInsets.only(left: 6.w),
                                      child: CustomCachedImage(
                                        radius: 20,
                                        imageUrl: product
                                            .relatedColorImages[index - 1],
                                        width: 35.w,
                                        height: 35.h,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (controller.sheinHomController.isLoading &&
                      controller.sheinHomController.hasMore)
                    ShimmerListHorizontal(isSlevr: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
