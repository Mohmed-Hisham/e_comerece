import 'package:e_comerece/controller/amazon_controllers/product_from_categories_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/amazon/categories_from_product_screen.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductFromCatView extends StatelessWidget {
  const ProductFromCatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductFromCategoriesControllerImpl());
    Get.put(FavoritesController());

    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          GetBuilder<ProductFromCategoriesControllerImpl>(
            builder: (controller) {
              return PositionedAppBar(
                title: controller.categoryName,
                onPressed: Get.back,
              );
            },
          ),
          GetBuilder<ProductFromCategoriesControllerImpl>(
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(height: 115.h),
                  CategoriesFromProductScreen(),
                  Divider(),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        final atEdge = scrollInfo.metrics.atEdge;
                        final pixels = scrollInfo.metrics.pixels;
                        final maxScrollExtent =
                            scrollInfo.metrics.maxScrollExtent;
                        if (atEdge && pixels == maxScrollExtent) {
                          controller.loadMoreOtherProduct();
                        }
                        return true;
                      },
                      child: Handlingdataviwe(
                        statusrequest: controller.statusrequestOtherProduct,
                        widget: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          key: Key(controller.categoryId.toString()),
                          padding: EdgeInsets.all(10.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                mainAxisExtent: 420.h,
                              ),
                          itemCount: controller.otherProduct.length,
                          itemBuilder: (context, index) {
                            final item = controller.otherProduct[index];
                            final currencyService = Get.find<CurrencyService>();

                            return InkWell(
                              onTap: () {
                                controller.gotoditels(
                                  asin: item.asin.toString(),
                                  title: item.productTitle!,
                                  lang: enOrArAmazon(),
                                );
                              },
                              child: Custgridviwe(
                                image: CustomCachedImage(
                                  imageUrl: item.productPhoto ?? "",
                                ),
                                disc: calculateDiscountPercent(
                                  extractPrice(item.productPrice),
                                  extractPrice(item.productOriginalPrice),
                                ),
                                title: item.productTitle!,
                                price: currencyService.convertAndFormat(
                                  amount: extractPrice(item.productPrice),
                                  from: 'SAR',
                                ),
                                icon: GetBuilder<FavoritesController>(
                                  builder: (isFavoriteController) {
                                    bool isFav =
                                        isFavoriteController.isFavorite[item
                                            .asin] ??
                                        false;

                                    return IconButton(
                                      onPressed: () {
                                        isFavoriteController.toggleFavorite(
                                          item.asin!,
                                          item.productTitle!,
                                          item.productPhoto!,
                                          currencyService
                                              .convert(
                                                amount: extractPrice(
                                                  item.productPrice,
                                                ),
                                                from: 'SAR',
                                                to: 'USD',
                                              )
                                              .toString(),
                                          StringsKeys.amazonTitle.tr,
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
                                isAmazon: true,
                                rate: "${item.productStarRating ?? ""}   ",
                                discprice: currencyService.convertAndFormat(
                                  amount: extractPrice(
                                    item.productOriginalPrice ??
                                        item.productPrice,
                                  ),
                                  from: 'SAR',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLoading && controller.hasMore)
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
