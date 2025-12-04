import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/data/datasource/remote/auth/signup_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:e_comerece/core/constant/routesname.dart';

abstract class SginupController extends GetxController {
  sginup();
  goToSginin();
}

class SginupControllerimplemnt extends SginupController {
  SignupData signupData = SignupData(Get.find());
  ScrollController scrollController = ScrollController();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final usernameFocus = FocusNode();

  List data = [];

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController passowrd;
  late TextEditingController phone;

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
      var response = await signupData.postData(
        username: username.text,
        email: email.text,
        password: passowrd.text,
        phone: phone.text,
      );
      statusrequest = handlingData(response);
      if (Get.isDialogOpen ?? false) Get.back();
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          // data.addAll(response['data']);
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": email.text},
          );
          emailFocus.unfocus();
          phoneFocus.unfocus();
          passwordFocus.unfocus();
          usernameFocus.unfocus();
        } else {
          errorDialog(StringsKeys.error.tr, StringsKeys.emailOrPhoneExists.tr);
          emailFocus.unfocus();
          phoneFocus.unfocus();
          passwordFocus.unfocus();
          usernameFocus.unfocus();
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
    }
  }

  @override
  goToSginin() {
    Get.offNamed(AppRoutesname.loginStepOne);
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    phone = TextEditingController();
    passowrd = TextEditingController();
    username = TextEditingController();
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
