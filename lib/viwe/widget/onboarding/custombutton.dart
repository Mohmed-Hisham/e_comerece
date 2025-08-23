import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustombuttonOnBoarding extends GetView<Onboardingcontroolerimplement> {
  const CustombuttonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      margin: EdgeInsets.only(bottom: 50),

      // padding: EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(
        color: Appcolor.primrycolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MaterialButton(
        onPressed: () {
          controller.next();
        },
        child: Text(
          "continue".tr,
          style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
