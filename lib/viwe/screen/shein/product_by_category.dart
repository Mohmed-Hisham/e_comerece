import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/product_by_category_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/viwe/widget/shein/categories_from_shein_product_screen.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductByCategoryControllerImple());
    Get.put(FavoritesController());

    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          GetBuilder<ProductByCategoryControllerImple>(
            builder: (controller) {
              return PositionedAppBar(
                title: controller.title,
                onPressed: () {
                  Get.back();
                },
              );
            },
          ),
          GetBuilder<ProductByCategoryControllerImple>(
            id: 'searchProducts',
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(height: 115.h),
                  CategoriesFromSheinProductScreen(),
                  Divider(),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        final atEdge = scrollInfo.metrics.atEdge;
                        final pixels = scrollInfo.metrics.pixels;
                        final maxScrollExtent =
                            scrollInfo.metrics.maxScrollExtent;
                        if (atEdge && pixels == maxScrollExtent) {
                          controller.loadMoreSearch();
                        }
                        return true;
                      },
                      child: Handlingdataviwe(
                        statusrequest: controller.statusrequestsearch,
                        widget: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          key: Key(controller.categoryid.toString()),
                          padding: EdgeInsets.all(10.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                mainAxisExtent: 400.h,
                              ),
                          itemCount: controller.searchProducts.length,
                          itemBuilder: (context, index) {
                            final item = controller.searchProducts[index];

                            return InkWell(
                              onTap: () {
                                controller.gotoditels(
                                  goodssn: item.goodsSn!,
                                  title: item.goodsName!,
                                  goodsid: item.goodsId!,
                                  categoryid: controller.categoryid,
                                );
                              },
                              child: Custgridviwe(
                                image: CustomCachedImage(
                                  imageUrl: item.goodsImg ?? "",
                                ),
                                disc: item.retailDiscountPercent ?? "",
                                title: item.goodsName!,
                                price: item.salePrice?.amount ?? "",
                                icon: GetBuilder<FavoritesController>(
                                  builder: (isFavoriteController) {
                                    bool isFav =
                                        isFavoriteController.isFavorite[item
                                            .goodsSn] ??
                                        false;

                                    return IconButton(
                                      onPressed: () {
                                        isFavoriteController.toggleFavorite(
                                          item.goodsSn!,
                                          item.goodsName!,
                                          item.goodsImg!,
                                          item.salePrice?.amount ?? "",
                                          "Shein",
                                          goodsSn: item.goodsSn ?? "",
                                          categoryid: controller.categoryid,
                                        );
                                      },
                                      icon: FaIcon(
                                        isFav
                                            ? FontAwesomeIcons.solidHeart
                                            : FontAwesomeIcons.heart,
                                        color: Appcolor.reed,
                                      ),
                                    );
                                  },
                                ),
                                isAmazon: false,
                                rate: "${item.commentRankAverage ?? ""}   ",
                                discprice: item.retailPrice?.amount ?? "",
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLoadingSearch && controller.hasMoresearch)
                    ShimmerBar(height: 8, animationDuration: 1),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
