import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Custombottonbar extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final IconData iconData;
  final Color textcolor;
  final bool isactive;
  const Custombottonbar({
    super.key,
    this.onPressed,
    this.text,
    required this.iconData,
    required this.textcolor,
    required this.isactive,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              iconData,
              color: isactive ? Appcolor.primrycolor : Appcolor.gray,
              size: 26,
            ),
            // Icon(
            //   iconData,
            //   color: isactive ? Appcolor.primrycolor : Appcolor.gray,
            //   size: 30,
            // ),
            // Text(
            //   "$text",
            //   style: TextStyle(
            //     color: isactive ? Appcolor.primrycolor : Appcolor.gray,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
