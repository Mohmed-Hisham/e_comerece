import 'dart:io';

import 'package:e_comerece/controller/aliexpriess/searchbyimage_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';

import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchByImageView extends StatelessWidget {
  const SearchByImageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SearchByimageControllerllerImple());
    Get.put(FavoritesController());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),

          GetBuilder<SearchByimageControllerllerImple>(
            builder: (controller) {
              return Handlingdataviwe(
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    SizedBox(height: 110.h),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo is ScrollUpdateNotification) {
                            if (scrollInfo.metrics.axis == Axis.vertical) {
                              final currentScroll = scrollInfo.metrics.pixels;

                              controller.showPicker(currentScroll);
                            }
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Appcolor.primrycolor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(controller.image!.path),
                                        height: 115.h,
                                        width: 110.w,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: SizedBox(
                                      child: Custombuttonauth(
                                        inputtext: StringsKeys.searchAgain.tr,
                                        onPressed: () {
                                          controller.pickimage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              _buildProductList(controller),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          PositionedAppBar(
            title: StringsKeys.searchByImage.tr,
            onPressed: Get.back,
          ),
          GetBuilder<SearchByimageControllerllerImple>(
            id: 'viewport',
            builder: (controller) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                bottom: controller.viewport ? 40 : -80,
                left: 15,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Appcolor.primrycolor,
                    border: Border.all(color: Appcolor.white, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: IconButton(
                    color: Appcolor.white,
                    onPressed: () => controller.pickimage(),
                    icon: const Icon(Icons.image_search),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(SearchByimageControllerllerImple controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10.w,
        mainAxisExtent: 320.h,
      ),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index].item!;

        return InkWell(
          onTap: () {
            int id = int.tryParse(item.itemId!.toString()) ?? 0;
            controller.gotoditels(id: id, lang: enOrAr(), title: item.title!);
          },

          child: Custgridviwe(
            image: CustomCachedImage(imageUrl: item.image ?? ""),
            disc: "${item.sku?.def?.promotionPrice ?? ""} \$",
            title: item.title ?? "",
            price: "${item.sku?.def?.promotionPrice ?? ""} \$",
            icon: GetBuilder<FavoritesController>(
              builder: (isFavoriteController) {
                bool isFav =
                    isFavoriteController.isFavorite[item.itemId] ?? false;

                return IconButton(
                  onPressed: () {
                    isFavoriteController.toggleFavorite(
                      item.itemId!.toString(),
                      item.title ?? "",
                      item.image ?? "",
                      "\$${item.sku?.def?.price ?? ""}",
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
            discprice: "${item.sku?.def?.promotionPrice ?? ""} \$",
            countsall: "${item.sales ?? ""} ${StringsKeys.sales.tr}",
          ),
        );
      },
    );
  }
}
