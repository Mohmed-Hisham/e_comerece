import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/auth/login_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();

  goToSginup();
  goToForgetpassword();
}

class LoginControllerimplment extends LoginController {
  LoginData loginData = LoginData(Get.find());
  late TextEditingController email;
  late TextEditingController passowrd;

  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;
  bool visibility = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  visibilityFun() {
    visibility = visibility == true ? visibility = false : visibility = true;
    update();
  }

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  login() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      var response = await loginData.postData(
        email: email.text,
        password: passowrd.text,
      );
      statusrequest = handlingData(response);
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'not_approve') {
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": response['data']['user_email']},
          );
        } else if (response['status'] == 'success') {
          myServises.sharedPreferences.setString(
            "user_id",
            response['data']['user_id'],
          );
          myServises.sharedPreferences.setString(
            "user_name",
            response['data']['user_name'],
          );
          myServises.sharedPreferences.setString(
            "user_email",
            response['data']['user_email'],
          );
          myServises.sharedPreferences.setString(
            "user_phone",
            response['data']['user_phone'],
          );
          myServises.sharedPreferences.setString("step", "2");
          Get.offNamed(AppRoutesname.homepage);
        } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText: "كلمه المرور خطأ او الحساب غير موجود",
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
    FirebaseMessaging.instance.getToken().then((val) {
      String? token = val;
      print(val);
    });

    email = TextEditingController();
    passowrd = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    passowrd.dispose();
  }

  @override
  goToForgetpassword() {
    Get.toNamed(AppRoutesname.forgetpassword);
  }
}
