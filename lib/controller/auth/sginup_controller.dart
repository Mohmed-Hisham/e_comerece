import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
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
      var response = await signupData.postData(
        username: username.text,
        email: email.text,
        password: passowrd.text,
        phone: phone.text,
      );
      statusrequest = handlingData(response);
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          // data.addAll(response['data']);
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": email.text},
          );
        } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText: "الايميل او رقم الهاتف موجدين سابقا",
          );
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
    } else {
      print("not valid");
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
    email.dispose();
    phone.dispose();
    passowrd.dispose();
    username.dispose();
  }
}
