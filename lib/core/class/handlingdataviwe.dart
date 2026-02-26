import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';

class Handlingdataviwe extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  final Widget? shimmer;
  final bool isSliver;
  final bool isproductdetails;
  final void Function()? ontryagain;
  final String? texttryagain;
  final bool isSizedBox;
  final double height;
  final bool noLoading;

  const Handlingdataviwe({
    super.key,
    required this.statusrequest,
    required this.widget,
    this.shimmer,
    this.isSliver = false,
    this.isproductdetails = false,
    this.ontryagain,
    this.texttryagain,
    this.isSizedBox = false,
    this.height = 220,
    this.noLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget boxChild(Widget child) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (statusrequest != Statusrequest.loading && ontryagain != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CustButtonBotton(
              onTap: ontryagain,
              title: texttryagain ?? StringsKeys.tryAgain.tr,
            ),
          ),
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            builder: (context, value, _) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );

    Widget sliverChild(Widget child, {bool mediaQuery = true}) =>
        SliverToBoxAdapter(
          child: SizedBox(
            // height: mediaQuery
            //     ? MediaQuery.of(context).size.height * 0.3
            //     : MediaQuery.of(context).size.height * 0.01,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSizedBox) SizedBox(height: height.h),
                if (statusrequest != Statusrequest.loading &&
                    ontryagain != null)
                  CustButtonBotton(
                    onTap: ontryagain,
                    title: texttryagain ?? StringsKeys.tryAgain.tr,
                  ),

                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    if (isSliver) {
      switch (statusrequest) {
        case Statusrequest.loading:
          if (shimmer != null) return sliverChild(shimmer!, mediaQuery: false);
          return sliverChild(
            Column(
              children: [
                if (!noLoading)
                  Lottie.asset(
                    Lottieassets.shoppingcart,
                    width: 180,
                    height: 180,
                  ),
                if (isproductdetails)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        StringsKeys.textloading.tr,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        case Statusrequest.noData:
          return sliverChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.oflinefailuer:
          return sliverChild(
            Lottie.asset(
              Lottieassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return sliverChild(
            Lottie.asset(
              Lottieassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return sliverChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.failuerTryAgain:
          return sliverChild(
            Lottie.asset(Lottieassets.tryAgain, width: 220, height: 220),
          );
        default:
          return widget;
      }
    } else {
      switch (statusrequest) {
        case Statusrequest.loading:
          return shimmer ??
              boxChild(
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!noLoading)
                      Lottie.asset(
                        Lottieassets.shoppingcart,
                        width: 180,
                        height: 180,
                      ),
                    if (isproductdetails)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            StringsKeys.textloading.tr,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              );
        case Statusrequest.noData:
          return boxChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.oflinefailuer:
          return boxChild(
            Lottie.asset(
              Lottieassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return boxChild(
            Lottie.asset(
              Lottieassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return boxChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 300, height: 300),
          );
        case Statusrequest.failuerTryAgain:
          return boxChild(
            Lottie.asset(Lottieassets.tryAgain, width: 300, height: 300),
          );
        default:
          return widget;
      }
    }
  }
}

class HandlingdataviweNoEmty extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  final Widget? shimmer;
  final bool isSliver;
  final bool isproductdetails;
  final void Function()? ontryagain;
  final String? texttryagain;
  final bool isSizedBox;

  const HandlingdataviweNoEmty({
    super.key,
    required this.statusrequest,
    required this.widget,
    this.shimmer,
    this.isSliver = false,
    this.isproductdetails = false,
    this.ontryagain,
    this.texttryagain,
    this.isSizedBox = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget boxChild(Widget child) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (statusrequest != Statusrequest.loading)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CustButtonBotton(
              onTap: ontryagain ?? () {},
              title: texttryagain ?? StringsKeys.tryAgain.tr,
            ),
          ),
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            builder: (context, value, _) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );

    Widget sliverChild(Widget child, {bool mediaQuery = true}) =>
        SliverToBoxAdapter(
          child: SizedBox(
            // height: mediaQuery
            //     ? MediaQuery.of(context).size.height * 0.3
            //     : MediaQuery.of(context).size.height * 0.01,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSizedBox) SizedBox(height: 220.h),
                if (statusrequest != Statusrequest.loading)
                  CustButtonBotton(
                    onTap: () => ontryagain,
                    title: StringsKeys.tryAgain.tr,
                  ),

                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    if (isSliver) {
      switch (statusrequest) {
        case Statusrequest.loading:
          if (shimmer != null) return sliverChild(shimmer!, mediaQuery: false);
          return sliverChild(
            Column(
              children: [
                Lottie.asset(
                  Lottieassets.shoppingcart,
                  width: 180,
                  height: 180,
                ),
                if (isproductdetails)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        StringsKeys.textloading.tr,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );

        case Statusrequest.oflinefailuer:
          return sliverChild(
            Lottie.asset(
              Lottieassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return sliverChild(
            Lottie.asset(
              Lottieassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return sliverChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 220, height: 220),
          );
        case Statusrequest.failuerTryAgain:
          return sliverChild(
            Lottie.asset(Lottieassets.tryAgain, width: 220, height: 220),
          );
        default:
          return widget;
      }
    } else {
      switch (statusrequest) {
        case Statusrequest.loading:
          return shimmer ??
              boxChild(
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Lottieassets.shoppingcart,
                      width: 180,
                      height: 180,
                    ),
                    if (isproductdetails)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            StringsKeys.textloading.tr,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              );

        case Statusrequest.oflinefailuer:
          return boxChild(
            Lottie.asset(
              Lottieassets.nointernetlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.serverfailuer:
          return boxChild(
            Lottie.asset(
              Lottieassets.srverfailuerlottie,
              width: 220,
              height: 220,
            ),
          );
        case Statusrequest.failuer:
          return boxChild(
            Lottie.asset(Lottieassets.nodatalottie, width: 300, height: 300),
          );
        case Statusrequest.failuerTryAgain:
          return boxChild(
            Lottie.asset(Lottieassets.tryAgain, width: 300, height: 300),
          );
        default:
          return widget;
      }
    }
  }
}

class HandlingdatRequestNoFild extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  final Widget? shimmer;
  final bool isSliver;
  final bool isSizedBox;
  final double height;

  const HandlingdatRequestNoFild({
    super.key,
    required this.statusrequest,
    required this.widget,
    this.shimmer,
    this.isSliver = false,
    this.isSizedBox = false,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    Widget boxChild(Widget child) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            builder: (context, value, _) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );

    Widget sliverChild(Widget child, {bool mediaQuery = true}) =>
        SliverToBoxAdapter(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSizedBox) SizedBox(height: height.h),

                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    if (isSliver) {
      switch (statusrequest) {
        case Statusrequest.loading:
          if (shimmer != null) return sliverChild(shimmer!, mediaQuery: false);
          return sliverChild(
            Column(
              children: [
                Lottie.asset(
                  Lottieassets.shoppingcart,
                  width: 180,
                  height: 180,
                ),
              ],
            ),
          );
        case Statusrequest.noData:
          return sliverChild(SizedBox());
        case Statusrequest.none:
          return sliverChild(SizedBox());
        case Statusrequest.oflinefailuer:
          return sliverChild(SizedBox());
        case Statusrequest.serverfailuer:
          return sliverChild(SizedBox());
        case Statusrequest.failuer:
          return sliverChild(SizedBox());
        case Statusrequest.failuerTryAgain:
          return sliverChild(SizedBox());
        default:
          return widget;
      }
    } else {
      switch (statusrequest) {
        case Statusrequest.loading:
          return shimmer ??
              boxChild(
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Lottieassets.shoppingcart,
                      width: 180,
                      height: 180,
                    ),
                  ],
                ),
              );
        case Statusrequest.noData:
          return boxChild(SizedBox());
        case Statusrequest.none:
          return boxChild(SizedBox());
        case Statusrequest.oflinefailuer:
          return boxChild(SizedBox());
        case Statusrequest.serverfailuer:
          return boxChild(SizedBox());
        case Statusrequest.failuer:
          return boxChild(SizedBox());
        case Statusrequest.failuerTryAgain:
          return boxChild(SizedBox());
        default:
          return widget;
      }
    }
  }
}
