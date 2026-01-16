import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:e_comerece/core/constant/routesname.dart';

abstract class SginupController extends GetxController {
  Future<void> sginup();
  void goToSginin();
}

class SginupControllerimplemnt extends SginupController {
  // SignupData signupData = SignupData(Get.find());
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  ScrollController scrollController = .new();
  FocusNode emailFocus = .new();
  FocusNode phoneFocus = .new();
  FocusNode passwordFocus = .new();
  FocusNode usernameFocus = .new();

  TextEditingController username = .new();
  TextEditingController email = .new();
  TextEditingController passowrd = .new();
  TextEditingController phone = .new();

  Statusrequest? statusrequest;

  bool visibility = true;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  visibilityFun() {
    visibility = visibility == true ? visibility = false : visibility = true;
    update();
  }

  @override
  sginup() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }
      final response = await authRepoImpl.sginup(
        AuthData(
          name: username.text,
          email: email.text,
          phone: phone.text,
          password: passowrd.text,
        ),
      );
      final r = response.fold((l) => l, (r) => r);
      if (Get.isDialogOpen ?? false) Get.back();
      if (r is AuthModel) {
        showCustomGetSnack(isGreen: true, text: r.message!);
        Get.offNamed(
          AppRoutesname.verFiyCodeSignUp,
          arguments: {"email": email.text},
        );
      }
      if (r is Failure) {
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
      }

      emailFocus.unfocus();
      phoneFocus.unfocus();
      passwordFocus.unfocus();
      usernameFocus.unfocus();
      statusrequest = Statusrequest.success;
      update();
    }
  }

  @override
  goToSginin() {
    Get.offNamed(AppRoutesname.loginStepOne);
  }

  @override
  void dispose() {
    super.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    usernameFocus.dispose();
    email.dispose();
    phone.dispose();
    passowrd.dispose();
    username.dispose();
    scrollController.dispose();
  }
}
