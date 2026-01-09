import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewFeeCard extends StatelessWidget {
  const ReviewFeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutControllerImpl>(
      id: 'reviewFee',
      builder: (controller) {
        if (controller.reviewFeeData == null) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Appcolor.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: controller.isReviewFeeEnabled
                  ? Appcolor.primrycolor
                  : Appcolor.gray.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Info Icon Button
              InkWell(
                onTap: () => controller.showReviewFeeInfo(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Appcolor.primrycolor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Appcolor.primrycolor,
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Fee Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.reviewFeeData!.key ?? 'Review Service',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${controller.reviewFeeAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.primrycolor,
                        fontFamily: 'asian',
                      ),
                    ),
                  ],
                ),
              ),

              // Switch
              Transform.scale(
                scale: 1.1,
                child: Switch(
                  value: controller.isReviewFeeEnabled,
                  onChanged: controller.toggleReviewFee,
                  activeColor: Appcolor.primrycolor,
                  activeTrackColor: Appcolor.primrycolor.withValues(alpha: 0.3),
                  inactiveThumbColor: Appcolor.gray,
                  inactiveTrackColor: Appcolor.gray.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
