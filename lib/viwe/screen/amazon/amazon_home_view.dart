import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/sliver_divder.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/amazon/categories_amazon_viwe.dart';
import 'package:e_comerece/viwe/screen/amazon/hot_products_amazon_view.dart';
import 'package:e_comerece/viwe/screen/amazon/others_product_amazon.dart';
import 'package:e_comerece/viwe/screen/amazon/search_amazon_view.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/amazon/cust_carousel_amazon.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AmazonHomeView extends StatelessWidget {
  const AmazonHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AmazonHomeControllerImpl());
    Get.put(FavoritesController());

    return Scaffold(
      body: GetBuilder<AmazonHomeControllerImpl>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.amazonTitle.tr,
                onPressed: Get.back,
              ),

              Column(
                children: [
                  SizedBox(height: 110.h),
                  Custshearchappbar(
                    focusNode: controller.searchFocusNode,
                    mycontroller: controller.searchController,
                    showClose: controller.showClose,
                    onTapClose: () {
                      controller.onCloseSearch();
                    },
                    onChanged: (val) {
                      controller.onChangeSearch(val);
                      controller.whenstartSearch(val);
                    },
                    onTapSearch: () {
                      controller.onTapSearch();
                      controller.searchFocusNode.unfocus();
                    },
                    favoriteOnPressed: () {
                      controller.goTofavorite();
                    },
                  ),
                  SizedBox(height: 10.h),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            // shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchAmazonView(controller: controller),
                          )
                        : PaginationListener(
                            fetchAtEnd: true,
                            isLoading:
                                controller.isLoading && controller.hasMore,
                            onLoadMore: () {
                              if (controller.firstShowOther) {
                                controller.otherProducts();
                                controller.firstShowOther = false;
                              } else {
                                controller.loadMoreOtherProduct();
                              }
                            },
                            child: RefreshIndicator(
                              color: Appcolor.primrycolor,
                              backgroundColor: Colors.transparent,
                              onRefresh: () =>
                                  controller.fetchHomePageData(isrefresh: true),
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: CustCarouselAmazon(
                                      items: [
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                      ],
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(
                                          text: StringsKeys.categories.tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverSpacer(15.h),
                                  const SliverToBoxAdapter(
                                    child: CategoriesAmazonViwe(),
                                  ),

                                  const SliverDivider(10),
                                  SliverSpacer(10.h),
                                  SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(
                                          text: StringsKeys.hotDeals.tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverSpacer(15.h),
                                  HotProductsAmazonView(),
                                  SliverSpacer(15.h),

                                  SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(
                                          text: StringsKeys.others.tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverSpacer(10.h),
                                  SliverPadding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 10,
                                    ),
                                    sliver: OthersProductAmazon(
                                      controller: controller,
                                    ),
                                  ),

                                  if (controller.isLoading &&
                                          controller.hasMore ||
                                      controller.statusrequestOtherProduct ==
                                          Statusrequest.loading)
                                    const SliverToBoxAdapter(
                                      child: ShimmerBar(
                                        height: 8,
                                        animationDuration: 1,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {"platform": 'amazon'},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
