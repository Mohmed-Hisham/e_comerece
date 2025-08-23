import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Customtexttitleauth(text: "successResetPasswordTitle".tr),
            const SizedBox(height: 40),
            const Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Appcolor.primrycolor,
                size: 160,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "successResetPasswordBody".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Custombuttonauth(
              inputtext: "goToLogin".tr,
              onPressed: () {
                Get.toNamed(AppRoutesname.login);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
