import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustLabelContainer extends StatelessWidget {
  final String text;
  const CustLabelContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrendsClipper(),
      child: Container(
        decoration: BoxDecoration(
          color:
              //  const Color(0xFFFF6F2C),
              Appcolor.primrycolor,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
        ),
        margin: EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}

class TrendsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height - 20);

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
