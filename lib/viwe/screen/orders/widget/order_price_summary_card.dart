import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPriceSummaryCard extends StatelessWidget {
  final double subtotal;
  final double discountAmount;
  final double shippingAmount;
  final double totalAmount;

  const OrderPriceSummaryCard({
    super.key,
    required this.subtotal,
    required this.discountAmount,
    required this.shippingAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'ملخص الطلب',
      icon: Icons.account_balance_wallet,
      children: [
        OrderPriceRow(label: 'المجموع الفرعي', value: subtotal),
        const OrderSectionDivider(),
        OrderPriceRow(label: 'الخصم', value: discountAmount, isDiscount: true),
        const OrderSectionDivider(),
        OrderPriceRow(label: 'الشحن', value: shippingAmount),
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
                'الإجمالي',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.black,
                ),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
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
