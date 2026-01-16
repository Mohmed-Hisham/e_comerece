import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:e_comerece/viwe/screen/settings/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {
  void logout();
  void goToLanguagePage();
  void goToHistryChats();
  void disableNotification();
  void goToUpdateProfile();
  void updateProfile();
}

class SettingsControllerImple extends SettingsController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  MyServises myServises = Get.find();
  bool isNotification = true;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  logout() {
    final String id = myServises.sharedPreferences.getString('id') ?? "";

    FirebaseMessaging.instance.unsubscribeFromTopic('users');
    FirebaseMessaging.instance.unsubscribeFromTopic('user$id');
    myServises.sharedPreferences.clear();
    myServises.clearAllSecureData();
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

  @override
  goToUpdateProfile() async {
    nameController = TextEditingController(
      text: await myServises.getSecureData("username") ?? "",
    );
    phoneController = TextEditingController(
      text: await myServises.getSecureData("phone") ?? "",
    );
    Get.to(() => const UpdateProfile());
  }

  @override
  updateProfile() async {
    if (formState.currentState!.validate()) {
      final authData = AuthData(
        name: nameController.text,
        phone: phoneController.text,
        token: await myServises.getSecureData("token") ?? "",
      );

      final response = await authRepoImpl.updateUser(authData);
      response.fold(
        (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
        (r) {
          myServises.saveSecureData("phone", phoneController.text);
          myServises.saveSecureData("username", nameController.text);
          showCustomGetSnack(
            isGreen: true,
            text: r.message ?? StringsKeys.updateSuccess.tr,
          );
          Get.back();
        },
      );
    }
  }
}
