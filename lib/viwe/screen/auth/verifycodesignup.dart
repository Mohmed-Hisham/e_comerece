import 'package:e_comerece/controller/auth/veirfycodesignup_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/custcancle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verifycodesignup extends StatelessWidget {
  const Verifycodesignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifycodesignupControllerImp());
    return Scaffold(
      body: GetBuilder<VerifycodesignupControllerImp>(
        builder: (controller) => HandlingdataviweNoLoading(
          statusrequest: controller.statusrequest,
          widget: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    SizedBox(height: 130),

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
                      fontSize: 25,

                      text: "verifyCodeTitle".tr,
                    ),
                    Customtextbody(text: "verifyCodeBody".tr),
                    SizedBox(height: 5),
                    OtpTextField(
                      enabledBorderColor: Appcolor.black,
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
                          "Resend Vrify Code?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Appcolor.primrycolor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Custcancle(
                      onTap: () {
                        controller.goTOSignup();
                      },
                    ),
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
