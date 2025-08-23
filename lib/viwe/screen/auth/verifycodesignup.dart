import 'package:e_comerece/controller/auth/veirfycodesignup_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verifycodesignup extends StatelessWidget {
  const Verifycodesignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifycodesignupControllerImp());
    return Scaffold(
      appBar: AppBar(title: Text("hhhhhhhhhhhhh")),
      body: GetBuilder<VerifycodesignupControllerImp>(
        builder: (controller) =>
            controller.statusrequest == Statusrequest.loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                spacing: 10,
                children: [
                  Customtexttitleauth(text: "verifyCodeTitle".tr),
                  Customtextbody(text: "verifyCodeBody".tr),
                  SizedBox(height: 5),
                  OtpTextField(
                    focusedBorderColor: Appcolor.primrycolor,
                    fillColor: Appcolor.primrycolor,
                    fieldWidth: 45,
                    borderRadius: BorderRadius.circular(15),
                    numberOfFields: 5,
                    borderColor: Appcolor.primrycolor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.goTosuccesssginup(verificationCode);
                    },
                  ),
                  const SizedBox(height: 10),

                  InkWell(
                    onTap: () {
                      controller.resend();
                    },
                    child: Center(
                      child: Text(
                        "Resend Vrify Code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
