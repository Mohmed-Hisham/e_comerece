import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/checkinternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  initaldata() async {
    var res = await checkinternet();
    print(res);
  }

  @override
  void initState() {
    initaldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            OtpTextField(
              focusedBorderColor: Appcolor.primrycolor,
              fillColor: Appcolor.primrycolor,
              fieldWidth: 45,
              borderRadius: BorderRadius.circular(15),
              numberOfFields: 5,
              borderColor: Appcolor.primrycolor,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {}, // end onSubmit
            ),
          ],
        ),
      ),
    );
  }
}
