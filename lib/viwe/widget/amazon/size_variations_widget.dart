import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SizeVariationsWidget extends StatelessWidget {
  final ProductDetailsAmazonControllerImple controller;

  const SizeVariationsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final sizes = controller.getAvailableSizes();
    if (sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.straighten_outlined,
              size: 20.sp,
              color: Appcolor.primrycolor,
            ),
            SizedBox(width: 6.w),
            Text(
              StringsKeys.size.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (controller.selectedVariations['size'] != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Appcolor.primrycolor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  controller.selectedVariations['size']!,
                  style: TextStyle(
                    color: Appcolor.primrycolor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: sizes.map((size) {
            final isSelected = controller.isVariationSelected('size', size);
            final isLoading = controller.loadingVariationValue == size;

            return GestureDetector(
              onTap: () => controller.updateSelectedVariation('size', size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? Appcolor.primrycolor
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  color: isSelected
                      ? Appcolor.primrycolor.withValues(alpha: 0.08)
                      : Colors.white,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Appcolor.primrycolor.withValues(alpha: 0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected && !isLoading)
                      Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: Icon(
                          Icons.check_circle,
                          size: 16.sp,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    Text(
                      size,
                      style: TextStyle(
                        color: isSelected
                            ? Appcolor.primrycolor
                            : Colors.grey.shade800,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                    if (isLoading) ...[
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 14.w,
                        height: 14.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
