import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/toggle_favorite_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/screen/amazon/product_for_page_detils_amazon.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/amazon/product_images_carousel_amazon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:e_comerece/core/constant/strings_keys.dart';

class ProductDetailsAmazonView extends StatelessWidget {
  const ProductDetailsAmazonView({super.key});
  @override
  Widget build(BuildContext context) {
    final String asin = Get.arguments['asin'];
    Get.put(ProductDetailsAmazonControllerImple(), tag: asin);
    // Get.put(AddorrmoveControllerimple());
    AddorrmoveControllerimple cartcontroller = Get.put(
      AddorrmoveControllerimple(),
    );
    Get.put(TogglefavoriteController());
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
                  widget: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo is ScrollUpdateNotification) {
                        if (scrollInfo.metrics.axis == Axis.vertical) {
                          if (!controller.isLoading &&
                              scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.8) {
                            final atEdge = scrollInfo.metrics.atEdge;
                            final pixels = scrollInfo.metrics.pixels;
                            final maxScrollExtent =
                                scrollInfo.metrics.maxScrollExtent;
                            if (atEdge && pixels == maxScrollExtent) {
                              if (controller.loadSearchOne == 0) {
                                controller.searshText();
                                controller.loadSearchOne = 1;
                              } else {
                                controller.loadMoreSearch();
                              }
                            }
                          }
                        }
                      }
                      return false;
                    },

                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(
                            context,
                            controller,
                            cartcontroller,
                            asin,
                          ),
                        ),

                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                ),
              ),
              PositionedAppBar(
                title: StringsKeys.productDetailsTitle.tr,
                onPressed: Get.back,
              ),
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
    AddorrmoveControllerimple cartController,
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
              _buildVariationsSection(context, controller, asin),
              const SizedBox(height: 16),
              _buildPriceSection(context, controller, asin),
              const SizedBox(height: 16),
              _buildQuantitySection(context, controller, asin),
              const SizedBox(height: 16),
              _buildAddToCartButton(context, controller, cartController, asin),
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
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.asin.toString()] ?? false;
        return Row(
          children: [
            Expanded(
              child: Text(
                title,
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

  Widget _buildVariationsSection(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
    String asin,
  ) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: asin,
      id: 'selectedVariations',
      builder: (controller) {
        final dimensions = controller.productVariationsDimensions;
        if (dimensions.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color variations
            if (dimensions.contains('color'))
              _buildColorVariations(context, controller),
            const SizedBox(height: 12),
            // Size variations
            if (dimensions.contains('size'))
              _buildSizeVariations(context, controller),
          ],
        );
      },
    );
  }

  Widget _buildColorVariations(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    final colors = controller.productVariations?.color ?? [];
    if (colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.colorVariationInstruction.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors.map((color) {
            final isSelected = controller.isVariationSelected(
              'color',
              color.value!,
            );
            return InkWell(
              onDoubleTap: () => openFullImage(context, color.photo ?? ''),
              onTap: () =>
                  controller.updateSelectedVariation('color', color.value!),
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Appcolor.primrycolor : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? Appcolor.primrycolor.withValues(alpha: 0.1)
                      : null,
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: color.photo ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const Loadingimage(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        color.value!,
                        style: TextStyle(
                          color: isSelected
                              ? Appcolor.primrycolor
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeVariations(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
  ) {
    final sizes = controller.getAvailableSizes();
    if (sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.size.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: sizes.map((size) {
            final isSelected = controller.isVariationSelected('size', size);
            return GestureDetector(
              onTap: () => controller.updateSelectedVariation('size', size),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Appcolor.primrycolor : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? Appcolor.primrycolor.withValues(alpha: 0.1)
                      : null,
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Appcolor.primrycolor : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
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
            const SizedBox(height: 4),
            if (controller.couponDiscountPercentage != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${controller.couponDiscountPercentage}% ${StringsKeys.off.tr}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildQuantitySection(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
    String asin,
  ) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: asin,
      id: 'quantity',
      builder: (controller) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  StringsKeys.quantity.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.decrementQuantity,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      controller.quantity.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: controller.incrementQuantity,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  StringsKeys.totalPrice.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                Text(
                  controller.getTotalPriceFormatted(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Appcolor.primrycolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddToCartButton(
    BuildContext context,
    ProductDetailsAmazonControllerImple controller,
    AddorrmoveControllerimple cartController,
    String asin,
  ) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: asin,
      id: 'quantity',
      builder: (controller) {
        return SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    cartController.add(
                      controller.getCurrentAsin() ?? '',
                      controller.productTitle ?? '',
                      controller.productPhoto ?? '',
                      controller.getRawUsdPrice(),
                      'Amazon',
                      controller.quantity,
                      jsonEncode(controller.selectedVariations),
                      1000, // Available quantity - you might want to get this from API
                      tier: '',
                      porductink: controller.productUrl ?? '',
                    );
                    controller.incart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isInCart
                        ? Appcolor.black2
                        : Appcolor.primrycolor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    controller.isInCart
                        ? StringsKeys.updateCart.tr
                        : StringsKeys.addToCart.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GetBuilder<TogglefavoriteController>(
                builder: (favoritesController) {
                  favoritesController.currentStatus = controller.isFavorite;
                  return IconButton(
                    onPressed: () {
                      controller.changisfavorite();
                      favoritesController.toggleFavorite(
                        controller.getCurrentAsin() ?? '',
                        controller.productTitle ?? '',
                        controller.productPhoto ?? '',
                        controller.getRawUsdPrice().toString(),
                        "Amazon",
                      );
                    },
                    icon: FaIcon(
                      controller.isFavorite
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: controller.isFavorite
                          ? Appcolor.reed
                          : Appcolor.reed,
                    ),
                  );
                },
              ),
            ],
          ),
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
