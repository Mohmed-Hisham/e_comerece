import 'package:e_comerece/Binding/initialbinding.dart';
import 'package:e_comerece/core/helper/app_scroll_behavior.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/core/loacallization/trenslition.dart';
import 'package:e_comerece/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.find<LocaleController>();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.1)),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            scrollBehavior: AppScrollBehavior(),
            debugShowCheckedModeBanner: false,
            locale: localeController.language,
            translations: MyTrenslition(),
            theme: localeController.themeData,
            initialBinding: Initialbinding(),
            getPages: routes,

            // builder: (context, child) {
            //   // Also override inside GetMaterialApp (it creates its own MediaQuery)
            //   return MediaQuery(
            //     data: MediaQuery.of(
            //       context,
            //     ).copyWith(textScaler: TextScaler.noScaling),
            //     child: child!,
            //   );
            // },
          );
        },
      ),
    );
  }
}
