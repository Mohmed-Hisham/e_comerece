import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/our_products/our_products_search_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OurProductsSearchView extends StatelessWidget {
  const OurProductsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OurProductsSearchController());

    return Scaffold(
      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildSearchBar(),
                SizedBox(height: 10.h),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GetBuilder<OurProductsSearchController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              // Back button
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Appcolor.black,
                  size: 22.sp,
                ),
              ),
              // Search field
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Appcolor.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    focusNode: controller.focusNode,
                    onChanged: controller.onSearchChanged,
                    onSubmitted: (_) => controller.executeSearch(),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: StringsKeys.searchInOurProducts.tr,
                      hintStyle: TextStyle(
                        color: Appcolor.gray,
                        fontSize: 14.sp,
                      ),
                      prefixIcon: IconButton(
                        onPressed: controller.executeSearch,
                        icon: Icon(
                          Icons.search,
                          color: Appcolor.primrycolor,
                          size: 22.sp,
                        ),
                      ),
                      suffixIcon: controller.searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: controller.clearSearch,
                              icon: Icon(
                                Icons.close,
                                color: Appcolor.gray,
                                size: 20.sp,
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return GetBuilder<OurProductsSearchController>(
      id: 'suggestions',
      builder: (controller) {
        // Show suggestions if typing and no search results yet
        if (controller.showSuggestions) {
          return _buildSuggestions(controller);
        }

        return GetBuilder<OurProductsSearchController>(
          id: 'search',
          builder: (searchController) {
            // Show search results
            if (searchController.searchStatus == Statusrequest.loading) {
              return _buildLoadingShimmer();
            }

            if (searchController.searchStatus == Statusrequest.noData) {
              return _buildNoResults();
            }

            if (searchController.searchStatus == Statusrequest.success) {
              return _buildSearchResults(searchController);
            }

            // Initial state - show hint
            return _buildInitialHint();
          },
        );
      },
    );
  }

  Widget _buildSuggestions(OurProductsSearchController controller) {
    if (controller.suggestionsStatus == Statusrequest.loading) {
      return _buildSuggestionsShimmer();
    }

    if (controller.suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.suggestions.length,
      itemBuilder: (context, index) {
        final product = controller.suggestions[index];
        return _buildSuggestionItem(product, controller);
      },
    );
  }

  Widget _buildSuggestionItem(
    LocalProductModel product,
    OurProductsSearchController controller,
  ) {
    final currencyService = Get.find<CurrencyService>();

    return InkWell(
      onTap: () {
        // Navigate directly to product details
        Get.toNamed(
          AppRoutesname.ourProductDetails,
          arguments: {'product': product},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 60.w,
                height: 60.w,
                child: CustomCachedImage(
                  imageUrl: product.mainImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Appcolor.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        currencyService.convertAndFormat(
                          amount: product.discountPrice ?? product.price ?? 0,
                          from: 'USD',
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        SizedBox(width: 8.w),
                        Text(
                          currencyService.convertAndFormat(
                            amount: product.price ?? 0,
                            from: 'USD',
                          ),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Appcolor.gray,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Arrow icon
            Icon(Icons.arrow_forward_ios, color: Appcolor.gray, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsShimmer() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.h,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.h),
                      Container(height: 12.h, width: 80.w, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(OurProductsSearchController controller) {
    final currencyService = Get.find<CurrencyService>();

    return GridView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.58,
      ),
      itemCount: controller.searchResults.length + (controller.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= controller.searchResults.length) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: CircularProgressIndicator(
                color: Appcolor.primrycolor,
                strokeWidth: 2,
              ),
            ),
          );
        }

        final product = controller.searchResults[index];

        return InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutesname.ourProductDetails,
              arguments: {'product': product},
            );
          },
          borderRadius: BorderRadius.circular(15.r),
          child: Custgridviwe(
            image: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomCachedImage(imageUrl: product.mainImage ?? ""),
            ),
            disc: product.discountPercent != null
                ? "${product.discountPercent}%"
                : null,
            title: product.title ?? "",
            price: currencyService.convertAndFormat(
              amount: product.discountPrice ?? product.price ?? 0,
              from: 'USD',
            ),
            icon: GetBuilder<FavoritesController>(
              builder: (favController) {
                final productId = product.id?.toString() ?? "";
                bool isFav = favController.isFavorite[productId] ?? false;

                return IconButton(
                  onPressed: () {
                    favController.toggleFavorite(
                      productId,
                      product.title ?? "",
                      product.mainImage ?? "",
                      (product.discountPrice ?? product.price ?? 0).toString(),
                      "LocalProduct",
                      categoryid: product.categoryId?.toString(),
                    );
                  },
                  icon: FaIcon(
                    isFav
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: Appcolor.reed,
                    size: 20.sp,
                  ),
                );
              },
            ),
            discprice: product.hasDiscount
                ? currencyService.convertAndFormat(
                    amount: product.price ?? 0,
                    from: 'USD',
                  )
                : null,
            countsall: product.stockQuantity != null
                ? "${StringsKeys.inStock.tr}: ${product.stockQuantity}"
                : null,
          ),
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.58,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80.sp,
            color: Appcolor.gray.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            StringsKeys.noProductsFound.tr,
            style: TextStyle(color: Appcolor.gray, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialHint() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80.sp,
            color: Appcolor.gray.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            StringsKeys.searchInOurProducts.tr,
            style: TextStyle(color: Appcolor.gray, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            "اكتب حرفين على الأقل للبحث",
            style: TextStyle(
              color: Appcolor.gray.withOpacity(0.7),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
