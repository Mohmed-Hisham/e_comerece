import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: 60,
      child: IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: isactive ? Appcolor.primrycolor : Appcolor.gray,
              size: 30,
            ),
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
