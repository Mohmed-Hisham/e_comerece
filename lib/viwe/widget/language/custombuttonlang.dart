import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custombuttonlang extends StatelessWidget {
  final String textbutton;
  final void Function() onPressed;

  const Custombuttonlang({
    super.key,
    required this.textbutton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Appcolor.primrycolor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          textbutton,
          style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
