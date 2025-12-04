import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationInfoShimmer extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;
  final double height;
  const LocationInfoShimmer({
    super.key,
    required this.borderRadius,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20.h,
                    width: 120.w,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                height: 15.h,
                width: 200.w,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 10.h),
              Container(
                height: 15.h,
                width: 150.w,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 10.h),
              Container(
                height: 15.h,
                width: 180.w,
                color: Colors.grey.shade300,
              ),
              const Spacer(),
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
