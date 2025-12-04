import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustombuttonOnBoarding extends GetView<Onboardingcontroolerimplement> {
  final void Function()? onTap;
  final String title;
  const CustombuttonOnBoarding({this.onTap, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Appcolor.primrycolor,
        borderRadius: BorderRadius.circular(25.sp),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          title.tr,
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.w800,
            fontSize: 19.sp,
          ),
        ),
      ),
    );
  }
}
