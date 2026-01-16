import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Row(
            children: [
              // Info Icon Button
              InkWell(
                onTap: () => controller.showReviewFeeInfo(context),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                    size: 22.sp,
                  ),
                ),
              ),
              // Fee Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.reviewFeeData!.key ??
                          StringsKeys.reviewService.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '\$${controller.reviewFeeAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Appcolor.primrycolor,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),

              // Switch
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: controller.isReviewFeeEnabled,
                  onChanged: controller.toggleReviewFee,
                  activeThumbColor: Appcolor.primrycolor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
