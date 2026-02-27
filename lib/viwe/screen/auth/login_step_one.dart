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

                      // حقل الإدخال مع prefix ديناميكي للعلم وكود الدولة
                      GetBuilder<LLoginStepOneControllerimplment>(
                        id: 'country_prefix',
                        builder: (ctrl) => Custtextfeld(
                          focusNode: controller.emailFocus,
                          onTap: () {
                            scrollWhenKeyboardOpens(
                              controller.scrollController,
                              context,
                              200.h,
                            );
                          },
                          controller: controller.email,
                          hint: StringsKeys.emailOrPhoneHint.tr,
                          // 🏳️ العلم وكود الدولة (يظهر فقط لو رقم هاتف)
                          prefixIcon: ctrl.detectedCountry != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 5.w,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        ctrl.countryFlag ?? '',
                                        style: TextStyle(fontSize: 20.sp),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        ctrl.countryCode ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Appcolor.gray,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Container(
                                        height: 20.h,
                                        width: 1,
                                        color: Appcolor.gray.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                          suffixIcon: Icon(
                            ctrl.detectedCountry != null
                                ? Icons.phone_android
                                : Icons.person_outline,
                            color: Appcolor.gray,
                          ),
                          validator: (val) {
                            return validateInput(
                              val: val!,
                              min: 6,
                              max: 100,
                              type: ValidateType.emailOrPhone,
                            );
                          },
                        ),
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
                          onPressed: () {
                            controller.signInWithGoogle();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon/google.png',
                                height: 24.h,
                                width: 24.w,
                                errorBuilder: (_, _, _) => Icon(
                                  Icons.g_mobiledata,
                                  color: Appcolor.primrycolor,
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                StringsKeys.google.tr,
                                style: TextStyle(
                                  color: Appcolor.primrycolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
