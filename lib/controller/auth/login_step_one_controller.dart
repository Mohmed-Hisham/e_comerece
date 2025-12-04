import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/auth/login_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginStepOneController extends GetxController {
  goToSginup();
  loginStepOne();
}

class LLoginStepOneControllerimplment extends LoginStepOneController {
  ScrollController scrollController = ScrollController();
  final emailFocus = FocusNode();

  LoginData loginData = LoginData(Get.find());
  late TextEditingController email;
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  void onInit() {
    super.onInit();

    email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    emailFocus.dispose();
    scrollController.dispose();
  }

  @override
  loginStepOne() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }
      var response = await loginData.loginStepOne(email: email.text);
      statusrequest = handlingData(response);
      if (Get.isDialogOpen ?? false) Get.back();

      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'not_approve') {
          Get.toNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": email.text},
          );
        } else if (response['status'] == 'success') {
          Get.toNamed(
            AppRoutesname.login,
            arguments: {
              "email": email.text,
              "name": response['data']['user_name'],
            },
          );
          email.clear();
        } else {
          errorDialog(
            StringsKeys.accountNotFound.tr,
            StringsKeys.accountNotFound.tr,
          );
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
    }
  }
}
