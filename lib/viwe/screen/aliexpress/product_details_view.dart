import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/servises/extract_image_urls.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/aliexpress/poduct_more_ditels.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custattribute_selection.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custbuildpricedisplay.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custbutton_add_cart.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custmedia_carousel.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custpackage_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custstock_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/productdescriptionhtml.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsControllerImple());
    AddorrmoveControllerimple addcontroller = Get.put(
      AddorrmoveControllerimple(),
    );
    Get.put(FavoritesController());
    return Scaffold(
      body: GetBuilder<ProductDetailsControllerImple>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),

              Container(
                padding: EdgeInsets.only(top: 65),
                child: Handlingdataviwe(
                  isproductdetails: true,
                  // shimmer: ShimmerProductDetails(),
                  statusrequest: controller.statusrequest,
                  widget: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo is ScrollUpdateNotification) {
                        if (scrollInfo.metrics.axis == Axis.vertical) {
                          if (!controller.isLoading &&
                              scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.8) {
                            // final pixels = scrollInfo.metrics.pixels;
                            // final max = scrollInfo.metrics.maxScrollExtent;
                            final atEdge = scrollInfo.metrics.atEdge;
                            final pixels = scrollInfo.metrics.pixels;
                            final maxScrollExtent =
                                scrollInfo.metrics.maxScrollExtent;
                            if (atEdge && pixels == maxScrollExtent) {
                              if (controller.loadSearchOne == 0) {
                                controller.searshText();
                                controller.loadSearchOne = 1;
                              } else {
                                controller.loadMoreSearch(
                                  detectLangFromQuery(controller.title!),
                                );
                              }
                            }

                            // if (max > 0 && pixels >= max * 0.8) {
                            //   print("1  ");

                            // }
                          }
                        }
                      }
                      return false;
                    },

                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(context, controller),
                        ),
                        PoductMoreDitels(controller: controller),
                        if (controller.isLoading &&
                            controller.hasMoresearch &&
                            controller.pageIndexSearch > 0)
                          SliverToBoxAdapter(
                            child: ShimmerBar(height: 8, animationDuration: 1),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedAppBar(title: "Product Details", onPressed: Get.back),
              CustbuttonAddCart(addcontroller: addcontroller),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {
                      "platform": 'alibaba',
                      "link_Product":
                          controller.itemDetailsModel?.result?.item?.itemUrl,
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final html =
        controller.itemDetailsModel?.result?.item?.description?.html ?? '';
    final images = extractImageUrls(html);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(""),
        CustmediaCarousel(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 8),
              ImagesCarousel(images: images),
              const SizedBox(height: 8),
              _buildSellerInfo(context, controller),
              const SizedBox(height: 16),
              Custbuildpricedisplay(),
              const SizedBox(height: 16),
              CustattributeSelection(controller: controller),
              const SizedBox(height: 16),
              Custpackageinfo(controller: controller),
              const SizedBox(height: 16),
              CuststockInfo(),
              const SizedBox(height: 16),
              _buildReviews(context, controller),
              const SizedBox(height: 16),
              _buildSpecifications(context, controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final subject = controller.subject;
    if (subject == null) return const SizedBox.shrink();
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.productId.toString()] ?? false;
        return Row(
          children: [
            Expanded(
              child: Text(
                subject,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (isInCart)
              const Icon(Icons.shopping_cart, color: Appcolor.primrycolor),
          ],
        );
      },
    );
  }

  Widget _buildSellerInfo(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final sellerName = controller.sellerName;
    if (sellerName == null) return const SizedBox.shrink();
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            sellerName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildReviews(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final count = controller.reviewsCount;
    final avg = controller.averageStar;
    if (count == null && avg == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        if (avg != null)
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                avg,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Appcolor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        const SizedBox(width: 12),
        if (count != null)
          Text(
            '( $count reviews )',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Widget _buildSpecifications(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final specs = controller.specifications;
    if (specs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specifications', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...specs.map((s) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      s.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Appcolor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        children: [
                          Text(
                            s.value!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Appcolor.black2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Appcolor.gray, endIndent: 20, indent: 20),
            ],
          );
        }).toList(),
      ],
    );
  }
}
