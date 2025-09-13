import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/widgets.dart';

class Custavatar extends StatelessWidget {
  const Custavatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          height: 40,
          width: 40,
          AppImagesassets.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
