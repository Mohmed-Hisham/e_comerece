import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loadingimage extends StatelessWidget {
  const Loadingimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(lottie.loadindimage4, width: 180, height: 180);
  }
}
