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
    return "ar";
  } else {
    return "en";
  }
}
