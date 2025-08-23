import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/viwe/widget/language/custombuttonlang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLanguage extends GetView<LocaleController> {
  const MyLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            "chooseLang".tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Custombuttonlang(
            textbutton: "Ar",
            onPressed: () {
              controller.changelang("ar");
              Get.toNamed(AppRoutesname.onBoarding);
            },
          ),
          Custombuttonlang(
            textbutton: "En",
            onPressed: () {
              controller.changelang("en");
              Get.toNamed(AppRoutesname.onBoarding);
            },
          ),
        ],
      ),
    );
  }
}
