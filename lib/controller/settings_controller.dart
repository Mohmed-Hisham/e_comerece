import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {
  void logout();
  void goToLanguagePage();
  void goToHistryChats();
  void disableNotification();
}

class SettingsControllerImple extends SettingsController {
  MyServises myServises = Get.find();
  bool isNotification = true;

  @override
  logout() {
    final String id = myServises.sharedPreferences.getString('id') ?? "";
    FirebaseMessaging.instance.unsubscribeFromTopic('users');
    FirebaseMessaging.instance.unsubscribeFromTopic('user$id');
    myServises.sharedPreferences.clear();
    Get.offAllNamed(AppRoutesname.loginStepOne);
  }

  @override
  goToLanguagePage() {
    Get.toNamed(AppRoutesname.language);
  }

  @override
  goToHistryChats() {
    Get.toNamed(AppRoutesname.chatsScreen);
  }

  @override
  disableNotification() {
    isNotification = !isNotification;
    update(['notification']);
  }
}
