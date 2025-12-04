import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/viwe/widget/language/custombuttonlang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyLanguage extends GetView<LocaleController> {
  const MyLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Spacer(),
        // Text("chooseLang".tr, style: Theme.of(context).textTheme.headlineSmall),
        Custombuttonlang(
          textbutton: "Ar",
          onPressed: () {
            controller.changelang("ar");
            final x = Get.find<HomescreenControllerImple>();
            x.aliexpressHomeController.fetchProductsAliExpress();
            x.alibabaHomeController.fethcProductsAlibaba();
            x.amazonHomeCon.fetchProducts();
            x.sheinHomController.fetchproducts();
            Get.back();
          },
        ),
        Custombuttonlang(
          textbutton: "En",
          onPressed: () {
            controller.changelang("en");
            final x = Get.find<HomescreenControllerImple>();
            x.aliexpressHomeController.fetchProductsAliExpress();
            x.alibabaHomeController.fethcProductsAlibaba();
            x.amazonHomeCon.fetchProducts();
            x.sheinHomController.fetchproducts();
            Get.back();
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

// class MyLanguage extends GetView<LocaleController> {
//   const MyLanguage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PositionedRight1(),
//           PositionedRight2(),
//           PositionedAppBar(
//             title: StringsKeys.changeLanguage.tr,
//             onPressed: Get.back,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 10,
//             children: [
//               Text(
//                 "chooseLang".tr,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               Custombuttonlang(
//                 textbutton: "Ar",
//                 onPressed: () {
//                   controller.changelang("ar");
//                   Get.back();
//                   // Get.toNamed(AppRoutesname.splash);
//                 },
//               ),
//               Custombuttonlang(
//                 textbutton: "En",
//                 onPressed: () {
//                   controller.changelang("en");
//                   Get.back();
//                   // Get.toNamed(AppRoutesname.splash);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
