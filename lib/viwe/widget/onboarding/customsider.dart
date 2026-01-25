import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/static/static.dart';
import 'package:e_comerece/viwe/widget/onboarding/custombutton.dart';
import 'package:e_comerece/viwe/widget/onboarding/onboardingtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomsiderOnboarding extends GetView<Onboardingcontroolerimplement> {
  const CustomsiderOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
        color: Appcolor.fourcolor,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),

      width: double.infinity,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.onPageChanged(value);
        },
        itemCount: onborardinglist.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(130),
                    bottomRight: Radius.circular(130),
                  ),
                  child: Image.asset(
                    onborardinglist[index].image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Expanded(child: OnboardingText()),
              index == 2
                  ? CustombuttonOnBoarding(
                      title: StringsKeys.gotIt.tr,
                      onTap: () {
                        controller.next();
                      },
                    )
                  : SizedBox(),
              SizedBox(height: 10.h),
            ],
          );
        },
      ),
    );
  }
}
