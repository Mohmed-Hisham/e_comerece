import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/viwe/widget/amazon/color_variations_widget.dart';
import 'package:e_comerece/viwe/widget/amazon/size_variations_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VariationsSectionWidget extends StatelessWidget {
  final String asin;

  const VariationsSectionWidget({super.key, required this.asin});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      tag: asin,
      id: 'selectedVariations',
      builder: (controller) {
        final dimensions = controller.productVariationsDimensions;
        if (dimensions.isEmpty) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dimensions.contains('color'))
                ColorVariationsWidget(controller: controller),
              if (dimensions.contains('color') && dimensions.contains('size'))
                SizedBox(height: 16.h),
              if (dimensions.contains('size'))
                SizeVariationsWidget(controller: controller),
            ],
          ),
        );
      },
    );
  }
}
