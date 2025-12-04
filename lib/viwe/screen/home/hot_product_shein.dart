import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/screen/shein/extension_geter_trending_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductShein extends StatelessWidget {
  const HotProductShein({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'shein',
      builder: (controller) {
        log("Rebuild Shein Hot Products");
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo is ScrollUpdateNotification) {
              // if (scrollInfo.metrics.axis == Axis.horizontal) {
              //   if (!controller.sheinHomController.isLoading &&
              //       controller.amazonHomeCon.hasMore) {
              //     final pixels = scrollInfo.metrics.pixels;
              //     final max = scrollInfo.metrics.maxScrollExtent;
              //     // final atEdge = scrollInfo.metrics.atEdge;
              //     // // final pixels = scrollInfo.metrics.pixels;
              //     // final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
              //     // if (atEdge && pixels == maxScrollExtent) {
              //     //   controller.fetchProductsAliExpress(isLoadMore: true);
              //     // }
              //     if (max > 0 && pixels >= max * 0.8) {
              //       controller.loadMoreAmazon();
              //     }
              //   }
              // }
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
                          print(product.productUrl);
                          print(product.productId);
                          print("product.goodsSn => ${product.goodsSn}");
                          print("product.goodsId => ${product.goodsId}");
                          print("product.categoryId => ${product.categoryId}");

                          controller.gotoditelsShein(
                            goodssn: product.goodsSn!,
                            title: product.goodsName!,
                            goodsid: product.goodsId!,
                            categoryid: product.categoryId,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 200.w,
                            child: Custgridviwe(
                              image: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: product.mainImageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  placeholder: (context, url) =>
                                      const Loadingimage(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                height: 30,
                                child: ListView.builder(
                                  cacheExtent: 500,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount:
                                      product.relatedColorImages.length + 1,
                                  itemBuilder: (context, index) {
                                    // log(product.detailImageList.length.toString());
                                    // log(product.detailImageList.toString());
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                        ),
                                        child: Text(
                                          "all ${product.relatedColorImages.length} colors",
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
                                        child: CachedNetworkImage(
                                          imageUrl: product
                                              .relatedColorImages[index - 1],
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                          placeholder: (c, u) =>
                                              const ShimmerImageProductSmall(),
                                          errorWidget: (c, u, e) => Container(
                                            width: 30,
                                            height: 30,
                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 16,
                                            ),
                                          ),
                                        ),
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
                  if (controller.aliexpressHomeController.isLoading &&
                      controller.aliexpressHomeController.hasMore)
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
