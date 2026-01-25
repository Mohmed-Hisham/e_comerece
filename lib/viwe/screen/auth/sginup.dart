import 'package:e_comerece/controller/auth/sginup_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
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
import 'package:flutter_svg/svg.dart';
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
                  top: 275.h,
                  left: 35.w,
                  child: SvgPicture.asset(
                    AppImagesassets.shapcamera,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Appcolor.primrycolor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
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
                            200.h,
                          );
                        },
                        focusNode: controller.usernameFocus,
                        controller: controller.username,
                        hint: StringsKeys.usernameHint.tr,
                        validator: (val) {
                          return vlidateInPut(
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
                            200.h,
                          );
                        },
                        hint: StringsKeys.emailHint.tr,
                        controller: controller.email,
                        validator: (val) {
                          return vlidateInPut(
                            val: val!,
                            min: 6,
                            max: 100,
                            type: ValidateType.email,
                          );
                        },
                        focusNode: controller.emailFocus,
                      ),
                      Custtextfeld(
                        hint: StringsKeys.phoneHint.tr,
                        controller: controller.phone,
                        validator: (val) {
                          return vlidateInPut(val: val!, min: 10, max: 20);
                        },
                        focusNode: controller.phoneFocus,
                      ),
                      Custtextfeld(
                        controller: controller.passowrd,
                        hint: StringsKeys.passwordHint.tr,
                        validator: (val) {
                          return vlidateInPut(val: val!, min: 6, max: 100);
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

                      Custombuttonauth(
                        inputtext: StringsKeys.signUp.tr,
                        onPressed: () {
                          controller.sginup();
                        },
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
