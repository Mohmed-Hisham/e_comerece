import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingsControllerImple>(
        id: 'profile',
        builder: (controller) => Form(
          key: controller.formState,
          child: Stack(
            children: [
              PositionedLeft1(),
              PositionedRight3(),

              SingleChildScrollView(
                child: Column(
                  spacing: 15.h,
                  children: [
                    SizedBox(height: 380.h),

                    // Show shimmer while loading, actual fields when done
                    if (controller.profileStatus == Statusrequest.loading)
                      ..._buildShimmerFields()
                    else ...[
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
                    ],

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

  List<Widget> _buildShimmerFields() {
    return [_ShimmerField(), _ShimmerField(), _ShimmerButton()];
  }
}

class _ShimmerField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

class _ShimmerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Appcolor.primrycolor.withValues(alpha: 0.3),
        highlightColor: Appcolor.primrycolor.withValues(alpha: 0.1),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
