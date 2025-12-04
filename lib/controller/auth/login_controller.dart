import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/auth/login_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';

abstract class LoginController extends GetxController {
  login();
  goToSginup();
  goToForgetpassword();
}

class LoginControllerimplment extends LoginController {
  ScrollController scrollController = .new();
  final focus = FocusNode();

  LoginData loginData = LoginData(Get.find());
  late TextEditingController passowrd;

  late String name;
  late String email;

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
      var response = await loginData.postData(
        email: email,
        password: passowrd.text,
      );

      statusrequest = handlingData(response);
      if (Get.isDialogOpen ?? false) Get.back();

      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'not_approve') {
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": response['data']['user_email']},
          );
        } else if (response['status'] == 'success') {
          final String id = response['data']['user_id'].toString();
          myServises.sharedPreferences.setString("user_id", id);
          log(response['data']['user_id'].toString());
          myServises.sharedPreferences.setString(
            "user_name",
            response['data']['user_name'],
          );
          myServises.sharedPreferences.setString(
            "user_email",
            response['data']['user_email'],
          );
          myServises.sharedPreferences.setString(
            "user_phone",
            response['data']['user_phone'],
          );
          FirebaseMessaging.instance.subscribeToTopic('users');
          FirebaseMessaging.instance.subscribeToTopic('user$id');

          if (myServises.sharedPreferences.getString("step") == "1") {
            Get.offNamed(AppRoutesname.homepage);
          } else {
            Get.offNamed(AppRoutesname.onBoarding);
          }
        } else {
          errorDialog(StringsKeys.error.tr, StringsKeys.passwordIncorrect.tr);
          focus.unfocus();
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // FirebaseMessaging.instance.getToken().then((val) {
    //   String? token = val;
    //   print(val);
    // });
    name = Get.arguments['name'];
    email = Get.arguments['email'];

    passowrd = .new();
  }

  @override
  void dispose() {
    super.dispose();
    passowrd.dispose();
    focus.dispose();
    scrollController.dispose();
  }

  @override
  goToForgetpassword() {
    Get.toNamed(AppRoutesname.forgetpassword);
  }
}
