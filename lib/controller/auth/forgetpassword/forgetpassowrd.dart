import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/checkemail_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Forgetpassowrd extends GetxController {
  goToveyfiycode();
  goback();
}

class Forgetpassowrdlment extends Forgetpassowrd {
  CheckemailData checkemailData = CheckemailData(Get.find());
  late TextEditingController email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Statusrequest? statusrequest;
  ScrollController scrollController = ScrollController();
  FocusNode focus = FocusNode();

  @override
  goToveyfiycode() async {
    if (formState.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      focus.unfocus();
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }

      var response = await checkemailData.postData(email: email.text);

      statusrequest = handlingData(response);
      if (Get.isDialogOpen ?? false) Get.back();
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          Get.toNamed(
            AppRoutesname.verFiyCode,
            arguments: {"email": email.text},
          );
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

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    focus.dispose();
    scrollController.dispose();
  }

  @override
  goback() {
    Get.back();
  }
}
