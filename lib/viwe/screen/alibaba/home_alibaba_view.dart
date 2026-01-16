import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/animations.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/core/shared/widget_shared/slider_shimmer.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_home_alibaba.dart';
import 'package:e_comerece/viwe/screen/alibaba/search_name_alibaba.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';

import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAlibaba extends StatelessWidget {
  const HomeAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductAlibabaHomeControllerImp());
    Get.put(FavoritesController());
    Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ProductAlibabaHomeControllerImp>(
        builder: (controller) {
          return Stack(
            children: [
              const PositionedRight1(),
              const PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.alibaba.tr,
                onPressed: Get.back,
              ),

              Column(
                children: [
                  SizedBox(height: 100.h),
                  GetBuilder<ProductAlibabaHomeControllerImp>(
                    id: 'initShow',
                    builder: (controller) {
                      return SlideUpFade(
                        visible: controller.initShow,

                        offsetY: -0.40,
                        child: Custshearchappbar(
                          focusNode: controller.focusNode,
                          mycontroller: controller.searchController,
                          onChanged: (val) {
                            controller.onChangeSearch(val);
                            controller.whenstartSearch(val);
                          },
                          showClose: controller.showClose,
                          onTapClose: () {
                            controller.onCloseSearch();
                          },
                          onTapSearch: () {
                            controller.onTapSearch(
                              keyWord: controller.searchController.text,
                            );
                          },
                          favoriteOnPressed: () {
                            controller.goTofavorite();
                          },
                          imageOnPressed: () {
                            controller.goToSearchByimage();
                          },
                        ),
                      );
                    },
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchNameAlibaba(controller: controller),
                          )
                        : RefreshIndicator(
                            color: Appcolor.primrycolor,
                            backgroundColor: Colors.transparent,
                            onRefresh: () =>
                                controller.fetchProducts(isLoadMore: false),
                            child: PaginationListener(
                              fetchAtEnd: true,
                              onLoadMore: () => controller.loadMoreproduct(),
                              isLoading: controller.isLoading,
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  GetBuilder<ProductAlibabaHomeControllerImp>(
                                    id: 'initShow',
                                    builder: (controllerr) {
                                      return SliverToBoxAdapter(
                                        child: FadeScaleTransition(
                                          visible: controller.initShow,
                                          child:
                                              GetBuilder<
                                                ProductAlibabaHomeControllerImp
                                              >(
                                                id: 'slider',
                                                builder: (controller) {
                                                  if (controller
                                                          .statusRequestSlider ==
                                                      Statusrequest.loading) {
                                                    return const SliderShimmer();
                                                  }
                                                  return GetBuilder<
                                                    ProductAlibabaHomeControllerImp
                                                  >(
                                                    id: 'slider',
                                                    builder: (controller) {
                                                      return Custcarouselslider(
                                                        currentIndex: controller
                                                            .currentIndex,
                                                        onPageChanged:
                                                            (val, _) {
                                                              controller
                                                                  .indexchange(
                                                                    val,
                                                                  );
                                                            },
                                                        items: controller
                                                            .sliders
                                                            .map(
                                                              (e) =>
                                                                  e.imageUrl ??
                                                                  "",
                                                            )
                                                            .toList(),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                        ),
                                      );
                                    },
                                  ),

                                  SliverSpacer(17.h),

                                  SliverSpacer(10.h),
                                  SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(
                                          text: StringsKeys.bestProducts.tr,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SliverSpacer(15.h),
                                  ProductHomeAlibaba(),
                                  if (controller.hasMore &&
                                      controller.isLoading &&
                                      controller.pageindex > 1)
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
                    arguments: {"platform": 'alibaba'},
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
