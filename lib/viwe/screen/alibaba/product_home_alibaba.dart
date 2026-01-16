import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:get/get.dart';

class ProductHomeAlibaba extends GetView<ProductAlibabaHomeControllerImp> {
  const ProductHomeAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      height: 130,
      isSizedBox: true,
      isSliver: true,
      statusrequest: controller.statusrequestproduct,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 420.h,
        ),

        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          final currencyService = Get.find<CurrencyService>();
          const sourceCurrency = 'USD';

          return InkWell(
            onTap: () {
              controller.gotoditels(
                id: product.itemid,
                title: product.titel,
                lang: enOrAr(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custgridviwe(
                image: CustomCachedImage(imageUrl: product.mainImageUrl),
                disc: currencyService.convertAndFormatRange(
                  priceText: product.skuPriceFormatted,
                  from: sourceCurrency,
                ),
                title: product.titel,
                price: currencyService.convertAndFormatRange(
                  priceText: product.skuPriceFormatted,
                  from: sourceCurrency,
                ),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.itemid.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.itemid.toString(),
                          product.titel,
                          product.mainImageUrl,
                          extractPrice(product.skuPriceFormatted).toString(),
                          "Alibaba",
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

                discprice: currencyService.convertAndFormatRange(
                  priceText: product.skuPriceFormatted,
                  from: sourceCurrency,
                ),
                countsall: product.minOrderFormatted,
                isAlibaba: true,
                images: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    cacheExtent: 500,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: product.imageUrls.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            StringsKeys.allColors.trParams({
                              'number': product.imageUrls.length.toString(),
                            }),
                            style: Theme.of(context).textTheme.bodyMedium
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
                            imageUrl: product.imageUrls[index - 1],
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
    );
  }
}
