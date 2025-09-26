import 'package:e_comerece/controller/auth/forgetpassword/verifycode_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:e_comerece/viwe/widget/custavatar.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Veryfiycode extends StatelessWidget {
  const Veryfiycode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeControllerImp controller = Get.put(VerifycodeControllerImp());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(height: 130),
                Custavatar(),
                Customtexttitleauth(fontSize: 30, text: "verifyCodeTitle".tr),
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
                    controller.ckeckCode(verificationCode);
                  },
                ),

                SizedBox(height: 10),
                CustButtonBotton(onTap: controller.goback),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
