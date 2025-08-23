import 'package:e_comerece/controller/auth/forgetpassword/forgetpassowrd.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Forgetpassowrdlment());
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<Forgetpassowrdlment>(
        builder: (controller) => Form(
          key: controller.formState,
          child: Column(
            spacing: 10,
            children: [
              Customtexttitleauth(text: "forgotPasswordTitle".tr),
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
              Spacer(),

              controller.statusrequest == Statusrequest.loading
                  ? Center(child: CircularProgressIndicator())
                  : Custombuttonauth(
                      inputtext: "check".tr,
                      onPressed: () {
                        controller.goToveyfiycode();
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
