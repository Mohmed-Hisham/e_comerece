import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/resetpassword_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ResetcodeController extends GetxController {
  ckeckemail();
}

class ResetpasswordIemeent extends ResetcodeController {
  ResetpasswordData resetpasswordData = ResetpasswordData(Get.find());
  late TextEditingController passWord;
  late TextEditingController repassWord;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Statusrequest? statusrequest;

  String? email;

  @override
  ckeckemail() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      if (passWord.text != repassWord.text) {
        return Get.defaultDialog(
          title: "خطأ",
          middleText: "كلمه المرور غير متطابقة",
        );
      }
      statusrequest = Statusrequest.loading;
      update();
      var response = await resetpasswordData.postData(
        email: email!,
        password: passWord.text,
      );

      statusrequest = handlingData(response);
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          Get.toNamed(AppRoutesname.resetPassWord, arguments: {"email": email});
        } else {
          Get.defaultDialog(title: "خطأ");
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
      Get.offAllNamed(AppRoutesname.successReset);
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    passWord = TextEditingController();
    repassWord = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    passWord.dispose();
    repassWord.dispose();
  }
}
