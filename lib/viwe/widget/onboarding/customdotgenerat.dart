import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomdotgeneratOnBoarding extends StatelessWidget {
  const CustomdotgeneratOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Onboardingcontroolerimplement>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ...List.generate(
            onborardinglist.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 5),
              duration: const Duration(milliseconds: 900),
              width: controller.currentpage == index ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: Appcolor.primrycolor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
