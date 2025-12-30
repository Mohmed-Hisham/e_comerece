import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServises extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServises> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initlizserviese() async {
  await Get.putAsync(() => MyServises().init());
}
