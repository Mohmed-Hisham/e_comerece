import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/animations.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_home_alibaba.dart';
import 'package:e_comerece/viwe/screen/alibaba/search_name_alibaba.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/alibaba/custcarousel_alibaba.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAlibaba extends StatelessWidget {
  const HomeAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductAlibabaHomeControllerImp());
    Get.put(FavoritesController());
    Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      body: GetBuilder<ProductAlibabaHomeControllerImp>(
        builder: (controller) {
          return Stack(
            children: [
              const PositionedRight1(),
              const PositionedRight2(),
              PositionedAppBar(title: "Alibaba", onPressed: Get.back),

              Column(
                children: [
                  const SizedBox(height: 65),
                  // مكان Custshearchappbar في Column:
                  GetBuilder<ProductAlibabaHomeControllerImp>(
                    id: 'initShow',
                    builder: (controller) {
                      return SlideUpFade(
                        visible: controller.initShow,

                        offsetY: -0.40,
                        child: Custshearchappbar(
                          mycontroller: controller.searchController,
                          onChanged: (val) {
                            controller.onChangeSearch(val);
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
                            // shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchNameAlibaba(controller: controller),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo is ScrollUpdateNotification) {
                                if (scrollInfo.metrics.axis == Axis.vertical) {
                                  if (!controller.isLoading &&
                                      controller.hasMore) {
                                    final atEdge = scrollInfo.metrics.atEdge;
                                    final pixels = scrollInfo.metrics.pixels;
                                    final maxScrollExtent =
                                        scrollInfo.metrics.maxScrollExtent;
                                    if (atEdge && pixels == maxScrollExtent) {
                                      controller.loadMoreproduct();
                                    }
                                  }
                                }
                              }
                              return false;
                            },
                            child: RefreshIndicator(
                              onRefresh: () => controller.fethcProducts(),
                              child: CustomScrollView(
                                slivers: [
                                  GetBuilder<ProductAlibabaHomeControllerImp>(
                                    id: 'initShow',
                                    builder: (controllerr) {
                                      return SliverToBoxAdapter(
                                        child: FadeScaleTransition(
                                          visible: controller.initShow,
                                          child: CustcarouselAlibaba(
                                            items: [
                                              AppImagesassets.tset,
                                              AppImagesassets.tset,
                                              AppImagesassets.tset,
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // const SliverToBoxAdapter(
                                  //   child: Padding(
                                  //     padding: EdgeInsets.symmetric(
                                  //       horizontal: 8.0,
                                  //     ),
                                  //     child: Text(
                                  //       'Hot Deals',
                                  //       style: TextStyle(
                                  //         fontSize: 22,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Appcolor.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SliverToBoxAdapter(
                                  //   child: SeetingsAlibaba(),
                                  // ),
                                  const SliverToBoxAdapter(
                                    child: SizedBox(height: 16),
                                  ),
                                  if (controller.statusrequestproduct ==
                                      Statusrequest.loading)
                                    const SliverToBoxAdapter(
                                      child: SizedBox(height: 70),
                                    ),

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
