import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsHeader extends StatelessWidget {
  final String title;

  const OrderDetailsHeader({super.key, this.title = 'تفاصيل الخدمة'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
