// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:e_comerece/controller/shein/home_shein_controller.dart';
// import 'package:e_comerece/core/constant/color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustCarouseShein extends StatelessWidget {
//   final List<String> items;
//   const CustCarouseShein({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeSheinControllerImpl>(
//       id: 'index',
//       builder: (controller) => Column(
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(
//               onPageChanged: (index, reason) {
//                 controller.indexchange(index);
//               },
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 5),
//               height: 160,
//               enlargeCenterPage: true,
//             ),
//             items: items.map((i) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Image.asset(
//                     i,
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,

//             children: [
//               ...List.generate(
//                 items.length,
//                 (index) => AnimatedContainer(
//                   margin: const EdgeInsets.only(right: 5),
//                   duration: const Duration(milliseconds: 300),
//                   width: controller.currentIndex == index ? 10 : 6,
//                   height: 6,
//                   decoration: BoxDecoration(
//                     color: controller.currentIndex == index
//                         ? Appcolor.primrycolor
//                         : Appcolor.threecolor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
