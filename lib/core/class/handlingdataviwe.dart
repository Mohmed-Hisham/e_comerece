import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

class Handlingdataviwe extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  final Widget? shimmer;
  final bool isSliver;

  const Handlingdataviwe({
    super.key,
    required this.statusrequest,
    required this.widget,
    this.shimmer,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget boxChild(Widget child) => Center(child: child);
    Widget sliverChild(Widget child) => SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(child: child),
      ),
    );

    if (isSliver) {
      switch (statusrequest) {
        case Statusrequest.loading:
          if (shimmer != null) return shimmer!;
          return sliverChild(
            Lottie.asset(
              AppImagesassets.loadinglottie,
              width: 180,
              height: 180,
            ),
          );
        case Statusrequest.noData:
          return sliverChild(
            Lottie.asset(AppImagesassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.oflinefailuer:
          return sliverChild(
            Lottie.asset(
              AppImagesassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return sliverChild(
            Lottie.asset(
              AppImagesassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return sliverChild(
            Lottie.asset(AppImagesassets.nodatalottie, width: 220, height: 220),
          );
        default:
          return widget;
      }
    } else {
      switch (statusrequest) {
        case Statusrequest.loading:
          return shimmer ??
              boxChild(
                Lottie.asset(
                  AppImagesassets.loadinglottie,
                  width: 180,
                  height: 180,
                ),
              );
        case Statusrequest.noData:
          return boxChild(
            Lottie.asset(AppImagesassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.oflinefailuer:
          return boxChild(
            Lottie.asset(
              AppImagesassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return boxChild(
            Lottie.asset(
              AppImagesassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return boxChild(
            Lottie.asset(AppImagesassets.nodatalottie, width: 220, height: 220),
          );
        default:
          return widget;
      }
    }
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

class HandlingdataviweNoLoading extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  const HandlingdataviweNoLoading({
    super.key,
    required this.statusrequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusrequest == Statusrequest.noData
        ? Center(
            child: Lottie.asset(
              AppImagesassets.nodatalottie,
              width: 300,
              height: 350,
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
