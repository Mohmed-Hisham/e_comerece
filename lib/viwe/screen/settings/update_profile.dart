import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingsControllerImple>(
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
                    text: StringsKeys.updateProfile.tr,
                  ),
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  spacing: 15.h,
                  children: [
                    SizedBox(height: 380.h),
                    Custtextfeld(
                      controller: controller.nameController,
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
                      hint: StringsKeys.phoneHint.tr,
                      controller: controller.phoneController,
                      validator: (val) {
                        return validateInput(val: val!, min: 10, max: 20);
                      },
                    ),
                    Custombuttonauth(
                      inputtext: StringsKeys.update.tr,
                      onPressed: () {
                        controller.updateProfile();
                      },
                    ),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
              PositionedAppBar(
                title: StringsKeys.updateProfile.tr,
                onPressed: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
