import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RPSCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0181818, size.height * 0.9990000);
    path_0.lineTo(size.width * -0.0254545, size.height * 1.0060000);
    path_0.lineTo(size.width * 0.0000182, size.height * 0.5796600);
    path_0.quadraticBezierTo(
      size.width * 0.0100000,
      size.height * 0.5090000,
      size.width * 0.1272727,
      size.height * 0.4930000,
    );
    path_0.cubicTo(
      size.width * 0.8830727,
      size.height * 0.4892200,
      size.width * 0.9425273,
      size.height * 0.5135700,
      size.width * 1.0016000,
      size.height * 0.3729100,
    );
    path_0.quadraticBezierTo(
      size.width * 1.0351091,
      size.height * 0.5120400,
      size.width * 1.0181818,
      size.height * 0.9990000,
    );
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyCustomShape extends StatelessWidget {
  const MyCustomShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/svg/bubble.svg',
          width: 200,
          height: 200,
          colorBlendMode: BlendMode.srcIn,
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(255, 243, 99, 91),
            BlendMode.srcIn,
          ),
        ),

        //  ClipPath(
        //   clipper: RPSCustomClipper(),
        //   child: Container(
        //     width: 600,
        //     height: 700,
        //     color: Appcolor.primrycolor,
        //     alignment: Alignment.center,
        //   ),
        // ),
      ),
    );
  }
}
