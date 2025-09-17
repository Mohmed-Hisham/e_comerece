import 'package:e_comerece/controller/auth/sginup_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Sginup extends StatelessWidget {
  const Sginup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SginupControllerimplemnt());
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: GetBuilder<SginupControllerimplemnt>(
          builder: (controller) => Form(
            key: controller.formState,
            child: Stack(
              children: [
                PositionedLeft1(),
                PositionedRight3(),
                Positioned(
                  top: 270,
                  left: 30,
                  child: SvgPicture.asset(
                    AppImagesassets.shapcamera,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Appcolor.primrycolor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Customtexttitleauth(text: "Create \nAccount".tr),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(height: 370),
                      Custtextfeld(
                        controller: controller.username,
                        hint: "usernameHint".tr,
                        validator: (val) {
                          return vlidateInPut(
                            val: val!,
                            min: 3,
                            max: 50,
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
                        hint: "phoneHint".tr,
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
                              style: TextStyle(color: Appcolor.primrycolor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
