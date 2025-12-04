import 'package:e_comerece/core/servises/notifcation_service.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:e_comerece/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
