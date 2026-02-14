import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerRelatedProductCard extends StatelessWidget {
  const ShimmerRelatedProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for image
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: Appcolor.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for product name
                Container(height: 16.h, width: 120.w, color: Appcolor.black),
                SizedBox(height: 8.h),
                // Shimmer for price
                Container(height: 14.h, width: 80.w, color: Appcolor.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
