import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginStepOneController extends GetxController {
  goToSginup();
  loginStepOne();
}

class LLoginStepOneControllerimplment extends LoginStepOneController {
  ScrollController scrollController = ScrollController();
  FocusNode emailFocus = .new();

  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  TextEditingController email = .new();
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
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
      final response = await authRepoImpl.loginStepOne(
        AuthData(email: email.text),
      );
      final r = response.fold((l) => l, (r) => r);
      if (Get.isDialogOpen ?? false) Get.back();
      if (r is AuthModel) {
        showCustomGetSnack(isGreen: true, text: r.message!);
        Get.toNamed(
          AppRoutesname.login,
          arguments: {"email": email.text, "name": r.authData!.name ?? ""},
        );
      }
      if (r is Failure) {
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
      }

      emailFocus.unfocus();
      statusrequest = Statusrequest.success;
      update();
    }
  }
}
