import 'package:e_comerece/controller/auth/forgetpassword/verifycode_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Veryfiycode extends StatelessWidget {
  const Veryfiycode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeControllerImp controller = Get.put(VerifycodeControllerImp());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          SingleChildScrollView(
            child: Column(
              spacing: 15.h,
              children: [
                SizedBox(height: 140.h),
                Custavatar(),
                Customtexttitleauth(
                  fontSize: 35.sp,
                  text: StringsKeys.verifyCodeTitle.tr,
                ),
                Customtextbody(text: StringsKeys.verifyCodeBody.tr),
                SizedBox(height: 10.h),
                OtpTextField(
                  focusedBorderColor: Appcolor.primrycolor,
                  fillColor: Appcolor.primrycolor,
                  fieldWidth: 60.w,
                  borderRadius: BorderRadius.circular(20.r),
                  numberOfFields: 5,
                  borderColor: Appcolor.primrycolor,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    controller.ckeckCode(verificationCode);
                  },
                ),

                SizedBox(height: 15.h),
                CustButtonBotton(
                  title: StringsKeys.back.tr,
                  onTap: controller.goback,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
