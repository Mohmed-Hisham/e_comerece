import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';

import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/extract_image_urls.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_for_page_detils_alibaba.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/alibaba/add_to_cart_button_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/attribute_selector_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/custmedia_carousel_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/price_section_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/product_description_html_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/product_properties_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/quantity_section_alibaba.dart';
import 'package:e_comerece/viwe/widget/alibaba/seller_info_alibaba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsAlibabView extends StatelessWidget {
  const ProductDetailsAlibabView({super.key});
  @override
  Widget build(BuildContext context) {
    String? productId = Get.arguments['product_id']?.toString();
    Get.put(ProductDetailsAlibabaControllerImple(), tag: productId);
    Get.put(AddorrmoveControllerimple());
    return Scaffold(
      body: GetBuilder<ProductDetailsAlibabaControllerImple>(
        tag: productId,
        builder: (controller) {
          return Stack(
            children: [
              const PositionedRight1(),
              const PositionedRight2(),

              Container(
                padding: EdgeInsets.only(top: 85.h),
                child: Handlingdataviwe(
                  isproductdetails: true,
                  ontryagain: () => controller.fetchProductDetails(),
                  statusrequest: controller.statusrequest,
                  widget: PaginationListener(
                    isLoading: controller.isLoading,
                    onLoadMore: () {
                      if (controller.loadSearchOne == 0) {
                        controller.searshText();
                        controller.loadSearchOne = 1;
                      } else {
                        controller.loadMoreSearch(
                          detectLangFromQuery(controller.title!),
                        );
                      }
                    },
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(
                            context,
                            controller,
                            productId,
                          ),
                        ),
                        ProductForPageDetilsAlibaba(tag: productId),

                        GetBuilder<ProductDetailsAlibabaControllerImple>(
                          tag: productId,
                          id: 'searshText',
                          builder: (controller) {
                            if (controller.isLoading &&
                                controller.hasMoresearch &&
                                controller.pageIndexSearch > 1) {
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
                ),
              ),
              PositionedAppBar(
                title: StringsKeys.productDetailsTitle.tr,
                onPressed: Get.back,
              ),
              AddToCartButtonAlibaba(tag: productId),

              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {
                      "platform": 'alibaba',
                      "link_Product":
                          controller
                              .productDitelsAliBabaModel
                              ?.result
                              ?.item
                              ?.itemUrl ??
                          "",
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
    ProductDetailsAlibabaControllerImple controller,
    String? tag,
  ) {
    final html =
        controller.productDitelsAliBabaModel?.result?.item?.description?.html ??
        '';
    final images = extractImageUrls(html);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(""),
        CustmediaCarouselAlibaba(tag: tag),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller, tag),
              const SizedBox(height: 12),
              _buildAttributesSection(context, tag),
              const SizedBox(height: 16),
              PriceSectionAlibaba(tag: tag),
              const SizedBox(height: 16),
              QuantitySectionAlibaba(tag: tag),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ProductPropertiesAlibaba(controller: controller, tag: tag),
              const SizedBox(height: 16),
              SellerinfoAlibaba(controller: controller, tag: tag),
              const SizedBox(height: 16),
              ProductDescriptionHtmlAlibaba(images: images, tag: tag),
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
    String? tag,
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

  Widget _buildAttributesSection(BuildContext context, String? tag) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      tag: tag,
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
              text = StringsKeys.doubleTapImageInstruction.tr;
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
