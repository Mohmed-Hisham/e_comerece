import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingText extends GetView<Onboardingcontroolerimplement> {
  const OnboardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Onboardingcontroolerimplement>(
      builder: (controller) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Column(
          key: ValueKey<int>(controller.currentpage),
          children: [
            SizedBox(height: 10),
            Text(
              onborardinglist[controller.currentpage].title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Appcolor.black,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                onborardinglist[controller.currentpage].body!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,

                  color: Appcolor.black2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
