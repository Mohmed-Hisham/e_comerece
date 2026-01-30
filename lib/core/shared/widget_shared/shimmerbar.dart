// core/shared/widget_shared/shimmer_bar.dart
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class ShimmerBar extends StatelessWidget {
  final double height;
  final double borderRadius;
  final int animationDuration;

  const ShimmerBar({
    super.key,
    this.height = 5,

    this.borderRadius = 150,
    this.animationDuration = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,

        child: AnimatedContainer(
          duration: Duration(seconds: animationDuration),
          curve: Curves.linear,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow, Appcolor.primrycolor, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}
