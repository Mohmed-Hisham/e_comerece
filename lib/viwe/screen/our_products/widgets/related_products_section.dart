import 'package:e_comerece/controller/our_products/our_product_details_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/related_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RelatedProductsSection extends StatelessWidget {
  final CurrencyService currencyService;

  const RelatedProductsSection({super.key, required this.currencyService});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OurProductDetailsController>(
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
            _buildHeader(controller),
            SizedBox(height: 12.h),
            _buildProductsList(controller),
          ],
        );
      },
    );
  }

  Widget _buildHeader(OurProductDetailsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringsKeys.relatedProducts.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          if (controller.hasMoreRelated)
            TextButton(
              onPressed: () {
                // Navigate to see all related products
              },
              child: Text(
                StringsKeys.seeAll.tr,
                style: TextStyle(fontSize: 14.sp, color: Appcolor.primrycolor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductsList(OurProductDetailsController controller) {
    return SizedBox(
      height: 260.h,
      child: controller.relatedProductsStatus == Statusrequest.loading
          ? Center(
              child: CircularProgressIndicator(color: Appcolor.primrycolor),
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
                    return _buildLoadingIndicator();
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

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CircularProgressIndicator(
          color: Appcolor.primrycolor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
