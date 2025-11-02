import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustCntainer extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontsize;
  const CustCntainer({
    super.key,
    required this.text,
    required this.color,
    this.fontsize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
