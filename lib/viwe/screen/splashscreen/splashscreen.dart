import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/onboarding/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 35.w),
              child: Image.asset(
                AppImagesassets.applogo,
                width: 250.w,
                height: 150.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            StringsKeys.appName.tr,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
            ),
          ),

          SizedBox(height: 150.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: CustombuttonOnBoarding(
              onTap: () {
                Get.toNamed(AppRoutesname.sginin);
              },
              title: StringsKeys.letsGetStarted,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutesname.loginStepOne);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringsKeys.alreadyHaveAccount.tr,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(width: 5.w),

                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: Appcolor.primrycolor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Appcolor.white,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
