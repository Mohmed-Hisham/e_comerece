import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/checkemail_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class Forgetpassowrd extends GetxController {
  ckeckemail();

  goToveyfiycode();
}

class Forgetpassowrdlment extends Forgetpassowrd {
  CheckemailData checkemailData = CheckemailData(Get.find());
  late TextEditingController email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Statusrequest? statusrequest;

  @override
  goToveyfiycode() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await checkemailData.postData(email: email.text);
    print(response);

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.toNamed(AppRoutesname.verFiyCode, arguments: {"email": email.text});
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "الايميل غير موجود");
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  ckeckemail() {}

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
}
