import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/checkemail_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  goToveyfiycode() async {
    if (formState.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        Get.dialog(
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (didPop) return;
            },
            child: Center(child: CircularProgressIndicator()),
          ),
        );
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
          Get.defaultDialog(title: "خطأ", middleText: "الايميل غير موجود");
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
  }

  @override
  goback() {
    Get.back();
  }
}
