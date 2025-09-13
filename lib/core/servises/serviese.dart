import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServises extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServises> init() async {
    await Firebase.initializeApp();
    Get.put(FavoriteAnimationController());

    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initlizserviese() async {
  await Get.putAsync(() => MyServises().init());
}
