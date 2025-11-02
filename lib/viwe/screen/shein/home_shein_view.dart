import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/screen/shein/categories_shein.dart';
import 'package:e_comerece/viwe/screen/shein/search_shein_viwe.dart';
import 'package:e_comerece/viwe/screen/shein/trending_product_shein.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:e_comerece/viwe/widget/shein/cust_carouse_shein.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSheinView extends StatelessWidget {
  const HomeSheinView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeSheinControllerImpl());
    Get.put(FavoritesController());
    // Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      body: GetBuilder<HomeSheinControllerImpl>(
        builder: (controller) {
          print("build");
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: "SHEIN", onPressed: Get.back),

              Column(
                children: [
                  SizedBox(height: 65),
                  Custshearchappbar(
                    mycontroller: controller.searchController,
                    onChanged: (val) {
                      controller.onChangeSearch(val);
                    },
                    onTapSearch: () {
                      controller.onTapSearch();
                    },
                    favoriteOnPressed: () {
                      controller.goTofavorite();
                    },
                    imageOnPressed: () {
                      // controller.goToSearchByimage();
                    },
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            // shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchSheinViwe(controller: controller),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo is ScrollUpdateNotification) {
                                if (scrollInfo.metrics.axis == Axis.vertical) {
                                  // if (!controller.isLoading &&
                                  //     controller.hasMoreproduct) {
                                  //   final atEdge = scrollInfo.metrics.atEdge;
                                  //   final pixels = scrollInfo.metrics.pixels;
                                  //   final maxScrollExtent =
                                  //       scrollInfo.metrics.maxScrollExtent;
                                  //   if (atEdge && pixels == maxScrollExtent) {
                                  //     controller.loadMore();
                                  //   }
                                  // }
                                }
                              }
                              return false;
                            },
                            child: CustomScrollView(
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: CustCarouseShein(
                                    items: [
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                      AppImagesassets.tset,
                                    ],
                                  ),
                                ),

                                SliverToBoxAdapter(
                                  child: Row(
                                    children: [
                                      CustLabelContainer(text: 'Categories'),
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
                                      CustLabelContainer(text: 'Trending'),
                                    ],
                                  ),
                                ),

                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 16),
                                ),
                                TrendingProductShein(),

                                // if (controller.hasMoreproduct &&
                                //     controller.pageindex > 0)
                                //   const SliverToBoxAdapter(
                                //     child: ShimmerBar(
                                //       height: 8,
                                //       animationDuration: 1,
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
