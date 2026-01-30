import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
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
      builder: (controller) {
        return HandlingdatRequestNoFild(
          isSliver: true,
          shimmer: ShimmerListHorizontal(isSlevr: false),
          statusrequest: controller.alibabaHomeController.statusrequestAlibaba,
          widget: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    CustLabelContainer(text: StringsKeys.bestFromAlibaba.tr),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  height: 450.h,
                  child: CustomScrollView(
                    controller: controller.scrollContrAlibaba,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    slivers: [
                      SliverList.builder(
                        itemCount: controller
                            .alibabaHomeController
                            .productsAlibaba
                            .length,
                        itemBuilder: (context, index) {
                          final product = controller
                              .alibabaHomeController
                              .productsAlibaba[index];

                          return InkWell(
                            onTap: () {
                              controller.gotoditels(
                                platform: PlatformSource.alibaba,
                                id: product.itemid,
                                title: product.titel,
                                lang: enOrAr(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: SizedBox(
                                width: 200.w,
                                child: Custgridviwe(
                                  image: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CustomCachedImage(
                                      imageUrl: product.mainImageUrl,
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
                                    height: 33.h,
                                    child: ListView.builder(
                                      cacheExtent: 500,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: product.imageUrls.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0,
                                            ),
                                            child: Text(
                                              StringsKeys.allColors.trParams({
                                                'number': product
                                                    .imageUrls
                                                    .length
                                                    .toString(),
                                              }),
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
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: ClipOval(
                                            child: CustomCachedImage(
                                              imageUrl:
                                                  product.imageUrls[index - 1],
                                              width: 33.w,
                                              height: 33.h,
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
            ],
          ),
        );
      },
    );
  }
}
