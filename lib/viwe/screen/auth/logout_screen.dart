import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/viwe/widget/language/custombuttonlang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsControllerImple>(
      builder: (controller) {
        return Column(
          spacing: 10,
          children: [
            Spacer(),
            Custombuttonlang(
              textbutton: "Logout",
              onPressed: () {
                controller.logout();
              },
            ),

            Custombuttonlang(
              textbutton: "Cancel",
              onPressed: () {
                Get.back();
              },
            ),

            SizedBox(height: 40.h),
          ],
        );
      },
    );
  }
}
