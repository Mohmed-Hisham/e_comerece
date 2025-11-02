import 'package:e_comerece/Binding/initialbinding.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/core/loacallization/trenslition.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.init();
  await DBHelper.cleanupExpired();
  // await DBHelper.clearCache(platform: 'amazon', type: 'hotproduct');
  await initlizserviese();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.put(LocaleController());

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localeController.language,
          translations: MyTrenslition(),
          theme: localeController.themeData,
          initialBinding: Initialbinding(),
          getPages: routes,
        );
      },
    );
  }
}
