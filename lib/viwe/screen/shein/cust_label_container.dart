import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustLabelContainer extends StatelessWidget {
  final String text;
  const CustLabelContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isRTL = Get.locale?.languageCode == 'ar';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: ClipPath(
        clipper: TrendsClipper(isRTL: isRTL),
        child: Container(
          decoration: BoxDecoration(
            color: Appcolor.primrycolor,
            borderRadius: isRTL
                ? BorderRadius.horizontal(right: Radius.circular(5.sp))
                : BorderRadius.horizontal(left: Radius.circular(5.sp)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
        ),
      ),
    );
  }
}

class TrendsClipper extends CustomClipper<Path> {
  final bool isRTL;

  TrendsClipper({this.isRTL = false});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (isRTL) {
      // For Arabic (RTL): curve on the bottom-left
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(20, size.height);

      path.quadraticBezierTo(0, size.height, 0, size.height - 20);

      path.close();
    } else {
      // For English (LTR): curve on the bottom-right
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height - 20);

      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - 20,
        size.height,
      );

      path.lineTo(0, size.height);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
