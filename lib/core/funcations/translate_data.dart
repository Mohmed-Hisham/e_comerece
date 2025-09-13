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

String enOrAr() {
  MyServises myServises = Get.find();
  if (myServises.sharedPreferences.getString("lang") == "ar") {
    return "ar_MA";
  } else {
    return "en_US";
  }
}

String detectLangFromQuery(String query) {
  final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  return hasArabic ? 'ar_MA' : 'en_US';
}
