import 'package:e_comerece/core/constant/apptheme.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;
  ThemeData themeData = themeEn;

  MyServises myServises = Get.find();

  changelang(String langcode) {
    Locale locale = Locale(langcode);
    myServises.sharedPreferences.setString("lang", langcode);
    themeData = langcode == "ar" ? themeAr : themeEn;
    Get.changeTheme(themeData);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    String? shardPrLang = myServises.sharedPreferences.getString("lang");
    if (shardPrLang == "ar") {
      language = const Locale("ar");
      themeData = themeAr;
    } else if (shardPrLang == "en") {
      language = const Locale("en");
      themeData = themeEn;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      themeData = themeEn;
    }
  }
}
