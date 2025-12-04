import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PositionedSupport extends StatelessWidget {
  final void Function() onPressed;
  const PositionedSupport({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -10,
      bottom: 300.h,
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.primrycolor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: FaIcon(FontAwesomeIcons.headset, color: Appcolor.white),
        ),
      ),
    );
  }
}
