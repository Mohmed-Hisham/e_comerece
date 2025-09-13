import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/static/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class OnBoardingControoler extends GetxController {
  next();
  onPageChanged(int index);
}

class Onboardingcontroolerimplement extends OnBoardingControoler {
  late PageController pageController;
  int currentpage = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  MyServises myServises = Get.find();

  @override
  next() {
    currentpage++;
    if (currentpage > onborardinglist.length - 1) {
      Get.offAllNamed(AppRoutesname.homepage);
      myServises.sharedPreferences.setString("step", "2");
    } else {
      pageController.animateToPage(
        currentpage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  onPageChanged(int index) {
    currentpage = index;
    update();
  }
}
