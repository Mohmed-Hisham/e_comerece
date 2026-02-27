import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/widget_shared/animations.dart';
import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:e_comerece/core/shared/widget_shared/slider_shimmer.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_alibaba_home.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_aliexpriess_home.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_amazon.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_shein.dart';
import 'package:e_comerece/viwe/screen/home/our_products_home_section.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/home/home_search_bar.dart';
import 'package:e_comerece/viwe/widget/home/home_platforms_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(FavoritesController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          GetBuilder<HomescreenControllerImple>(
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(height: 60.h),
                  GetBuilder<HomescreenControllerImple>(
                    id: 'initShow',
                    builder: (controller) {
                      return SlideUpFade(
                        visible: controller.initShow,
                        offsetY: -0.40,
                        child: HomeSearchBar(
                          favoriteOnPressed: () => controller.goToFavorit(),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: Appcolor.primrycolor,
                      backgroundColor: Colors.transparent,
                      onRefresh: () => controller.refreshHomePage(),
                      child: PaginationListener(
                        onLoadMore: () => controller.loadMoreOurProducts(),
                        fetchAtEnd: true,
                        isLoading: controller.isLoadingMoreOurProducts,
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: GetBuilder<HomescreenControllerImple>(
                                id: 'slider',
                                builder: (controller) {
                                  if (controller.statusRequestSlider ==
                                      Statusrequest.loading) {
                                    return const SliderShimmer();
                                  }
                                  return Custcarouselslider(
                                    currentIndex: controller.currentIndex,
                                    onPageChanged: (index, reason) {
                                      controller.indexchange(index);
                                    },
                                    items: controller.sliders
                                        .map((e) => e.imageUrl ?? "")
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                            SliverSpacer(12.h),
                            const HomePlatformsSection(),
                            SliverSpacer(20.h),

                            const HotProductAliexpriessHome(),
                            SliverSpacer(10.h),

                            const HotProductAlibabaHome(),
                            SliverSpacer(10.h),

                            const HotProductAmazon(),
                            SliverSpacer(10.h),
                            const HotProductShein(),
                            SliverSpacer(10.h),
                            const OurProductsHomeSection(),
                            SliverSpacer(100.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          PositionedSupport(
            onPressed: () {
              Get.toNamed(
                AppRoutesname.messagesScreen,
                arguments: {"platform": 'home'},
              );
            },
          ),
        ],
      ),
    );
  }
}
