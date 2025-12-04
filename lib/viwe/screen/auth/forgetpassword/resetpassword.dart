import 'package:e_comerece/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/scroll_when_keyboard_opens.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ResetpasswordIemeent());
    return Scaffold(
      body: GetBuilder<ResetpasswordIemeent>(
        builder: (controller) => Form(
          key: controller.formState,
          child: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: controller.scrollController,
                child: Column(
                  spacing: 15.h,
                  children: [
                    SizedBox(height: 140.h),
                    Custavatar(),
                    Customtexttitleauth(
                      fontSize: 35.sp,
                      text: StringsKeys.resetPasswordTitle.tr,
                    ),
                    Customtextbody(text: StringsKeys.resetPasswordBody.tr),
                    SizedBox(height: 10.h),
                    Custtextfeld(
                      onTap: () {
                        scrollWhenKeyboardOpens(
                          controller.scrollController,
                          context,
                          100.h,
                        );
                      },
                      focusNode: controller.passFocus,
                      controller: controller.passWord,
                      hint: StringsKeys.passwordHint.tr,
                      validator: (val) {
                        return vlidateInPut(val: val!, min: 6, max: 100);
                      },
                    ),
                    Custtextfeld(
                      focusNode: controller.repassFocus,
                      controller: controller.repassWord,
                      hint: StringsKeys.confirmPasswordHint.tr,
                      validator: (val) {
                        return vlidateInPut(val: val!, min: 6, max: 100);
                      },
                    ),
                    SizedBox(height: 10.h),

                    Custombuttonauth(
                      inputtext: StringsKeys.save.tr,
                      onPressed: () {
                        controller.resetPassword();
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
        ),
      ),
    );
  }
}
