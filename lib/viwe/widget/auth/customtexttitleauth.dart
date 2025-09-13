import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Customtexttitleauth extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  final double? fontSize;
  const Customtexttitleauth({
    super.key,
    required this.text,
    this.alignment,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: alignment ?? Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Appcolor.black,

          fontWeight: FontWeight.bold,
          fontSize: fontSize ?? 40,
        ),
      ),
    );
  }
}
