import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';

import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductsAmazonView extends GetView<AmazonHomeControllerImpl> {
  const HotProductsAmazonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: true,
      statusrequest: controller.statusrequestHotProducts,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 370.h,
        ),

        itemCount: controller.hotDeals.length,
        itemBuilder: (context, index) {
          final product = controller.hotDeals[index];

          return InkWell(
            onTap: () {
              controller.gotoditels(
                asin: product.productAsin.toString(),
                title: product.dealTitle.toString(),
                lang: enOrArAmazon(),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: CustomCachedImage(
                  imageUrl: product.dealPhoto.toString(),
                ),
                disc: product.dealBadge.toString(),

                title: product.dealTitle.toString(),
                price: product.dealPrice?.amount ?? "",
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.productAsin.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.productAsin.toString(),
                          product.dealTitle.toString(),
                          product.dealPhoto.toString(),
                          product.dealPrice?.amount ?? "",
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

                discprice: product.listPrice?.amount ?? "",
                countsall: product.dealType ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}
