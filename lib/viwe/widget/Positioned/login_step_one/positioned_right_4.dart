import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PositionedRight4 extends StatelessWidget {
  const PositionedRight4({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 270,
      right: -1,
      child: SvgPicture.asset(
        AppImagesassets.bubblle3,
        fit: BoxFit.cover,
        colorFilter: const ColorFilter.mode(
          Appcolor.primrycolor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
