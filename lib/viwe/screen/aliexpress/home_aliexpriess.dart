import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/sliver_divder.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/aliexpress/categories_list.dart';
import 'package:e_comerece/viwe/screen/aliexpress/hot_products_grid.dart';
import 'package:e_comerece/viwe/screen/aliexpress/search_name.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custcarouselaliexpriss.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    Get.put(FavoritesController());
    Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomePageControllerImpl>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.aliexpress.tr,
                onPressed: Get.back,
              ),

              Column(
                children: [
                  SizedBox(height: 110.h),
                  Custshearchappbar(
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

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchName(controller: controller),
                          )
                        : PaginationListener(
                            isLoading: controller.isLoading,
                            fetchAtEnd: true,
                            onLoadMore: controller.loadMore,
                            child: RefreshIndicator(
                              color: Appcolor.primrycolor,
                              backgroundColor: Colors.transparent,
                              onRefresh: () => controller.fetchProducts(),
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: Custcarouselaliexpriss(
                                      items: [
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                      ],
                                    ),
                                  ),

                                  SliverSpacer(10.h),
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
                                    child: CategoriesList(),
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

                                  HotProductsGrid(),

                                  if (controller.hasMore &&
                                      controller.pageIndex > 1)
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
                    arguments: {"platform": 'aliexpress'},
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
