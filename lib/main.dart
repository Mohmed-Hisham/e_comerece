import 'package:e_comerece/Binding/initialbinding.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/core/loacallization/trenslition.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initlizserviese();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.put(LocaleController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localeController.language,
      translations: MyTrenslition(),
      theme: localeController.themeData,
      initialBinding: Initialbinding(),
      getPages: routes,
    );
  }
}
