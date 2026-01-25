import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductsGrid extends GetView<HomePageControllerImpl> {
  const HotProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyService = Get.find<CurrencyService>();
    return Handlingdataviwe(
      isSliver: true,
      statusrequest: controller.statusrequestHotProducts,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 420.h,
        ),

        itemCount: controller.hotProducts.length,
        itemBuilder: (context, index) {
          final product = controller.hotProducts[index];

          return InkWell(
            onTap: () {
              int id = product.item?.itemId ?? 0;
              controller.gotoditels(
                id: id,
                title: product.item?.title ?? "",
                lang: enOrAr(),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Custgridviwe(
                image: CustomCachedImage(imageUrl: product.item?.image ?? ""),
                disc: calculateDiscountPercent(
                  product.item?.sku?.def?.price,
                  product.item?.sku?.def?.promotionPrice,
                ),
                title: product.item?.title ?? '',
                price: currencyService.convertAndFormat(
                  amount: extractPrice(
                    product.item?.sku?.def?.promotionPrice ?? "0",
                  ),
                  from: 'USD',
                ),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.item?.itemId
                            .toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.item?.itemId?.toString() ?? "",
                          product.item?.title ?? "",
                          product.item?.image ?? "",
                          currencyService
                              .convert(
                                amount: extractPrice(
                                  product.item?.sku?.def?.promotionPrice ?? "0",
                                ),
                                from: 'USD',
                                to: 'USD',
                              )
                              .toString(),
                          "Aliexpress",
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
                  amount: extractPrice(product.item?.sku?.def?.price ?? "0"),
                  from: 'USD',
                ),
                countsall: "${product.item?.sales} ${StringsKeys.sales.tr}",
              ),
            ),
          );
        },
      ),
    );
  }
}
