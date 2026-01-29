import 'package:e_comerece/core/constant/apptheme.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  Locale? language;
  ThemeData themeData = themeEn;

  late MyServises myServises;

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
    _initLocale();
  }

  Future<void> _initLocale() async {
    // جلب MyServises بشكل آمن
    if (Get.isRegistered<MyServises>()) {
      myServises = Get.find<MyServises>();
    } else {
      // fallback: استخدم SharedPreferences مباشرة
      final prefs = await SharedPreferences.getInstance();
      _setLocaleFromPrefs(prefs.getString("lang"));
      return;
    }

    String? shardPrLang = myServises.sharedPreferences.getString("lang");
    _setLocaleFromPrefs(shardPrLang);
  }

  void _setLocaleFromPrefs(String? shardPrLang) {
    if (shardPrLang == "ar") {
      language = const Locale("ar");
      themeData = themeAr.copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // لون الكيرسور
          selectionColor: Colors.orange.withValues(
            alpha: 0.4,
          ), // لون خلفية التحديد
          selectionHandleColor: Colors.orange, // لون المقبض اللي يمسك التحديد
        ),
      );
    } else if (shardPrLang == "en") {
      language = const Locale("en");
      themeData = themeEn.copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // لون الكيرسور
          selectionColor: Colors.orange.withValues(
            alpha: 0.4,
          ), // لون خلفية التحديد
          selectionHandleColor: Colors.orange, // لون المقبض اللي يمسك التحديد
        ),
      );
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      themeData = themeEn.copyWith(
        scaffoldBackgroundColor: Appcolor.white2,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // لون الكيرسور
          selectionColor: Colors.orange.withValues(
            alpha: 0.4,
          ), // لون خلفية التحديد
          selectionHandleColor: Colors.orange, // لون المقبض اللي يمسك التحديد
        ),
      );
    }
  }
}
