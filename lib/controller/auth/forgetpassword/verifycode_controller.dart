import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  late String code;
  ckeckCode(String verifycodeSignup);
  goback() => Get.back();
}

class VerifycodeControllerImp extends VerifycodeController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  Statusrequest? statusrequest;

  String? email;
  FocusNode focus = .new();

  @override
  ckeckCode(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    final response = await authRepoImpl.verifyCode(
      AuthData(email: email!, code: verifycodeSignup),
    );

    final r = response.fold((l) => l, (r) => r);

    if (r is AuthModel) {
      showCustomGetSnack(isGreen: true, text: r.message!, close: false);
      Get.toNamed(
        AppRoutesname.resetPassWord,
        arguments: {"email": email, "code": verifycodeSignup},
      );
    }
    if (r is Failure) {
      showCustomGetSnack(isGreen: false, text: r.errorMessage, close: false);
      statusrequest = Statusrequest.failuer;
    }
    focus.unfocus();
    if (Get.isDialogOpen ?? false) Get.back();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  @override
  void dispose() {
    super.dispose();
    focus.dispose();
  }
}
