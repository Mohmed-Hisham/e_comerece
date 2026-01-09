import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> successDialog({
  required String title,
  required String body,
  required void Function() onBack,
  required void Function() onHome,
}) {
  return Get.defaultDialog(
    title: "",
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    backgroundColor: Colors.white,
    radius: 25.sp,
    barrierDismissible: false,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Success Icon
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 20.h),

        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
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

        // Buttons
        Row(
          children: [
            // Back Button
            Expanded(
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Appcolor.somgray,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: MaterialButton(
                  onPressed: onBack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Text(
                    StringsKeys.back.tr,
                    style: TextStyle(
                      color: Appcolor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Home Button
            Expanded(
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Appcolor.primrycolor,
                  borderRadius: BorderRadius.circular(15.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolor.primrycolor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: onHome,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Text(
                    "Home", // Fallback for Home
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
