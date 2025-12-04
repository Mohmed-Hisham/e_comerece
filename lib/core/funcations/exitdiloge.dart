import 'dart:io';

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<bool> exitDiloge() {
  Get.defaultDialog(
    title: "",
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    backgroundColor: Colors.white.withValues(alpha: 0.9),
    radius: 25.sp,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Warning Icon
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: Appcolor.primrycolor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.exit_to_app_rounded,
            color: Appcolor.primrycolor,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 20.h),

        // Title
        Text(
          StringsKeys.exitDialogTitle.tr,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.black,
          ),
        ),
        SizedBox(height: 10.h),

        // Message
        Text(
          StringsKeys.exitDialogMessage.tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Appcolor.gray, height: 1.5),
        ),
        SizedBox(height: 30.h),

        // Buttons Row
        Row(
          children: [
            // Cancel Button
            Expanded(
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Appcolor.somgray,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Text(
                    StringsKeys.cancel.tr,
                    style: TextStyle(
                      color: Appcolor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.w),

            // Exit Button
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
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {
                    exit(0);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Text(
                    StringsKeys.exit.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
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
  return Future.value(true);
}
