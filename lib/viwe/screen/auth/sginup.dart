import 'package:e_comerece/controller/auth/sginup_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sginup extends StatelessWidget {
  const Sginup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SginupControllerimplemnt());
    return Scaffold(
      appBar: AppBar(),

      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: GetBuilder<SginupControllerimplemnt>(
          builder: (controller) => Form(
            key: controller.formState,
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Customtexttitleauth(text: "signUpTitle".tr),
                  Customtextbody(text: "signUpBody".tr),
                  SizedBox(height: 20),
                  Custtextfeld(
                    controller: controller.username,
                    hint: "usernameHint".tr,
                    validator: (val) {
                      return vlidateInPut(
                        val: val!,
                        min: 10,
                        max: 100,
                        type: 'username',
                      );
                    },
                  ),
                  Custtextfeld(
                    hint: "emailHint".tr,
                    controller: controller.email,
                    validator: (val) {
                      return vlidateInPut(
                        val: val!,
                        min: 6,
                        max: 100,
                        type: 'email',
                      );
                    },
                  ),
                  Custtextfeld(
                    hint: "emailHint".tr,
                    controller: controller.phone,
                    validator: (val) {
                      return vlidateInPut(
                        val: val!,
                        min: 10,
                        max: 20,
                        type: 'phone',
                      );
                    },
                  ),
                  Custtextfeld(
                    controller: controller.passowrd,
                    hint: "passwordHint".tr,
                    validator: (val) {
                      return vlidateInPut(
                        val: val!,
                        min: 6,
                        max: 100,
                        type: 'password',
                      );
                    },
                    obscureText: controller.visibility,

                    suffix: IconButton(
                      onPressed: () => controller.visibilityFun(),
                      icon: controller.visibility == true
                          ? Icon(
                              Icons.lock_outline_rounded,
                              color: Appcolor.gray,
                            )
                          : Icon(
                              Icons.lock_open_rounded,
                              color: Appcolor.primrycolor,
                            ),
                    ),
                  ),
                  Custtextfeld(
                    controller: controller.confirmpassowrd,
                    hint: "confirmPasswordHint".tr,
                    validator: (val) {
                      return vlidateInPut(
                        val: val!,
                        min: 6,
                        max: 100,
                        type: 'password',
                      );
                    },
                    obscureText: controller.visibility,
                  ),
                  controller.statusrequest == Statusrequest.loading
                      ? Center(child: CircularProgressIndicator())
                      : Custombuttonauth(
                          inputtext: "signUp".tr,
                          onPressed: () {
                            controller.sginup();
                          },
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("haveAccount".tr),
                      InkWell(
                        onTap: () {
                          controller.goToSginin();
                        },
                        child: Text(
                          "login".tr,
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
