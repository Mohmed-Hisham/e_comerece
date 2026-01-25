import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/funcations/sanitize_topic.dart';
import 'package:flutter/material.dart';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/string_const.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

abstract class VeirfycodesignupController extends GetxController {
  resend();
  goTosuccesssginup(String verifycodeSignup);
  goTOSignup();
}

class VerifycodesignupControllerImp extends VeirfycodesignupController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;

  String? email;
  @override
  goTosuccesssginup(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    final response = await authRepoImpl.verifyCode(
      AuthData(email: email!, code: verifycodeSignup),
    );

    final r = response.fold((l) => l, (r) => r);
    if (Get.isDialogOpen ?? false) Get.back();
    if (r is AuthModel) {
      myServises.saveSecureData(token, r.authData!.token!);
      myServises.saveSecureData(userName, r.authData!.name!);
      myServises.saveSecureData(userEmail, r.authData!.email!);
      myServises.saveSecureData(userPhone, r.authData!.phone!);

      FirebaseMessaging.instance.subscribeToTopic("users");
      FirebaseMessaging.instance.subscribeToTopic(
        sanitizeTopic("user${r.authData!.email!}"),
      );

      if (myServises.sharedPreferences.getString("step") == "1") {
        Get.offNamed(AppRoutesname.homepage);
      } else {
        Get.offNamed(AppRoutesname.onBoarding);
      }
      myServises.saveStep("2");

      // Token Update Logic
      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          String? savedToken = await myServises.getSecureData("fcm_token");
          if (savedToken != fcmToken) {
            final response = await authRepoImpl.updateFcmToken(fcmToken);
            response.fold(
              (failure) => debugPrint(
                "Failed to update FCM token: ${failure.errorMessage}",
              ),
              (success) async {
                await myServises.saveSecureData("fcm_token", fcmToken);
                debugPrint("FCM token updated successfully");
              },
            );
          }
        }
      } catch (e) {
        debugPrint("Error updating token: $e");
      }
    }
    if (r is Failure) {
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
      statusrequest = Statusrequest.failuer;
    }
    update();
  }

  @override
  resend() {
    authRepoImpl.loginStepOne(AuthData(email: email!));
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  @override
  goTOSignup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }
}
