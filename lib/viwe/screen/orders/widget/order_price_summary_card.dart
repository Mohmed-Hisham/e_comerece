import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderPriceSummaryCard extends StatelessWidget {
  final double subtotal;
  final double discountAmount;
  final double? productReviewFee;
  final double? deliveryTips;
  final double totalAmount;

  const OrderPriceSummaryCard({
    super.key,
    required this.subtotal,
    required this.discountAmount,
    this.productReviewFee,
    this.deliveryTips,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: StringsKeys.orderSummary.tr,
      icon: Icons.account_balance_wallet,
      children: [
        OrderPriceRow(label: StringsKeys.subtotal.tr, value: subtotal),
        if (discountAmount > 0) ...[
          const OrderSectionDivider(),
          OrderPriceRow(
            label: StringsKeys.discount.tr,
            value: discountAmount,
            isDiscount: true,
          ),
        ],
        if (productReviewFee != null && productReviewFee! > 0) ...[
          const OrderSectionDivider(),
          OrderPriceRow(
            label: StringsKeys.reviewFeeLabel.tr,
            value: productReviewFee!,
          ),
        ],
        if (deliveryTips != null && deliveryTips! > 0) ...[
          const OrderSectionDivider(),
          OrderPriceRow(label: StringsKeys.tipsLabel.tr, value: deliveryTips!),
        ],
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Appcolor.primrycolor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringsKeys.totalAmount.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.black,
                ),
              ),
              Text(
                Get.find<CurrencyService>().convertAndFormat(
                  amount: totalAmount,
                  from: 'USD',
                ),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.primrycolor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
