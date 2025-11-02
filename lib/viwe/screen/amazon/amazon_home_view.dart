import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/sliver_divder.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/aliexpress/categories_list.dart';
import 'package:e_comerece/viwe/screen/aliexpress/hot_products_grid.dart';
import 'package:e_comerece/viwe/screen/aliexpress/search_name.dart';
import 'package:e_comerece/viwe/screen/amazon/categories_amazon_viwe.dart';
import 'package:e_comerece/viwe/screen/amazon/hot_products_amazon_view.dart';
import 'package:e_comerece/viwe/screen/amazon/others_product_amazon.dart';
import 'package:e_comerece/viwe/screen/amazon/search_amazon_view.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/amazon/cust_carousel_amazon.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmazonHomeView extends StatelessWidget {
  const AmazonHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AmazonHomeControllerImpl());
    Get.put(FavoritesController());
    // Get.lazyPut(() => ImageManagerController());

    return Scaffold(
      body: GetBuilder<AmazonHomeControllerImpl>(
        builder: (controller) {
          print("build");
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: "Amazon", onPressed: Get.back),

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
                  ),

                  Expanded(
                    child: controller.isSearch
                        ? Handlingdataviwe(
                            // shimmer: ShimmerGrideviwe(),
                            statusrequest: controller.statusrequestsearch,
                            widget: SearchAmazonView(controller: controller),
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
                                      if (controller.firstShowOther) {
                                        controller.otherProducts();
                                        controller.firstShowOther = false;
                                      } else {
                                        controller.loadMoreOtherProduct();
                                      }
                                    }
                                  }
                                }
                              }
                              return false;
                            },
                            child: RefreshIndicator(
                              onRefresh: () =>
                                  controller.fetchHomePageData(isrefresh: true),
                              child: CustomScrollView(
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: CustCarouselAmazon(
                                      items: [
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                        AppImagesassets.tset,
                                      ],
                                    ),
                                  ),
                                  const SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(text: 'Categories'),
                                      ],
                                    ),
                                  ),
                                  const SliverSpacer(8),
                                  const SliverToBoxAdapter(
                                    child: CategoriesAmazonViwe(),
                                  ),

                                  const SliverDivider(10),
                                  const SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(text: 'Hot Deals'),
                                      ],
                                    ),
                                  ),
                                  const SliverSpacer(8),
                                  HotProductsAmazonView(),
                                  const SliverSpacer(15),

                                  const SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        CustLabelContainer(text: 'Others'),
                                      ],
                                    ),
                                  ),
                                  const SliverSpacer(8),
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
            ],
          );
        },
      ),
    );
  }
}
