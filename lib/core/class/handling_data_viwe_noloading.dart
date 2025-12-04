// import 'package:e_comerece/core/class/statusrequest.dart';
// import 'package:e_comerece/core/constant/imagesassets.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class HandlingdataviweNoLoading extends StatelessWidget {
//   final Statusrequest statusrequest;
//   final Widget widget;
//   const HandlingdataviweNoLoading({
//     super.key,
//     required this.statusrequest,
//     required this.widget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return statusrequest == Statusrequest.noData
//         ? Center(
//             child: Lottie.asset(
//               Lottieassets.nodatalottie,
//               width: 300,
//               height: 350,
//             ),
//           )
//         : statusrequest == Statusrequest.oflinefailuer
//         ? Center(
//             child: Lottie.asset(
//               Lottieassets.nointernetlottie,
//               width: 250,
//               height: 300,
//             ),
//           )
//         : statusrequest == Statusrequest.serverfailuer
//         ? Center(
//             child: Lottie.asset(
//               Lottieassets.srverfailuerlottie,
//               width: 250,
//               height: 300,
//             ),
//           )
//         : statusrequest == Statusrequest.failuer
//         ? Center(
//             child: Lottie.asset(
//               Lottieassets.nodatalottie,
//               width: 300,
//               height: 350,
//             ),
//           )
//         : widget;
//   }
// }
