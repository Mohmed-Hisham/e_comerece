import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/CheckOut/checkout_controller.dart';
import '../../../../core/constant/color.dart';
import 'package:e_comerece/core/servises/currency_service.dart';

class CheckoutPriceBreakdownCard extends StatelessWidget {
  const CheckoutPriceBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutControllerImpl>(
      id: 'breakdown',
      builder: (controller) {
        final currencyService = Get.find<CurrencyService>();
        final subtotal = controller.getSubtotal();
        final fees = controller.isReviewFeeEnabled
            ? controller.reviewFeeAmount
            : 0.0;
        // final discount = controller.discountAmount;
        // Delivery Fee mockup (should be in controller)

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
          child: Column(
            children: [
              _buildRow(
                StringsKeys.subtotal.tr,
                currencyService.convertAndFormat(amount: subtotal, from: 'USD'),
              ),

              if (controller.isReviewFeeEnabled)
                _buildRow(
                  StringsKeys.reviewFeeLabel.tr,
                  "\$${fees.toStringAsFixed(2)}",
                ),

              if (controller.discountAmount > 0)
                _buildRow(
                  "${StringsKeys.promocodeDiscount.tr} (${controller.discountPercentage}%)",
                  currencyService.convertAndFormat(
                    amount: controller.discountAmount,
                    from: 'USD',
                  ),
                ),

              if (controller.selectedTip > 0)
                _buildRow(
                  StringsKeys.tipsLabel.tr,
                  "\$${controller.selectedTip.toStringAsFixed(2)}",
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
        ],
      ),
    );
  }
}
