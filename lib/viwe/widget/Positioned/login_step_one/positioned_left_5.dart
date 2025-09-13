import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionedLeft5 extends StatelessWidget {
  const PositionedLeft5({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 91,
      left: 20,

      child: SizedBox(
        width: 175,
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Customtexttitleauth(
              alignment: Alignment.centerLeft,
              text: "loginTitle".tr,
            ),
            Row(
              children: [
                Expanded(
                  child: Customtextbody(
                    alignment: Alignment.centerLeft,
                    text: "loginBody".tr,
                  ),
                ),
                Icon(Icons.favorite, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
