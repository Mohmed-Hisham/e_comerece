import 'package:e_comerece/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ResetpasswordIemeent());
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ResetpasswordIemeent>(
        builder: (controller) => Form(
          key: controller.formState,
          child: Column(
            spacing: 10,
            children: [
              Customtexttitleauth(text: "resetPasswordTitle".tr),
              Customtextbody(text: "resetPasswordBody".tr),
              SizedBox(height: 5),
              Custtextfeld(
                controller: controller.passWord,
                hint: "passwordHint".tr,
                validator: (val) {
                  return vlidateInPut(
                    val: val!,
                    min: 6,
                    max: 100,
                    type: 'password',
                  );
                },
              ),
              Custtextfeld(
                controller: controller.repassWord,
                hint: "confirmPasswordHint".tr,
                validator: (val) {
                  return vlidateInPut(
                    val: val!,
                    min: 6,
                    max: 100,
                    type: 'password',
                  );
                },
              ),
              Spacer(),
              Custombuttonauth(
                inputtext: "save".tr,
                onPressed: () {
                  controller.ckeckemail();
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
