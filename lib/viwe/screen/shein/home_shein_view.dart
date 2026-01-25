import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/core/shared/widget_shared/slider_shimmer.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/screen/shein/categories_shein.dart';
import 'package:e_comerece/viwe/screen/shein/search_shein_viwe.dart';
import 'package:e_comerece/viwe/screen/shein/trending_product_shein.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';

import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';

class HomeSheinView extends StatelessWidget {
  const HomeSheinView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeSheinControllerImpl());
    Get.put(FavoritesController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomeSheinControllerImpl>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.shein.tr,
                onPressed: Get.back,
              ),

              Column(
                children: [
                  SizedBox(height: 110.h),
                  Custshearchappbar(
                    mycontroller: controller.searchController,
                    focusNode: controller.searchFocusNode,
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
                    },
                    favoriteOnPressed: () {
                      controller.goTofavorite();
                    },
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            ontryagain: controller.searshProduct,
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchSheinViwe(controller: controller),
                          )
                        : PaginationListener(
                            isLoading: controller.isLoading,
                            fetchAtEnd: true,
                            onLoadMore: controller.loadMore,
                            child: CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                SliverToBoxAdapter(
                                  child: GetBuilder<HomeSheinControllerImpl>(
                                    id: 'slider',
                                    builder: (controller) {
                                      if (controller.statusRequestSlider ==
                                          Statusrequest.loading) {
                                        return const SliderShimmer();
                                      }
                                      return GetBuilder<
                                        HomeSheinControllerImpl
                                      >(
                                        id: 'slider',
                                        builder: (controller) {
                                          return Custcarouselslider(
                                            currentIndex:
                                                controller.currentIndex,
                                            onPageChanged: (val, _) {
                                              controller.indexchange(val);
                                            },
                                            items: controller.sliders
                                                .map((e) => e.imageUrl ?? "")
                                                .toList(),
                                          );
                                        },
                                      );
                                    },
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
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 8),
                                ),

                                const SliverToBoxAdapter(
                                  child: CategoriesShein(),
                                ),

                                const SliverToBoxAdapter(
                                  child: Divider(height: 10),
                                ),
                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(
                                        text: StringsKeys.trending.tr,
                                      ),
                                    ],
                                  ),
                                ),

                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 16),
                                ),
                                TrendingProductShein(),

                                if (controller.hasMore &&
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
                ],
              ),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {"platform": 'shein'},
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
