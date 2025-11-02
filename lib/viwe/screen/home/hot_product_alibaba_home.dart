import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductAlibabaHome extends StatelessWidget {
  const HotProductAlibabaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'alibaba',
      builder: (controller) => NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo is ScrollUpdateNotification) {
            if (scrollInfo.metrics.axis == Axis.horizontal) {
              if (!controller.alibabaHomeController.isLoading &&
                  controller.alibabaHomeController.hasMore) {
                final pixels = scrollInfo.metrics.pixels;
                final max = scrollInfo.metrics.maxScrollExtent;
                // final atEdge = scrollInfo.metrics.atEdge;
                // // final pixels = scrollInfo.metrics.pixels;
                // final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
                // if (atEdge && pixels == maxScrollExtent) {
                //   controller.fetchProductsAliExpress(isLoadMore: true);
                // }
                if (max > 0 && pixels >= max * 0.8) {
                  controller.loadMoreproductAlibaba();
                }
              }
            }
          }
          return false;
        },
        child: Handlingdataviwe(
          shimmer: ShimmerListHorizontal(isSlevr: false),
          statusrequest: controller.alibabaHomeController.statusrequestAlibaba,
          widget: Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            height: 400.h,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList.builder(
                  itemCount:
                      controller.alibabaHomeController.productsAlibaba.length,
                  itemBuilder: (context, index) {
                    final product =
                        controller.alibabaHomeController.productsAlibaba[index];

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
                        child: SizedBox(
                          width: 200.w,
                          child: Custgridviwe(
                            image: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                cacheKey: product.itemid.toString(),
                                imageUrl: "https:${product.mainImageUrl}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const Loadingimage(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            disc: product.skuPriceFormatted,
                            title: product.titel,
                            price: product.skuPriceFormatted,
                            icon: GetBuilder<FavoritesController>(
                              builder: (controller) {
                                bool isFav =
                                    controller.isFavorite[product.itemid
                                        .toString()] ??
                                    false;

                                return IconButton(
                                  onPressed: () {
                                    controller.toggleFavorite(
                                      product.itemid.toString(),
                                      product.titel,
                                      product.mainImageUrl,
                                      product.skuPriceFormatted,
                                      "Alibaba",
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

                            discprice: product.skuPriceFormatted,
                            countsall: product.minOrderFormatted,
                            isAlibaba: true,
                            images: SizedBox(
                              height: 30,
                              child: ListView.builder(
                                cacheExtent: 500,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemCount: product.imageUrls.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      child: Text(
                                        "all ${product.imageUrls.length} colors",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
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
                                      child: CachedNetworkImage(
                                        imageUrl: product.imageUrls[index - 1],
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        placeholder: (c, u) =>
                                            const ShimmerImageProductSmall(),
                                        errorWidget: (c, u, e) => Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.grey.shade200,
                                          child: const Icon(
                                            Icons.broken_image,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (controller.alibabaHomeController.isLoading &&
                    controller.alibabaHomeController.hasMore)
                  ShimmerListHorizontal(isSlevr: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
