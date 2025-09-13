import 'package:e_comerece/controller/auth/login_step_one_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_3.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_4.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_5.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_right_4.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginStepOne extends StatelessWidget {
  const LoginStepOne({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LLoginStepOneControllerimplment());
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: GetBuilder<LLoginStepOneControllerimplment>(
          builder: (controller) => Stack(
            children: [
              PositionedLeft3(),
              PositionedRight4(),
              PositionedLeft4(),
              PositionedLeft5(),
              Form(
                key: controller.formState,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(height: 420),

                      Custtextfeld(
                        controller: controller.email,
                        hint: "emailHint".tr,
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Appcolor.gray,
                        ),
                        validator: (val) {
                          return vlidateInPut(
                            val: val!,
                            min: 6,
                            max: 100,
                            type: 'email',
                          );
                        },
                      ),

                      Custombuttonauth(
                        inputtext: "Next".tr,
                        onPressed: () {
                          controller.loginStepOne();
                        },
                      ),

                      Text("Orsigninwith".tr),
                      Container(
                        height: 40,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Appcolor.somgray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Google",
                            style: TextStyle(
                              color: Appcolor.primrycolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          controller.goToSginup();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("noAccount".tr),
                            Text(
                              "signUp".tr,
                              style: TextStyle(color: Appcolor.primrycolor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
