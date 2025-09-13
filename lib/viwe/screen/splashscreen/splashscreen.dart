import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/viwe/widget/onboarding/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Image.asset(
                AppImagesassets.applogo,
                width: 140,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "SaltK",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),

          SizedBox(height: 100),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustombuttonOnBoarding(
              onTap: () {
                Get.offAllNamed(AppRoutesname.sginin);
              },
              title: "Let's get started",
            ),
          ),
          InkWell(
            onTap: () {
              Get.offAllNamed(AppRoutesname.loginStepOne);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I already have an account? ",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 5),

                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Appcolor.primrycolor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Appcolor.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
