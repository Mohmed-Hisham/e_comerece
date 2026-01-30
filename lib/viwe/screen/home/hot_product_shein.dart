import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/shein/extension_geter_trending_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';

class HotProductShein extends StatelessWidget {
  const HotProductShein({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'shein',
      builder: (controller) {
        return PaginationListener(
          scrollDirection: Axis.horizontal,
          onLoadMore: () =>
              controller.sheinHomController.loadMoreproductShein(),
          fetchAtEnd: true,
          isLoading:
              controller.sheinHomController.isLoading &&
              controller.sheinHomController.hasMore,
          child: HandlingdatRequestNoFild(
            isSliver: true,
            shimmer: ShimmerListHorizontal(isSlevr: false),
            statusrequest: controller.sheinHomController.statusrequestproduct,
            widget: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      CustLabelContainer(
                        text: StringsKeys.trendingProductsFromShein.tr,
                      ),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    height: 450.h,
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverList.builder(
                          itemCount:
                              controller.sheinHomController.products.length,
                          itemBuilder: (context, index) {
                            final product =
                                controller.sheinHomController.products[index];
                            final currencyService = Get.find<CurrencyService>();
                            const sourceCurrency = 'USD';

                            return InkWell(
                              onTap: () {
                                controller.gotoditelsShein(
                                  goodssn: product.goodsSn!,
                                  title: product.goodsName!,
                                  goodsid: product.goodsId!,
                                  categoryid: product.categoryId,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  width: 200.w,
                                  child: Custgridviwe(
                                    image: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: CustomCachedImage(
                                        imageUrl: product.mainImageUrl,
                                      ),
                                    ),
                                    disc: calculateDiscountPercent(
                                      extractPrice(
                                        product.retailPrice?.usdAmount,
                                      ),
                                      extractPrice(
                                        product.salePrice?.usdAmount,
                                      ),
                                    ),
                                    title: product.goodsName!,
                                    price: currencyService.convertAndFormat(
                                      amount: extractPrice(
                                        product.salePrice?.usdAmount,
                                      ),
                                      from: sourceCurrency,
                                    ),
                                    icon: GetBuilder<FavoritesController>(
                                      builder: (controller) {
                                        bool isFav =
                                            controller.isFavorite[product
                                                .goodsId
                                                .toString()] ??
                                            false;

                                        return IconButton(
                                          onPressed: () {
                                            controller.toggleFavorite(
                                              product.goodsId.toString(),
                                              product.goodsName!,
                                              product.mainImageUrl,
                                              extractPrice(
                                                product.salePrice?.usdAmount,
                                              ).toString(),
                                              goodsSn: product.goodsSn,
                                              categoryid: product.categoryId,
                                              "Shein",
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
                                        product.retailPrice?.usdAmount ??
                                            product.salePrice?.usdAmount,
                                      ),
                                      from: sourceCurrency,
                                    ),
                                    countsall: product.brandName,
                                    rate: product.commentRankAverageValue
                                        .toString(),
                                    isAlibaba: true,
                                    images: SizedBox(
                                      height: 35.h,
                                      child: ListView.builder(
                                        cacheExtent: 500,
                                        scrollDirection: Axis.horizontal,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount:
                                            product.relatedColorImages.length +
                                            1,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6.w,
                                              ),
                                              child: Text(
                                                StringsKeys.allColors.trParams({
                                                  'number': product
                                                      .relatedColorImages
                                                      .length
                                                      .toString(),
                                                }),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color:
                                                          Appcolor.primrycolor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            );
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(left: 6.w),
                                            child: CustomCachedImage(
                                              radius: 20,
                                              imageUrl: product
                                                  .relatedColorImages[index - 1],
                                              width: 35.w,
                                              height: 35.h,
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
                        if (controller.sheinHomController.isLoading &&
                            controller.sheinHomController.hasMore)
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
