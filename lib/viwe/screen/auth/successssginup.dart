import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSignUpView extends StatelessWidget {
  const SuccessSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(height: 130),

                  Custavatar(),
                  Customtexttitleauth(
                    fontSize: 30,
                    text: "successSignUpTitle".tr,
                  ),

                  Text(
                    "successSignUpBody".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Appcolor.primrycolor,
                      size: 90,
                    ),
                  ),

                  Custombuttonauth(
                    inputtext: "goToLogin".tr,
                    onPressed: () {
                      Get.offAllNamed(AppRoutesname.loginStepOne);
                    },
                  ),
                  const SizedBox(height: 30),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
