import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/alibaba/alibaba_byimage_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/servises/safeImage_url.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AlibabaByimageView extends StatelessWidget {
  const AlibabaByimageView({Key? key}) : super(key: key);
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
              print("build");
              return Handlingdataviwe(
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    const SizedBox(height: 80),
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

                                // if (max > 0 && pixels >= max * 0.8) {
                                //   controller.loadMore();
                                // }
                              }
                            }
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
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
                                        inputtext: "البحث مجددا",
                                        onPressed: () {
                                          controller.pickimage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(
                              //   height: 130,
                              //   child: CategorylistForImagesearchAlibaba(
                              //     controller: controller,
                              //   ),
                              // ),
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
          PositionedAppBar(title: "Search By Image", onPressed: Get.back),
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 280,
      ),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index].item!;
        final url = safeImageUrl(item.image);
        return InkWell(
          onTap: () {
            int id = int.tryParse(item.itemId!.toString()) ?? 0;
            controller.gotoditels(id: id, lang: enOrAr(), title: item.title!);
          },

          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => ShimmerImageProduct(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            disc: "${item.sku!.def!.priceModule!.priceFormatted}",
            title: item.title!,
            price: "${item.sku!.def!.priceModule!.priceFormatted}",
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
                      "${item.sku!.def!.priceModule!.priceFormatted}",
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
            discprice: "${item.sku!.def!.priceModule!.priceFormatted}",
            countsall:
                "${item.sku!.def!.quantityModule!.minOrder!.quantityFormatted}",
            isAlibaba: true,
            rate: item.averageStarRate.toString(),
            images: SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics:
                    const ClampingScrollPhysics(), // منع الـ bouncing الغير مرغوب
                itemCount: item.images.length + 1, // النص + الصور
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        "all ${item.images.length} colors",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolor.primrycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final img = item.images[index - 1];
                  final url = img.startsWith('//') ? 'https:$img' : img;

                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: url,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        placeholder: (c, u) => const ShimmerImageProductSmall(),
                        errorWidget: (c, u, e) => Container(
                          width: 30,
                          height: 30,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, size: 16),
                        ),
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
