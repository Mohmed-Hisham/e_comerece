import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_3.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_4.dart';
import 'package:e_comerece/viwe/widget/onboarding/customdotgenerat.dart';
import 'package:e_comerece/viwe/widget/onboarding/customsider.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class Onbording extends StatelessWidget {
  const Onbording({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Onboardingcontroolerimplement());
    return Scaffold(
      backgroundColor: Appcolor.primrycolor2,
      body: Stack(
        children: [
          PositionedLeft3(),
          PositionedLeft4(),
          Column(
            children: [
              SizedBox(height: 70),
              Expanded(flex: 2, child: CustomsiderOnboarding()),

              SizedBox(height: 30),
              CustomdotgeneratOnBoarding(),
              SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
