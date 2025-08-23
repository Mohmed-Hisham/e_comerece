import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {
  logout();
}

class SettingsControllerImple extends SettingsController {
  MyServises myServises = Get.find();

  @override
  logout() {
    myServises.sharedPreferences.clear();
    Get.offAllNamed(AppRoutesname.login);
  }
}
