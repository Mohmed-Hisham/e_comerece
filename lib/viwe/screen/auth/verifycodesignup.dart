import 'package:e_comerece/controller/auth/veirfycodesignup_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Verifycodesignup extends StatelessWidget {
  const Verifycodesignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifycodesignupControllerImp());
    return Scaffold(
      body: GetBuilder<VerifycodesignupControllerImp>(
        builder: (controller) => Stack(
          children: [
            PositionedRight1(),
            PositionedRight2(),
            SingleChildScrollView(
              child: Column(
                spacing: 15.h,
                children: [
                  SizedBox(height: 140.h),

                  Container(
                    height: 100.h,
                    width: 100.w,
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Appcolor.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        height: 50.h,
                        width: 50.w,
                        AppImagesassets.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Customtexttitleauth(
                    fontSize: 30.sp,

                    text: StringsKeys.verifyCodeTitle.tr,
                  ),
                  Customtextbody(text: StringsKeys.verifyCodeBody.tr),
                  SizedBox(height: 5.h),
                  OtpTextField(
                    enabledBorderColor: Appcolor.black,
                    focusedBorderColor: Appcolor.primrycolor,
                    fillColor: Appcolor.primrycolor,
                    fieldWidth: 50.w,
                    borderRadius: BorderRadius.circular(15.r),
                    numberOfFields: 5,
                    borderColor: Appcolor.primrycolor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.goTosuccesssginup(verificationCode);
                    },
                  ),
                  SizedBox(height: 15.h),

                  InkWell(
                    onTap: () {
                      controller.resend();
                    },
                    child: Center(
                      child: Text(
                        StringsKeys.resendVerifyCode.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19.sp,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustButtonBotton(
                    onTap: () {
                      controller.goTOSignup();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
