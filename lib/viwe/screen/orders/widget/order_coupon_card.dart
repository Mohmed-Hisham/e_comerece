import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/ordres/order_details_model.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCouponCard extends StatelessWidget {
  final OrderCoupon coupon;

  const OrderCouponCard({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: StringsKeys.discountCoupon.tr,
      icon: Icons.local_offer,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Appcolor.primrycolor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Appcolor.primrycolor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    coupon.couponName ?? StringsKeys.couponCode.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '-\$${coupon.couponDiscount ?? 0}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff4CAF50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
