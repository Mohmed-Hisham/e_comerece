import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductAliexpriessHome extends StatelessWidget {
  const HotProductAliexpriessHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'aliexpress',
      builder: (controller) {
        // controller.moveproduct();
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo is ScrollUpdateNotification) {
              if (scrollInfo.metrics.axis == Axis.horizontal) {
                if (!controller.aliexpressHomeController.isLoading &&
                    controller.aliexpressHomeController.hasMore) {
                  final pixels = scrollInfo.metrics.pixels;
                  final max = scrollInfo.metrics.maxScrollExtent;

                  if (max > 0 && pixels >= max * 0.8) {
                    controller.loadMoreAliexpress();
                  }
                }
              }
            }
            return false;
          },
          child: Handlingdataviwe(
            ontryagain: () {
              controller.aliexpressHomeController.fetchProductsAliExpress();
            },
            shimmer: ShimmerListHorizontal(isSlevr: false),
            statusrequest:
                controller.aliexpressHomeController.statusrequestAliExpress,
            widget: Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              height: 350.h,
              child: CustomScrollView(
                controller: controller.scrollContr,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList.builder(
                    itemCount: controller
                        .aliexpressHomeController
                        .productsAliExpress
                        .length,
                    itemBuilder: (context, index) {
                      final product = controller
                          .aliexpressHomeController
                          .productsAliExpress[index];

                      return InkWell(
                        onTap: () {
                          int id = product.item!.itemId!;
                          controller.gotoditels(
                            platform: PlatformSource.aliexpress,
                            id: id,
                            title: product.item!.title!,
                            lang: enOrAr(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 200.w,
                            child: Custgridviwe(
                              image: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomCachedImage(
                                  imageUrl: product.item?.image ?? "",
                                ),
                              ),
                              disc: calculateDiscountPercent(
                                product.item!.sku!.def!.price!,
                                product.item!.sku!.def!.promotionPrice!,
                              ),
                              title: product.item!.title!,
                              price:
                                  "\$${product.item!.sku!.def!.promotionPrice!}",
                              icon: GetBuilder<FavoritesController>(
                                builder: (controller) {
                                  bool isFav =
                                      controller.isFavorite[product.item!.itemId
                                          .toString()] ??
                                      false;

                                  return IconButton(
                                    onPressed: () {
                                      controller.toggleFavorite(
                                        product.item!.itemId!.toString(),
                                        product.item!.title!,
                                        product.item!.image!,
                                        product.item!.sku!.def!.promotionPrice!,
                                        "Aliexpress",
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

                              discprice: "\$${product.item!.sku!.def!.price!}",
                              countsall:
                                  "${product.item!.sales!} ${StringsKeys.sales.tr}",
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
