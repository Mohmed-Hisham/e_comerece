import 'package:e_comerece/controller/onboardingcontrooler.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomsiderOnboarding extends GetView<Onboardingcontroolerimplement> {
  const CustomsiderOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipPath(
            clipper: MyCustomShapeClipper(),
            child: Container(
              width: double.infinity,
              color: Appcolor.primrycolor,
              child: Stack(
                children: [
                  Positioned(
                    right: -130,
                    top: -60,
                    child: Image.asset(AppImagesassets.background1, width: 280),
                  ),
                  Positioned(
                    right: -60,
                    top: 240,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Appcolor.threecolor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -60,
                    top: 140,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Appcolor.threecolor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: -50,
                  //   top: 210,
                  //   child: Image.asset(AppImagesassets.background2, width: 180),
                  // ),
                  PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (value) {
                      controller.onPageChanged(value);
                    },
                    itemCount: onborardinglist.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: Image.asset(
                              onborardinglist[index].image!,
                              fit: BoxFit.fitWidth,
                              width: 300,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyCustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // إنشاء مسار جديد
    Path path = Path();

    path.moveTo(size.width * -0.0088889, size.height * -0.0150000);
    path.quadraticBezierTo(
      size.width * -0.0044444,
      size.height * 0.3587500,
      size.width * -0.0044444,
      size.height * 0.5300000,
    );
    path.cubicTo(
      size.width * -0.0077778,
      size.height * 0.6112500,
      size.width * 0.0172222,
      size.height * 0.6375000,
      size.width * 0.0755556,
      size.height * 0.6775000,
    );
    path.cubicTo(
      size.width * 0.2961111,
      size.height * 0.7475000,
      size.width * 0.6927778,
      size.height * 0.8818750,
      size.width * 0.9066667,
      size.height * 0.9375000,
    );
    path.cubicTo(
      size.width * 0.9700000,
      size.height * 0.9506250,
      size.width * 1.0094444,
      size.height * 0.9306250,
      size.width * 1.0133333,
      size.height * 0.8625000,
    );
    path.quadraticBezierTo(
      size.width * 1.0150000,
      size.height * 0.6406250,
      size.width * 1.0066667,
      size.height * -0.0075000,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// الكلاس المحدث بآخر Path قمت بإنشائه
// class MyCustomShapeClipper2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // إنشاء مسار جديد
//     Path path = Path();

//     // لصق كود الـ Path الأخير الذي أرسلته
//     path.moveTo(size.width * 1.0050500, 0);
//     path.quadraticBezierTo(
//       size.width * 1.0087500,
//       size.height * 0.4893043,
//       size.width * 1.0100000,
//       size.height * 0.6708261,
//     );
//     path.cubicTo(
//       size.width * 1.0029500,
//       size.height * 0.7151304,
//       size.width * 0.9855500,
//       size.height * 0.7717826,
//       size.width * 0.9115000,
//       size.height * 0.7927826,
//     );
//     path.cubicTo(
//       size.width * 0.6990000,
//       size.height * 0.8319130,
//       size.width * 0.3075000,
//       size.height * 0.9043478,
//       size.width * 0.0950000,
//       size.height * 0.9434783,
//     );
//     path.cubicTo(
//       size.width * 0.0019000,
//       size.height * 0.9481739,
//       size.width * 0.0187500,
//       size.height * 0.8793478,
//       size.width * -0.0050000,
//       size.height * 0.8630435,
//     );
//     path.quadraticBezierTo(
//       size.width * -0.0050000,
//       size.height * 0.6445652,
//       size.width * -0.0033500,
//       size.height * -0.0044348,
//     );

//     // إغلاق المسار
//     path.close();

//     // إرجاع المسار النهائي
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
