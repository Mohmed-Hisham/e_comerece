import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/string_const.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/services_helper.dart';

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
      var response = await authRepoImpl.loginStepTwo(
        AuthData(email: email, password: passowrd.text, code: code.text),
      );

      final r = response.fold((l) => l, (r) => r);
      if (Get.isDialogOpen ?? false) Get.back();

      if (r is AuthModel) {
        ServicesHelper.saveLocal(token, r.authData!.token!);
        ServicesHelper.saveLocal(userName, r.authData!.name!);
        ServicesHelper.saveLocal(userEmail, r.authData!.email!);
        ServicesHelper.saveLocal(userPhone, r.authData!.phone!);

        FirebaseMessaging.instance.subscribeToTopic(users);
        FirebaseMessaging.instance.subscribeToTopic(r.authData!.token!);

        if (myServises.sharedPreferences.getString("step") == "1") {
          Get.offNamed(AppRoutesname.homepage);
        } else {
          Get.offNamed(AppRoutesname.onBoarding);
        }
        myServises.sharedPreferences.setString("step", "2");
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
    name = Get.arguments['name'];
    email = Get.arguments['email'];

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
    Get.toNamed(AppRoutesname.forgetpassword, arguments: {"email": email});
  }
}
