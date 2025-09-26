import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/favorite/toggleFavorite_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/servises/extract_image_urls.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_for_page_detils_alibaba.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/alibaba/SellerInfo_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/add_to_cart_button_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/attribute_selector_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/custmedia_carousel_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/price_section_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/product_description_html_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/product_properties_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/quantity_section_alibaba.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsAlibabView extends StatelessWidget {
  const ProductDetailsAlibabView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsAlibabaControllerImple());
    // Get.put(AddorrmoveControllerimple());
    AddorrmoveControllerimple cartcontroller = Get.put(
      AddorrmoveControllerimple(),
    );
    Get.put(TogglefavoriteController());
    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),

          Container(
            padding: EdgeInsets.only(top: 65),
            child: GetBuilder<ProductDetailsAlibabaControllerImple>(
              builder: (controller) {
                return Handlingdataviwe(
                  isproductdetails: true,
                  ontryagain: () => controller.fetchProductDetails(),

                  // isSliver: true,
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
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(
                            context,
                            controller,
                            cartcontroller,
                          ),
                        ),
                        ProductForPageDetilsAlibaba(),

                        GetBuilder<ProductDetailsAlibabaControllerImple>(
                          id: 'searshText',
                          builder: (Container) {
                            if (controller.isLoading &&
                                controller.hasMoresearch &&
                                controller.pageIndexSearch > 0) {
                              return SliverToBoxAdapter(
                                child: ShimmerBar(
                                  height: 8,
                                  animationDuration: 1,
                                ),
                              );
                            } else {
                              return SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          PositionedAppBar(title: "Product Details", onPressed: Get.back),
        ],
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    ProductDetailsAlibabaControllerImple controller,
    AddorrmoveControllerimple cartController,
  ) {
    final html =
        controller.productDitelsAliBabaModel?.result?.item?.description?.html ??
        '';
    final images = extractImageUrls(html);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(""),
        CustmediaCarouselAlibaba(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 12),
              _buildAttributesSection(context),
              const SizedBox(height: 16),
              PriceSectionAlibaba(),
              const SizedBox(height: 16),
              QuantitySectionAlibaba(),
              const SizedBox(height: 16),
              AddToCartButtonAlibaba(cartController: cartController),
              const SizedBox(height: 16),
              ProductPropertiesAlibaba(controller: controller),
              const SizedBox(height: 16),
              SellerinfoAlibaba(controller: controller),
              const SizedBox(height: 16),
              ProductDescriptionHtmlAlibaba(images: images),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(
    BuildContext context,
    ProductDetailsAlibabaControllerImple controller,
  ) {
    final subject = controller.subject;
    if (subject == null) return const SizedBox.shrink();
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.productId.toString()] ?? false;
        print("build title");
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

  Widget _buildAttributesSection(
    BuildContext context,
    // ProductDetailsAlibabaControllerImple controller,
  ) {
    // final properties = controller.getAvailableProperties();
    // if (properties.isEmpty) return const SizedBox.shrink();

    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      id: 'selectedAttributes',
      builder: (controller) {
        final properties = controller.getAvailableProperties();
        if (properties.isEmpty) return const SizedBox.shrink();
        String text = '';
        return Column(
          children: List.generate(properties.length, (index) {
            final prop = properties[index];
            if (prop.values.first.image != null &&
                prop.values.first.image != '') {
              text = 'duble tap to see full image';
            }
            return AttributeSelectorAlibaba(
              controller: controller,
              prop: prop,
              text: text,
            );
          }),
        );
      },
    );
  }
}
