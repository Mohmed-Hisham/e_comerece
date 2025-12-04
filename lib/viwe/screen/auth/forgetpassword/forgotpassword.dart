import 'package:e_comerece/controller/auth/forgetpassword/forgetpassowrd.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/scroll_when_keyboard_opens.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Forgetpassowrdlment());
    return Scaffold(
      body: GetBuilder<Forgetpassowrdlment>(
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
                    SizedBox(height: 130.h),
                    Container(
                      height: 100.h,
                      width: 100.w,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        borderRadius: BorderRadius.circular(110.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(110.r),
                        child: Image.asset(
                          AppImagesassets.avatar,
                          height: 50.h,
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Customtexttitleauth(
                      fontSize: 35.sp,
                      text: StringsKeys.forgotPasswordTitle.tr,
                    ),
                    Customtextbody(text: StringsKeys.forgotPasswordBody.tr),
                    SizedBox(height: 10.h),
                    Custtextfeld(
                      controller: controller.email,
                      focusNode: controller.focus,
                      onTap: () {
                        scrollWhenKeyboardOpens(
                          controller.scrollController,
                          context,
                          60.h,
                        );
                      },
                      hint: StringsKeys.emailHint.tr,
                      validator: (val) => vlidateInPut(
                        val: val!,
                        min: 6,
                        max: 100,
                        type: ValidateType.email,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Custombuttonauth(
                      inputtext: StringsKeys.check.tr,
                      onPressed: () {
                        controller.goToveyfiycode();
                      },
                    ),
                    SizedBox(height: 25.h),
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
