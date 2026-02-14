import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartItemInfo extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onShowMore;

  const CartItemInfo({
    super.key,
    required this.title,
    required this.price,
    required this.onShowMore,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Appcolor.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Text(
            price,
            style: TextStyle(
              color: Appcolor.primrycolor,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              fontFamily: "asian",
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: onShowMore,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Appcolor.primrycolor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: Appcolor.primrycolor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                "more".tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Appcolor.primrycolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
