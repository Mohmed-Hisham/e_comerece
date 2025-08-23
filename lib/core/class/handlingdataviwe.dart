import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Handlingdataviwe extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  const Handlingdataviwe({
    super.key,
    required this.statusrequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusrequest == Statusrequest.loading
        ? Center(
            child: Lottie.asset(
              AppImagesassets.loadinglottie,
              width: 250,
              height: 300,
            ),
          )
        : statusrequest == Statusrequest.oflinefailuer
        ? Center(
            child: Lottie.asset(
              AppImagesassets.nointernetlottie,
              width: 250,
              height: 300,
            ),
          )
        : statusrequest == Statusrequest.serverfailuer
        ? Center(
            child: Lottie.asset(
              AppImagesassets.srverfailuerlottie,
              width: 250,
              height: 300,
            ),
          )
        : statusrequest == Statusrequest.failuer
        ? Center(
            child: Lottie.asset(
              AppImagesassets.nodatalottie,
              width: 300,
              height: 350,
            ),
          )
        : widget;
  }
}

class HandlingdatRequest extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  const HandlingdatRequest({
    super.key,
    required this.statusrequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusrequest == Statusrequest.loading
        ? Center(
            child: Lottie.asset(
              AppImagesassets.loadinglottie,
              width: 250,
              height: 300,
            ),
          )
        : statusrequest == Statusrequest.oflinefailuer
        ? Center(
            child: Lottie.asset(
              AppImagesassets.nointernetlottie,
              width: 250,
              height: 300,
            ),
          )
        : statusrequest == Statusrequest.serverfailuer
        ? Center(
            child: Lottie.asset(
              AppImagesassets.srverfailuerlottie,
              width: 250,
              height: 300,
            ),
          )
        : widget;
  }
}
