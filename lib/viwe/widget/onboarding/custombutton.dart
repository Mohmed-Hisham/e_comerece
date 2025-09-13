import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustombuttonOnBoarding extends GetView<Onboardingcontroolerimplement> {
  final void Function()? onTap;
  final String title;
  const CustombuttonOnBoarding({this.onTap, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 170,

      decoration: BoxDecoration(
        color: Appcolor.primrycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          title.tr,
          style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
