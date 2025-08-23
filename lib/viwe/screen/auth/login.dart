import 'package:e_comerece/controller/auth/login_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerimplment());
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: SafeArea(
          child: GetBuilder<LoginControllerimplment>(
            builder: (controller) => HandlingdatRequest(
              statusrequest: controller.statusrequest,
              widget: Form(
                key: controller.formState,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(height: 20),
                      Customtexttitleauth(text: "loginTitle".tr),
                      Customtextbody(text: "loginBody".tr),
                      SizedBox(
                        height: 120,
                        child: Image.asset(AppImagesassets.logo),
                      ),
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
                      GetBuilder<LoginControllerimplment>(
                        builder: (cont) => Custtextfeld(
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

                      InkWell(
                        onTap: () {
                          controller.goToForgetpassword();
                        },
                        child: Text("forgotPassword".tr),
                      ),
                      Custombuttonauth(
                        inputtext: "login".tr,
                        onPressed: () {
                          controller.login();
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
                      SizedBox(height: 10),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
