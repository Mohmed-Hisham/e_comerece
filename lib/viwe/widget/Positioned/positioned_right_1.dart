import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PositionedRight1 extends StatelessWidget {
  const PositionedRight1({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -1,
      right: -5,
      child: IgnorePointer(
        child: SvgPicture.asset(
          AppImagesassets.bubbleRight,
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Appcolor.fourcolor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
