import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/onboarding/custombutton.dart';
import 'package:e_comerece/viwe/widget/onboarding/customdotgenerat.dart';
import 'package:e_comerece/viwe/widget/onboarding/customsider.dart';
import 'package:e_comerece/viwe/widget/onboarding/onboardingtext.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class Onbording extends StatelessWidget {
  const Onbording({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Onboardingcontroolerimplement());
    return Scaffold(
      backgroundColor: Appcolor.primrycolor2,
      body: Column(
        children: [
          Expanded(flex: 2, child: CustomsiderOnboarding()),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  OnboardingText(),
                  SizedBox(height: 10),
                  CustomdotgeneratOnBoarding(),
                  SizedBox(height: 20),
                  CustombuttonOnBoarding(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
