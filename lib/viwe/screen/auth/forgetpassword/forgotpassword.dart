import 'package:e_comerece/controller/auth/forgetpassword/forgetpassowrd.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/viwe/widget/custcancle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Forgetpassowrdlment());
    return Scaffold(
      body: GetBuilder<Forgetpassowrdlment>(
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
                    SizedBox(height: 120),
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
                    Customtexttitleauth(
                      fontSize: 30,
                      text: "forgotPasswordTitle".tr,
                    ),
                    Customtextbody(text: "forgotPasswordBody".tr),
                    SizedBox(height: 5),
                    Custtextfeld(
                      controller: controller.email,
                      hint: "emailHint".tr,
                      validator: (val) {
                        return vlidateInPut(
                          val: val!,
                          min: 6,
                          max: 100,
                          type: 'email',
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    Custombuttonauth(
                      inputtext: "check".tr,
                      onPressed: () {
                        controller.goToveyfiycode();
                      },
                    ),
                    SizedBox(height: 20),
                    Custcancle(title: "back".tr, onTap: controller.goback),
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
