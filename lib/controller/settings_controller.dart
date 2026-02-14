import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/user_profile/user_profile_repo_impl.dart';
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
  void fetchUserProfile();
}

class SettingsControllerImple extends SettingsController {
  UserProfileRepoImpl userProfileRepo = UserProfileRepoImpl(
    apiService: Get.find(),
  );
  MyServises myServises = Get.find();
  bool isNotification = true;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Statusrequest profileStatus = Statusrequest.none;
  String profileName = '';
  String profilePhone = '';

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  logout() async {
    FirebaseMessaging.instance.unsubscribeFromTopic('users');
    await myServises.clearAllSecureData();
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
  fetchUserProfile() async {
    profileStatus = Statusrequest.loading;
    update(['profile']);

    var response = await userProfileRepo.getUserProfile();

    profileStatus = response.fold(
      (failure) {
        showCustomGetSnack(isGreen: false, text: failure.errorMessage);
        return Statusrequest.failuer;
      },
      (profileResponse) {
        if (profileResponse.success == true && profileResponse.data != null) {
          profileName = profileResponse.data!.name ?? '';
          profilePhone = profileResponse.data!.phone ?? '';
          nameController.text = profileName;
          phoneController.text = profilePhone;
          return Statusrequest.success;
        }
        return Statusrequest.failuer;
      },
    );

    update(['profile']);
  }

  @override
  goToUpdateProfile() async {
    fetchUserProfile();
    Get.to(() => const UpdateProfile());
  }

  @override
  updateProfile() async {
    if (formState.currentState!.validate()) {
      profileStatus = Statusrequest.loading;
      update(['profile']);

      final response = await userProfileRepo.updateUserProfile(
        name: nameController.text,
        phone: phoneController.text,
      );

      profileStatus = response.fold(
        (failure) {
          showCustomGetSnack(isGreen: false, text: failure.errorMessage);
          return Statusrequest.failuer;
        },
        (profileResponse) {
          if (profileResponse.success == true && profileResponse.data != null) {
            profileName = profileResponse.data!.name ?? '';
            profilePhone = profileResponse.data!.phone ?? '';
            myServises.saveSecureData("phone", profilePhone);
            myServises.saveSecureData("username", profileName);
            showCustomGetSnack(
              isGreen: true,
              text: profileResponse.message ?? StringsKeys.updateSuccess.tr,
            );
            Get.back();
            return Statusrequest.success;
          }
          return Statusrequest.failuer;
        },
      );

      update(['profile']);
    }
  }
}
