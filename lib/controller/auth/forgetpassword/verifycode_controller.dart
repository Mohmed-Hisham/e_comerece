import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/verifycoderesetpass_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  late String code;
  ckeckCode(verifycodeSignup);
  goback() => Get.back();
}

class VerifycodeControllerImp extends VerifycodeController {
  VerifycoderesetpassData verifycodesignupData = VerifycoderesetpassData(
    Get.find(),
  );
  Statusrequest? statusrequest;

  String? email;
  FocusNode focus = FocusNode();

  @override
  ckeckCode(verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    focus.unfocus();
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    var response = await verifycodesignupData.postData(
      email: email!,
      verifycode: verifycodeSignup,
    );

    statusrequest = handlingData(response);
    if (Get.isDialogOpen ?? false) Get.back();
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.toNamed(AppRoutesname.resetPassWord, arguments: {"email": email});
      } else {
        errorDialog(StringsKeys.error.tr, StringsKeys.incorrectCode.tr);
        statusrequest = Statusrequest.failuer;
      }
    }
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
