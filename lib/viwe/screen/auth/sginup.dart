import 'package:e_comerece/controller/auth/sginup_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/scroll_when_keyboard_opens.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Sginup extends StatelessWidget {
  const Sginup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SginupControllerimplemnt());

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: GetBuilder<SginupControllerimplemnt>(
          builder: (controller) => Form(
            key: controller.formState,
            child: Stack(
              children: [
                PositionedLeft1(),
                PositionedRight3(),

                Positioned(
                  top: 65.h,
                  left: 15.w,
                  child: SizedBox(
                    height: 210.h,
                    width: 210.w,
                    child: Customtexttitleauth(
                      text: StringsKeys.createAccount.tr,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    spacing: 15.h,
                    children: [
                      SizedBox(height: 380.h),
                      Custtextfeld(
                        onTap: () {
                          scrollWhenKeyboardOpens(
                            controller.scrollController,
                            context,
                            270.h,
                          );
                        },
                        focusNode: controller.usernameFocus,
                        controller: controller.username,
                        hint: StringsKeys.usernameHint.tr,
                        validator: (val) {
                          return validateInput(
                            val: val!,
                            min: 3,
                            max: 50,
                            type: ValidateType.username,
                          );
                        },
                      ),
                      Custtextfeld(
                        onTap: () {
                          scrollWhenKeyboardOpens(
                            controller.scrollController,
                            context,
                            270.h,
                          );
                        },
                        hint: StringsKeys.emailHint.tr,
                        controller: controller.email,
                        validator: (val) {
                          return validateInput(
                            val: val!,
                            min: 6,
                            max: 100,
                            type: ValidateType.email,
                          );
                        },
                        focusNode: controller.emailFocus,
                      ),
                      // 📱 حقل الهاتف مع prefix ديناميكي
                      GetBuilder<SginupControllerimplemnt>(
                        id: 'phone_prefix',
                        builder: (ctrl) => Custtextfeld(
                          hint: StringsKeys.phoneHint.tr,
                          controller: controller.phone,
                          validator: (val) {
                            return validateInput(val: val!, min: 9, max: 20);
                          },
                          focusNode: controller.phoneFocus,
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
                            Icons.phone_android,
                            color: ctrl.detectedCountry != null
                                ? Appcolor.primrycolor
                                : Appcolor.gray,
                          ),
                        ),
                      ),
                      Custtextfeld(
                        controller: controller.passowrd,
                        hint: StringsKeys.passwordHint.tr,
                        validator: (val) {
                          return validateInput(val: val!, min: 6, max: 100);
                        },
                        obscureText: controller.visibility,
                        focusNode: controller.passwordFocus,
                        suffixIcon: IconButton(
                          onPressed: () => controller.visibilityFun(),
                          icon: controller.visibility == true
                              ? Icon(
                                  Icons.lock_outline_rounded,
                                  color: Appcolor.gray,
                                )
                              : Icon(
                                  Icons.lock_open_rounded,
                                  color: Appcolor.primrycolor,
                                ),
                        ),
                      ),

                      // 🔄 Switch لاختيار طريقة التحقق
                      GetBuilder<SginupControllerimplemnt>(
                        id: 'verification_switch',
                        builder: (ctrl) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 25.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Appcolor.somgray,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: ctrl.verifyViaPhone
                                  ? Colors.green.withValues(alpha: 0.5)
                                  : Colors.blue.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              // أيقونة
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: ctrl.verifyViaPhone
                                      ? Colors.green.withValues(alpha: 0.15)
                                      : Colors.blue.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  ctrl.verifyViaPhone
                                      ? Icons.phone_android
                                      : Icons.email_outlined,
                                  color: ctrl.verifyViaPhone
                                      ? Colors.green
                                      : Colors.blue,
                                  size: 22.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // النص
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringsKeys.chooseVerificationMethod.tr,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Appcolor.gray,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      ctrl.verifyViaPhone
                                          ? StringsKeys.verifyViaPhone.tr
                                          : StringsKeys.verifyViaEmail.tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ctrl.verifyViaPhone
                                            ? Colors.green
                                            : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Switch
                              Transform.scale(
                                scale: 0.9,
                                child: Switch(
                                  value: ctrl.verifyViaPhone,
                                  onChanged: (_) =>
                                      ctrl.toggleVerificationMethod(),
                                  activeThumbColor: Colors.green,
                                  activeTrackColor: Colors.green.withValues(
                                    alpha: 0.3,
                                  ),
                                  inactiveThumbColor: Colors.blue,
                                  inactiveTrackColor: Colors.blue.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Custombuttonauth(
                        inputtext: StringsKeys.signUp.tr,
                        onPressed: () {
                          controller.sginup();
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
                                errorBuilder: (_, __, ___) => Icon(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(StringsKeys.haveAccount.tr),
                          InkWell(
                            onTap: () {
                              controller.goToSginin();
                            },
                            child: Text(
                              StringsKeys.login.tr,
                              style: TextStyle(color: Appcolor.primrycolor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
