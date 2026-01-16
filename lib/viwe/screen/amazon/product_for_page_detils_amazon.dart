import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductForPageDetilsAmazon extends StatelessWidget {
  final String? tag;
  const ProductForPageDetilsAmazon({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: tag,
      id: 'product',
      builder: (controller) {
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            mainAxisExtent: 420.h,
          ),
          itemCount: controller.searchProducts.length,
          itemBuilder: (context, index) {
            final item = controller.searchProducts[index];
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
                image: CustomCachedImage(imageUrl: item.productPhoto ?? ""),
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
                        isFavoriteController.isFavorite[item.asin] ?? false;

                    return IconButton(
                      onPressed: () {
                        isFavoriteController.toggleFavorite(
                          item.asin!,
                          item.productTitle!,
                          item.productPhoto!,
                          currencyService
                              .convert(
                                amount: extractPrice(item.productPrice),
                                from: 'SAR',
                                to: 'USD',
                              )
                              .toString(),
                          "Amazon",
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
                isAmazon: true,
                rate: "${item.productStarRating ?? ""}   ",
                discprice: currencyService.convertAndFormat(
                  amount: extractPrice(
                    item.productOriginalPrice ?? item.productPrice,
                  ),
                  from: 'SAR',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
