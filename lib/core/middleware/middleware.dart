import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  MyServises myServises = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (myServises.step == "2") {
      return const RouteSettings(name: AppRoutesname.homepage);
    }
    if (myServises.step == "1") {
      return const RouteSettings(name: AppRoutesname.login);
    }
    return null;
    // return const RouteSettings(name: AppRoutesname.onBoarding);
  }
}
