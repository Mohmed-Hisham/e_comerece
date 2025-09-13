import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custgridviwe extends StatelessWidget {
  final Widget image;
  final String disc;
  final String discprice;
  final String title;
  final String price;
  final Function()? onChangeIcon;
  final Widget icon;
  const Custgridviwe({
    super.key,
    required this.image,
    required this.disc,
    required this.title,
    required this.price,
    this.onChangeIcon,
    required this.icon,
    required this.discprice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Stack(
            children: [
              Container(
                height: 165,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: image,
                ),
              ),
              // favorite
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(
                      (0.6.clamp(0.0, 1.0) * 255).round(),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),

                  child: icon,
                ),
              ),
            ],
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Appcolor.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          price,
          // "20\$"
          style: TextStyle(
            color: Appcolor.primrycolor,
            fontWeight: FontWeight.bold,
            fontFamily: 'signika',
            fontSize: 17,
          ),
          textAlign: TextAlign.start,
        ),

        price == discprice
            ? const SizedBox.shrink()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 6,
                children: [
                  Text(
                    discprice,

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey,
                      decorationThickness: 2.0,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        disc,
                        // "20\$"
                        style: TextStyle(
                          color: Appcolor.primrycolor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'signika',
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "OFF",
                        style: TextStyle(
                          fontSize: 13,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}

//      Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: image,
//         ),

//         Positioned(
//           bottom: -1,
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 5,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withAlpha(
//                     (0.9.clamp(0.0, 1.0) * 255).round(),
//                   ),
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Center(
//                   child: Text(
//                     price,
//                     // "20\$"
//                     style: TextStyle(
//                       color: Appcolor.primrycolor,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'signika',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 60,
//                 width: 170,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: Appcolor.primrycolor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // discount
//         Positioned(
//           top: 3,
//           left: 3,
//           child: Container(
//             height: 35,
//             width: 35,
//             decoration: BoxDecoration(
//               color: Colors.white.withAlpha(
//                 (0.8.clamp(0.0, 1.0) * 255).round(),
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Center(
//               child: Text(
//                 disc,
//                 style: TextStyle(
//                   color: Appcolor.primrycolor,
//                   fontWeight: FontWeight.bold,
//                   height: 1.5,
//                   fontFamily: 'signika',
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // like
//         Positioned(
//           top: 3,
//           right: 3,
//           child: Container(
//             height: 35,
//             width: 35,
//             decoration: BoxDecoration(
//               color: Colors.white.withAlpha(
//                 (0.7.clamp(0.0, 1.0) * 255).round(),
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: icon,
//           ),
//         ),
//         // price
//         // Positioned(
//         //   bottom: 50,
//         //   right: 60,
//         //   child: Container(
//         //     height: 35,
//         //     width: 35,
//         //     decoration: BoxDecoration(
//         //       color: Colors.white.withAlpha(
//         //         (0.9.clamp(0.0, 1.0) * 255).round(),
//         //       ),
//         //       borderRadius: BorderRadius.circular(20),
//         //     ),
//         //     child: const Center(
//         //       child: Text(
//         //         "20\$",
//         //         style: TextStyle(
//         //           color: Appcolor.primrycolor,
//         //           fontWeight: FontWeight.bold,
//         //           fontFamily: 'signika',
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
