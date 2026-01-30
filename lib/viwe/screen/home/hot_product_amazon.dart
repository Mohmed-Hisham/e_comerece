import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HotProductAmazon extends StatelessWidget {
  const HotProductAmazon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'amazon',
      builder: (controller) {
        return PaginationListener(
          scrollDirection: Axis.horizontal,
          onLoadMore: () => controller.loadMoreAmazon(),
          // fetchAtEnd: true,
          isLoading:
              controller.amazonHomeCon.isLoading &&
              controller.amazonHomeCon.hasMore,
          child: HandlingdatRequestNoFild(
            isSliver: true,
            shimmer: ShimmerListHorizontal(isSlevr: false),
            statusrequest: controller.amazonHomeCon.statusrequestHotProducts,
            widget: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      CustLabelContainer(
                        text: StringsKeys.hotDealsFromAmazon.tr,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    height: 400.h,
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverList.builder(
                          itemCount: controller.amazonHomeCon.hotDeals.length,
                          itemBuilder: (context, index) {
                            final product =
                                controller.amazonHomeCon.hotDeals[index];
                            final currencyService = Get.find<CurrencyService>();

                            return InkWell(
                              onTap: () {
                                controller.gotoditels(
                                  platform: PlatformSource.amazon,
                                  asin: product.productAsin.toString(),
                                  title: product.dealTitle.toString(),
                                  lang: enOrArAmazon(),
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
                                        imageUrl: product.dealPhoto ?? "",
                                      ),
                                    ),
                                    disc: product.dealBadge.toString(),
                                    //  calculateDiscountPercent(product.item!.sku!.def!.price!,
                                    //   product.item!.sku!.def!.promotionPrice!,

                                    // ),
                                    title: product.dealTitle.toString(),
                                    price: currencyService.convertAndFormat(
                                      amount: extractPrice(
                                        product.dealPrice?.amount,
                                      ),
                                      from: 'SAR',
                                    ),
                                    icon: GetBuilder<FavoritesController>(
                                      builder: (controller) {
                                        bool isFav =
                                            controller.isFavorite[product
                                                .productAsin
                                                .toString()] ??
                                            false;

                                        return IconButton(
                                          onPressed: () {
                                            controller.toggleFavorite(
                                              product.productAsin.toString(),
                                              product.dealTitle.toString(),
                                              product.dealPhoto.toString(),
                                              currencyService
                                                  .convert(
                                                    amount: extractPrice(
                                                      product.dealPrice?.amount,
                                                    ),
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
                                            color: isFav
                                                ? Appcolor.reed
                                                : Appcolor.reed,
                                          ),
                                        );
                                      },
                                    ),

                                    discprice: currencyService.convertAndFormat(
                                      amount: extractPrice(
                                        product.listPrice?.amount,
                                      ),
                                      from: 'SAR',
                                    ),
                                    countsall: product.dealType ?? '',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (controller.aliexpressHomeController.isLoading &&
                            controller.aliexpressHomeController.hasMore)
                          ShimmerListHorizontal(isSlevr: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
