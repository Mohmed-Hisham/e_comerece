import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PositionedLeft4 extends StatelessWidget {
  const PositionedLeft4({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      left: -10,
      child: SvgPicture.asset(
        AppImagesassets.bubbleGlobal,
        fit: BoxFit.cover,
        colorFilter: const ColorFilter.mode(
          Appcolor.primrycolor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
