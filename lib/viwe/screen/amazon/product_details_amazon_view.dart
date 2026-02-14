import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/amazon/product_for_page_detils_amazon.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/amazon/add_to_cart_button_amazon.dart';
import 'package:e_comerece/viwe/widget/amazon/product_images_carousel_amazon.dart';
import 'package:e_comerece/viwe/widget/amazon/variations_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';

class ProductDetailsAmazonView extends StatelessWidget {
  const ProductDetailsAmazonView({super.key});
  @override
  Widget build(BuildContext context) {
    final String asin = Get.arguments['asin'];
    Get.put(ProductDetailsAmazonControllerImple(), tag: asin);
    return Scaffold(
      body: GetBuilder<ProductDetailsAmazonControllerImple>(
        tag: asin,
        builder: (controller) {
          return Stack(
            children: [
              const PositionedRight1(),
              const PositionedRight2(),

              Container(
                padding: EdgeInsets.only(top: 110.h),
                child: Handlingdataviwe(
                  isproductdetails: true,
                  ontryagain: () => controller.fetchProductDetails(),
                  statusrequest: controller.statusrequest,
                  widget: PaginationListener(
                    onLoadMore: () {
                      if (controller.loadSearchOne == 0) {
                        controller.searshText();
                        controller.loadSearchOne = 1;
                      } else {
                        controller.loadMoreSearch();
                      }
                    },
                    isLoading: controller.isLoading,

                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: _buildProductDetails(
                                  context,
                                  controller,
                                  asin,
                                ),
                              ),

                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                sliver: ProductForPageDetilsAmazon(tag: asin),
                              ),
                              GetBuilder<ProductDetailsAmazonControllerImple>(
                                tag: asin,
                                id: 'product',
                                builder: (con) {
                                  return SliverToBoxAdapter(
                                    child: ShimmerBar(
                                      height: 10,
                                      animationDuration: 1,
                                    ),
                                  );
                                },
                              ),
                              SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                            ],
                          ),
                        ),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedAppBar(
                title: StringsKeys.productDetailsTitle.tr,
                onPressed: Get.back,
              ),
              AddToCartButtonAmazon(tag: asin),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {
                      "platform": 'alibaba',
                      "link_Product":
                          controller.detailsAmazonModel?.data?.productUrl,
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
    ProductDetailsAmazonControllerImple controller,
    String asin,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImagesCarouselAmazon(tag: asin),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 12),
              VariationsSectionWidget(asin: asin),
              const SizedBox(height: 16),
              _buildPriceSection(context, controller, asin),
              const SizedBox(height: 16),
              _buildProductInfo(context, controller),
              const SizedBox(height: 16),
              _buildProductDescription(context, controller),
              const SizedBox(height: 16),
              _buildReviewsSection(context, controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    final title = controller.productTitle;
    if (title == null) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ),
      ],
    );
  }

  Widget _buildPriceSection(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
    String asin,
  ) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: asin,
      id: 'quantity',
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  controller.getCurrentPriceFormatted(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Appcolor.primrycolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                if (controller.productOriginalPrice != null)
                  Text(
                    controller.getOriginalPriceFormatted(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductInfo(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.productInformation.tr,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (controller.productByline != null)
          _buildInfoRow(StringsKeys.brand.tr, controller.productByline!),
        if (controller.productStarRating != null)
          _buildInfoRow(
            StringsKeys.rating.tr,
            '${controller.productStarRating} ⭐',
          ),
        if (controller.productNumRatings != null)
          _buildInfoRow(
            StringsKeys.reviews.tr,
            '${controller.productNumRatings} ${StringsKeys.reviews.tr}',
          ),
        if (controller.productAvailability != null)
          _buildInfoRow(
            StringsKeys.availability.tr,
            controller.productAvailability!,
          ),
        if (controller.delivery != null)
          _buildInfoRow(StringsKeys.delivery.tr, controller.delivery!),
        if (controller.isPrime == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              StringsKeys.prime.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildProductDescription(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    if (controller.productDescription == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.description.tr,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          controller.productDescription!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (controller.aboutProduct.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsKeys.aboutThisProduct.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...controller.aboutProduct.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('• $item'),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildReviewsSection(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    if (controller.topReviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.topReviews.tr,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...controller.topReviews.map(
          (review) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${review.reviewStarRating} ⭐',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        review.reviewTitle ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  review.reviewComment ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '${StringsKeys.byAuthor.tr} ${review.reviewAuthor} • ${review.reviewDate}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
