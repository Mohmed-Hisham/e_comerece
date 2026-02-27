import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ColorVariationsWidget extends StatelessWidget {
  final ProductDetailsAmazonControllerImple controller;

  const ColorVariationsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = controller.productVariations?.color ?? [];
    if (colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.palette_outlined,
              size: 20.sp,
              color: Appcolor.primrycolor,
            ),
            SizedBox(width: 6.w),
            Text(
              StringsKeys.colorVariationInstruction.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (controller.selectedVariations['color'] != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Appcolor.primrycolor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  controller.selectedVariations['color']!,
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
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: colors.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final color = colors[index];
              final isSelected = controller.isVariationSelected(
                'color',
                color.value!,
              );
              final isLoading = controller.loadingVariationValue == color.value;

              return GestureDetector(
                onDoubleTap: () => openFullImage(context, color.photo ?? ''),
                onTap: () =>
                    controller.updateSelectedVariation('color', color.value!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? Appcolor.primrycolor
                          : Colors.grey.shade300,
                      width: isSelected ? 2.5 : 1,
                    ),
                    color: isSelected
                        ? Appcolor.primrycolor.withValues(alpha: 0.08)
                        : Colors.white,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Appcolor.primrycolor.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: CustomCachedImage(
                              imageUrl: color.photo ?? '',
                              // radius: 1.r,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 2.w,
                            ),
                            child: Text(
                              color.value!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Appcolor.primrycolor
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Loading overlay
                      if (isLoading)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Appcolor.primrycolor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Selected checkmark
                      if (isSelected && !isLoading)
                        Positioned(
                          top: 4.h,
                          right: 4.w,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: const BoxDecoration(
                              color: Appcolor.primrycolor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
