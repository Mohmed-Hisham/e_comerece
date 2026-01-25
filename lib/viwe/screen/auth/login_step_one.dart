import 'package:e_comerece/controller/auth/login_step_one_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/scroll_when_keyboard_opens.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_3.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_4.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_5.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_right_4.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginStepOne extends StatelessWidget {
  const LoginStepOne({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LLoginStepOneControllerimplment());
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: GetBuilder<LLoginStepOneControllerimplment>(
          builder: (controller) => Stack(
            children: [
              PositionedLeft3(),
              PositionedRight4(),
              PositionedLeft4(),
              PositionedLeft5(),
              Form(
                key: controller.formState,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    spacing: 15.h,
                    children: [
                      SizedBox(height: 510.h),

                      Custtextfeld(
                        focusNode: controller.emailFocus,
                        onTap: () {
                          scrollWhenKeyboardOpens(
                            controller.scrollController,
                            context,
                            200.h,
                          );
                        },
                        controller: controller.email,
                        hint: StringsKeys.emailHint.tr,
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Appcolor.gray,
                        ),
                        validator: (val) {
                          return vlidateInPut(
                            val: val!,
                            min: 6,
                            max: 100,
                            type: ValidateType.email,
                          );
                        },
                      ),

                      Custombuttonauth(
                        inputtext: StringsKeys.next.tr,
                        onPressed: () {
                          controller.emailFocus.unfocus();
                          controller.loginStepOne();
                        },
                      ),

                      Text(StringsKeys.orSignInWith.tr),
                      Container(
                        height: 45.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: BoxDecoration(
                          color: Appcolor.somgray,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            StringsKeys.google.tr,
                            style: TextStyle(
                              color: Appcolor.primrycolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          controller.goToSginup();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(StringsKeys.noAccount.tr),
                            Text(
                              StringsKeys.signUp.tr,
                              style: TextStyle(color: Appcolor.primrycolor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
