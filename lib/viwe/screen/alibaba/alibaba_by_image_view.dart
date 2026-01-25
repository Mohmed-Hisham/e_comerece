import 'dart:io';
import 'package:e_comerece/controller/alibaba/alibaba_byimage_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:get/get.dart';

class AlibabaByimageView extends StatelessWidget {
  const AlibabaByimageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AlibabaByimageControllerllerImple());
    Get.put(FavoritesController());
    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),

          GetBuilder<AlibabaByimageControllerllerImple>(
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

                              if (!controller.isLoading && controller.hasMore) {
                                final atEdge = scrollInfo.metrics.atEdge;
                                final pixels = scrollInfo.metrics.pixels;
                                final maxScrollExtent =
                                    scrollInfo.metrics.maxScrollExtent;
                                if (atEdge && pixels == maxScrollExtent) {
                                  controller.loadMoreproduct();
                                }
                              }
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
                                    margin: const EdgeInsets.symmetric(
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
                                        height: 100,
                                        width: 100,
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
                              SizedBox(height: 10.h),

                              _buildProductList(controller),
                              if (controller.hasMore &&
                                  controller.pageindex > 0)
                                const ShimmerBar(
                                  height: 8,
                                  animationDuration: 1,
                                ),
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
          GetBuilder<AlibabaByimageControllerllerImple>(
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

  Widget _buildProductList(AlibabaByimageControllerllerImple controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 420.h,
      ),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index].item!;
        final currencyService = Get.find<CurrencyService>();
        const sourceCurrency = 'USD';
        return InkWell(
          onTap: () {
            int id = int.tryParse(item.itemId!.toString()) ?? 0;
            controller.gotoditels(id: id, lang: enOrAr(), title: item.title!);
          },

          child: Custgridviwe(
            image: CustomCachedImage(imageUrl: item.image ?? ""),
            disc: currencyService.convertAndFormatRange(
              priceText: item.sku!.def!.priceModule!.priceFormatted ?? "",
              from: sourceCurrency,
            ),
            title: item.title!,
            price: currencyService.convertAndFormatRange(
              priceText: item.sku!.def!.priceModule!.priceFormatted ?? "",
              from: sourceCurrency,
            ),
            icon: GetBuilder<FavoritesController>(
              builder: (isFavoriteController) {
                bool isFav =
                    isFavoriteController.isFavorite[item.itemId] ?? false;

                return IconButton(
                  onPressed: () {
                    isFavoriteController.toggleFavorite(
                      item.itemId!.toString(),
                      item.title!,
                      item.image!,
                      extractPrice(
                        item.sku!.def!.priceModule!.priceFormatted,
                      ).toString(),
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
              priceText: item.sku!.def!.priceModule!.priceFormatted ?? "",
              from: sourceCurrency,
            ),
            countsall:
                "${item.sku!.def!.quantityModule!.minOrder!.quantityFormatted}",
            isAlibaba: true,
            rate: item.averageStarRate.toString(),
            images: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: item.images.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        StringsKeys.allColors.trParams({
                          'number': item.images.length.toString(),
                        }),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolor.primrycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final img = item.images[index - 1];

                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipOval(
                      child: CustomCachedImage(
                        imageUrl: img,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
