import 'package:e_comerece/controller/auth/login_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_3.dart';
import 'package:e_comerece/viwe/widget/Positioned/login_step_one/positioned_left_4.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerimplment());
    return Scaffold(
      body: GetBuilder<LoginControllerimplment>(
        builder: (controller) => Stack(
          children: [
            PositionedLeft3(),
            PositionedLeft4(),

            Form(
              key: controller.formState,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    SizedBox(height: 150),

                    Container(
                      height: 80,
                      width: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          height: 40,
                          width: 40,
                          AppImagesassets.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello,".tr,

                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                        ),
                        Text(
                          " ${controller.name}!!",
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                        ),
                      ],
                    ),

                    GetBuilder<LoginControllerimplment>(
                      builder: (cont) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Custtextfeld(
                          obscureText: controller.visibility,
                          controller: controller.passowrd,
                          hint: "passwordHint".tr,
                          suffixIcon: IconButton(
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
                          validator: (val) {
                            return vlidateInPut(
                              val: val!,
                              min: 6,
                              max: 100,
                              type: 'password',
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        controller.goToForgetpassword();
                      },
                      child: Text("forgotPassword".tr),
                    ),
                    Custombuttonauth(
                      inputtext: "Next".tr,
                      onPressed: () {
                        controller.login();
                      },
                    ),
                    SizedBox(height: 3),
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(AppRoutesname.loginStepOne);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Appcolor.primrycolor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Appcolor.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 5),

                          Text(
                            " Not you?",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
