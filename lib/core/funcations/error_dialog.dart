import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> errorDialog(String title, String body) {
  return Get.defaultDialog(
    title: "",
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    backgroundColor: Colors.white,
    radius: 25.sp,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Error Icon
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: Appcolor.reed.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.error_outline_rounded,
            color: Appcolor.reed,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 20.h),

        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.black,
          ),
        ),
        SizedBox(height: 10.h),

        // Message
        Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Appcolor.gray, height: 1.5),
        ),
        SizedBox(height: 30.h),

        // OK Button
        Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            color: Appcolor.primrycolor,
            borderRadius: BorderRadius.circular(15.sp),
            boxShadow: [
              BoxShadow(
                color: Appcolor.primrycolor.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: MaterialButton(
            onPressed: () {
              Get.back();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Text(
              StringsKeys.gotIt.tr, // Reusing "Got it" or could be "OK"
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
