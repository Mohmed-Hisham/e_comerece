import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessSignUpView extends StatelessWidget {
  const SuccessSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                spacing: 15.h,
                children: [
                  SizedBox(height: 140.h),

                  Custavatar(),
                  Customtexttitleauth(
                    fontSize: 30.sp,
                    text: StringsKeys.successSignUpTitle.tr,
                  ),

                  Text(
                    StringsKeys.successSignUpBody.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Appcolor.primrycolor,
                      size: 90.r,
                    ),
                  ),

                  Custombuttonauth(
                    inputtext: StringsKeys.goToLogin.tr,
                    onPressed: () {
                      Get.offAllNamed(AppRoutesname.loginStepOne);
                    },
                  ),
                  SizedBox(height: 25.h),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
