import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custombuttonauth extends StatelessWidget {
  final void Function()? onPressed;
  final String inputtext;
  const Custombuttonauth({super.key, this.onPressed, required this.inputtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),

      // padding: EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(
        color: Appcolor.primrycolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          inputtext,
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
