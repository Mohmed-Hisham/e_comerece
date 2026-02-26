import 'package:e_comerece/controller/our_products/our_product_details_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/helper/hepler.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/related_product_card.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/shimmer_related_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RelatedProductsSection extends StatelessWidget {
  final CurrencyService currencyService;
  final String tag;

  const RelatedProductsSection({
    super.key,
    required this.currencyService,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OurProductDetailsController>(
      tag: tag,
      id: 'relatedProducts',
      builder: (controller) {
        if (controller.relatedProducts.isEmpty &&
            controller.relatedProductsStatus != Statusrequest.loading) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            buildHeader(),
            SizedBox(height: 12.h),
            _buildProductsList(controller),
          ],
        );
      },
    );
  }

  Widget _buildProductsList(OurProductDetailsController controller) {
    return SizedBox(
      height: 260.h,
      child: controller.relatedProductsStatus == Statusrequest.loading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: 5, // Number of shimmer items
                itemBuilder: (context, index) {
                  return const ShimmerRelatedProductCard();
                },
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount:
                  controller.relatedProducts.length +
                  (controller.hasMoreRelated ? 1 : 0),
              itemBuilder: (context, index) {
                // Load more when reaching the end
                if (index >= controller.relatedProducts.length) {
                  if (controller.isLoadingMore) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        itemCount: 5, // Number of shimmer items
                        itemBuilder: (context, index) {
                          return const ShimmerRelatedProductCard();
                        },
                      ),
                    );
                  }
                  controller.loadMoreRelatedProducts();
                  return const SizedBox.shrink();
                }

                return RelatedProductCard(
                  product: controller.relatedProducts[index],
                  currencyService: currencyService,
                );
              },
            ),
    );
  }
}
