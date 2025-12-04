import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/animations.dart';
import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_alibaba_home.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_aliexpriess_home.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_amazon.dart';
import 'package:e_comerece/viwe/screen/home/hot_product_shein.dart';
import 'package:e_comerece/viwe/screen/home/search_home_view.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:e_comerece/viwe/widget/home/cust_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(HomescreenControllerImple());
    Get.put(FavoritesController());
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),

          GetBuilder<HomescreenControllerImple>(
            builder: (controller) {
              return Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    GetBuilder<HomescreenControllerImple>(
                      id: 'initShow',
                      builder: (controller) {
                        return SlideUpFade(
                          visible: controller.initShow,
                          offsetY: -0.40,
                          child: Custshearchappbar(
                            mycontroller: controller.searchController,
                            onChanged: (val) {
                              controller.onChangeSearch(val);
                              controller.whenstartSearch(val);
                            },
                            onTapSearch: () {
                              if (formkey.currentState!.validate()) {
                                controller.searshAll();
                              }
                            },
                            showClose: controller.showClose,
                            favoriteOnPressed: () {
                              controller.goToFavorit();
                            },

                            onTapClose: () {
                              controller.onCloseSearch();
                            },
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: controller.isSearch
                          ? SearchHomeView()
                          : CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              slivers: <Widget>[
                                SliverToBoxAdapter(
                                  child: Custcarouselslider(
                                    items: [
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                    ],
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(height: 12.h),
                                ),
                                SliverToBoxAdapter(
                                  child: GridView(
                                    addRepaintBoundaries: true,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 10.w,
                                          mainAxisExtent: 95.h,
                                          mainAxisSpacing: 10.w,
                                        ),
                                    children: [
                                      InkWell(
                                        onTap: () => Get.toNamed(
                                          AppRoutesname.homeSheinView,
                                        ),
                                        child: CustCntainer(
                                          text: "Shein",
                                          fontsize: 22.sp,
                                          color: const Color(0xFF455A2D),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Get.toNamed(
                                          AppRoutesname.homepagealibaba,
                                        ),
                                        child: CustCntainer(
                                          text: "Alibaba",
                                          fontsize: 22.sp,
                                          color: const Color(0xFFDFA672),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutesname.homepage1);
                                        },
                                        child: CustCntainer(
                                          fontsize: 16.sp,
                                          text: "AliExpress",
                                          color: const Color(0xFF1A6572),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Get.toNamed(
                                          AppRoutesname.homeAmazonView,
                                        ),

                                        child: CustCntainer(
                                          fontsize: 20.sp,
                                          text: "Amazon",
                                          color: const Color(0xFF917D55),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SliverSpacer(20.h),

                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(
                                        text: StringsKeys.bestFromAliexpress.tr,
                                      ),
                                    ],
                                  ),
                                ),

                                SliverToBoxAdapter(
                                  child: HotProductAliexpriessHome(),
                                ),

                                SliverSpacer(10.h),
                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(
                                        text: StringsKeys.bestFromAlibaba.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: HotProductAlibabaHome(),
                                ),
                                SliverSpacer(10.h),
                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(
                                        text: StringsKeys.hotDealsFromAmazon.tr,
                                      ),
                                    ],
                                  ),
                                ),

                                SliverToBoxAdapter(child: HotProductAmazon()),
                                SliverSpacer(10.h),
                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(
                                        text: StringsKeys
                                            .trendingProductsFromShein
                                            .tr,
                                      ),
                                    ],
                                  ),
                                ),

                                SliverToBoxAdapter(child: HotProductShein()),
                                SliverSpacer(100.h),
                              ],
                            ),
                    ),
                  ],
                ),
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
