import 'package:e_comerece/core/servises/serviese.dart';
import 'package:get/get.dart';

translateData(columnen, columnar) {
  MyServises myServises = Get.find();
  if (myServises.sharedPreferences.getString("lang") == "ar") {
    return columnar;
  } else {
    return columnen;
  }
}

String enOrAr({bool isArSA = false}) {
  MyServises myServises = Get.find();
  if (myServises.sharedPreferences.getString("lang") == "ar") {
    return isArSA ? "ar_SA" : "ar_MA";
  } else {
    return "en_US";
  }
}

String detectLangFromQuery(String query, {bool isArSA = false}) {
  final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  if (isArSA && hasArabic) {
    return 'ar_SA';
  } else if (!isArSA && hasArabic) {
    return 'ar_MA';
  } else {
    return 'en_US';
  }
}

String detectLangFromQueryAmazon(String query) {
  final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  if (hasArabic) {
    return 'ar_AE';
  } else {
    return 'en_AE';
  }
}

String enOrArAmazon() {
  MyServises myServises = Get.find();
  if (myServises.sharedPreferences.getString("lang") == "ar") {
    return "ar_AE";
  } else {
    return "en_AE";
  }
}

bool langDirection() {
  MyServises myServises = Get.find();
  return myServises.sharedPreferences.getString("lang") != "ar";
}
