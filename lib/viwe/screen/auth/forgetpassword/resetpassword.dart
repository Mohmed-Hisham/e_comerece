import 'package:e_comerece/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ResetpasswordIemeent());
    return Scaffold(
      body: GetBuilder<ResetpasswordIemeent>(
        builder: (controller) => Form(
          key: controller.formState,
          child: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    SizedBox(height: 130),
                    Custavatar(),
                    Customtexttitleauth(
                      fontSize: 30,
                      text: "resetPasswordTitle".tr,
                    ),
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
                    SizedBox(height: 5),

                    Custombuttonauth(
                      inputtext: "save".tr,
                      onPressed: () {
                        controller.resetPassword();
                      },
                    ),
                    SizedBox(height: 10),
                    CustButtonBotton(onTap: controller.goback),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
