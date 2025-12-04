import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/auth/customtextbody.dart';
import 'package:e_comerece/viwe/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionedLeft5 extends StatelessWidget {
  const PositionedLeft5({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150.h,
      left: 30.w,

      child: SizedBox(
        width: 210.w,
        height: 250.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Customtexttitleauth(
              alignment: Alignment.centerLeft,
              text: StringsKeys.loginTitle.tr,
            ),
            Row(
              children: [
                Expanded(
                  child: Customtextbody(
                    alignment: Alignment.centerLeft,
                    text: StringsKeys.loginBody.tr,
                  ),
                ),
                Icon(Icons.favorite, size: 25.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
