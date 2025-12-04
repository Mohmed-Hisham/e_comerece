import 'package:e_comerece/controller/auth/login_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/scroll_when_keyboard_opens.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_3.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_4.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerimplment());
    return Scaffold(
      body: GetBuilder<LoginControllerimplment>(
        builder: (controller) => Stack(
          children: [
            PositionedLeft3(),
            PositionedLeft4(),

            Form(
              key: controller.formState,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  spacing: 15.h,
                  children: [
                    SizedBox(height: 160.h),

                    Container(
                      height: 90.h,
                      width: 90.w,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        borderRadius: BorderRadius.circular(110.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(110.r),
                        child: Image.asset(
                          height: 50.h,
                          width: 50.w,
                          AppImagesassets.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringsKeys.hello.tr,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                        ),
                        Text(
                          " ${controller.name}!!",
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                        ),
                      ],
                    ),

                    GetBuilder<LoginControllerimplment>(
                      builder: (cont) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Custtextfeld(
                          focusNode: controller.focus,
                          onTap: () {
                            scrollWhenKeyboardOpens(
                              controller.scrollController,
                              context,
                              110.h,
                            );
                          },
                          obscureText: controller.visibility,
                          controller: controller.passowrd,
                          hint: StringsKeys.passwordHint.tr,
                          suffixIcon: IconButton(
                            onPressed: () => controller.visibilityFun(),

                            icon: controller.visibility == true
                                ? Icon(
                                    Icons.lock_outline_rounded,
                                    color: Appcolor.gray,
                                    size: 25.sp,
                                  )
                                : Icon(
                                    Icons.lock_open_rounded,
                                    color: Appcolor.primrycolor,
                                    size: 25.sp,
                                  ),
                          ),
                          validator: (val) {
                            return vlidateInPut(val: val!, min: 6, max: 100);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    InkWell(
                      onTap: () {
                        controller.focus.unfocus();
                        controller.goToForgetpassword();
                      },
                      child: Text(
                        StringsKeys.forgotPassword.tr,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Custombuttonauth(
                      inputtext: StringsKeys.next.tr,
                      onPressed: () {
                        controller.login();
                      },
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              color: Appcolor.primrycolor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Appcolor.white,
                              size: 30.sp,
                            ),
                          ),
                          SizedBox(width: 15.w),

                          Text(
                            StringsKeys.notYou.tr,
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
