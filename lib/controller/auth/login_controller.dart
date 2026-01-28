import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/string_const.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/funcations/sanitize_topic.dart';

abstract class LoginController extends GetxController {
  Future<void> login();
  void goToSginup();
  void goToForgetpassword();
}

class LoginControllerimplment extends LoginController {
  ScrollController scrollController = .new();
  FocusNode focus = .new();

  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  late TextEditingController passowrd;
  late TextEditingController code;

  late String name;
  late String identifier; // إيميل أو هاتف
  late bool isPhone;
  String? verificationId; // للتحقق عبر SMS

  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;
  bool visibility = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  visibilityFun() {
    visibility = visibility == true ? visibility = false : visibility = true;
    update();
  }

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  login() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }

      // إذا كان التحقق عبر SMS، نتحقق من الكود عبر Firebase أولاً
      if (isPhone && verificationId != null) {
        final smsResult = await SendOtpHelper.signInWithSmsCode(
          verificationId: verificationId!,
          smsCode: code.text.trim(),
        );

        final smsVerified = smsResult.fold((error) {
          if (Get.isDialogOpen ?? false) Get.back();
          showCustomGetSnack(isGreen: false, text: error);
          return false;
        }, (success) => success);

        if (!smsVerified) {
          statusrequest = Statusrequest.failuer;
          update();
          return;
        }
      }

      // الآن نكمل تسجيل الدخول مع السيرفر
      var response = await authRepoImpl.loginStepTwo(
        AuthData(
          identifier: identifier,
          password: passowrd.text,
          code: isPhone ? null : code.text, // لا نرسل الكود للسيرفر إذا كان SMS
        ),
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
  }

  @override
  void onInit() {
    super.onInit();
    name = Get.arguments['name'] ?? '';
    identifier = Get.arguments['identifier'] ?? Get.arguments['email'] ?? '';
    isPhone = Get.arguments['isPhone'] ?? false;
    verificationId = Get.arguments['verificationId'];

    passowrd = .new();
    code = .new();
  }

  @override
  void dispose() {
    super.dispose();
    passowrd.dispose();
    code.dispose();
    focus.dispose();
    scrollController.dispose();
  }

  @override
  goToForgetpassword() {
    Get.toNamed(
      AppRoutesname.forgetpassword,
      arguments: {"identifier": identifier},
    );
  }
}
