import 'package:e_comerece/core/constant/apptheme.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;
  ThemeData themeData = themeEn;

  late MyServises myServises;

  Future<void> changelang(String langcode) async {
    Locale locale = Locale(langcode);
    await myServises.saveSecureData("lang", langcode);
    themeData = langcode == "ar" ? themeAr : themeEn;
    Get.changeTheme(themeData);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    _initLocale();
  }

  Future<void> _initLocale() async {
    if (Get.isRegistered<MyServises>()) {
      myServises = Get.find<MyServises>();
    } else {
      _setLocaleFromPrefs(null);
      return;
    }

    String? shardPrLang = myServises.lang;
    if (shardPrLang == null) {
      final deviceLang = Get.deviceLocale?.languageCode;
      shardPrLang = (deviceLang == "ar") ? "ar" : "en";
      myServises.saveSecureData("lang", shardPrLang);
    }
    _setLocaleFromPrefs(shardPrLang);
  }

  void _setLocaleFromPrefs(String? shardPrLang) {
    if (shardPrLang == "ar") {
      language = const Locale("ar");
      themeData = themeAr.copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: Colors.orange.withValues(alpha: 0.4),
          selectionHandleColor: Colors.orange,
        ),
      );
    } else if (shardPrLang == "en") {
      language = const Locale("en");
      themeData = themeEn.copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: Colors.orange.withValues(alpha: 0.4),
          selectionHandleColor: Colors.orange,
        ),
      );
    } else {
      final deviceLang = Get.deviceLocale?.languageCode ?? "en";
      final isAr = deviceLang == "ar";
      language = Locale(deviceLang);
      themeData = (isAr ? themeAr : themeEn).copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: Colors.orange.withValues(alpha: 0.4),
          selectionHandleColor: Colors.orange,
        ),
      );
    }
  }
}
