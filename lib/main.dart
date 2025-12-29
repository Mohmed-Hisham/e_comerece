<<<<<<< HEAD
import 'package:e_comerece/viwe/screen/splash/app_splash_screen.dart';
=======
import 'package:e_comerece/Binding/initialbinding.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/core/loacallization/trenslition.dart';
import 'package:e_comerece/core/servises/notifcation_service.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/firebase_options.dart';
import 'package:e_comerece/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
>>>>>>> 911b6c07c4e18f884b5e8de3f7551d8c0f6b5a50
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  runApp(const AppSplashScreen());
=======
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotifcationService.initializeNotifications();
  await initlizserviese();
  await DBHelper.init();
  await DBHelper.cleanupExpired();

  // await DBHelper.clearCache(platform: 'amazon', type: 'hotproduct');
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
>>>>>>> 911b6c07c4e18f884b5e8de3f7551d8c0f6b5a50
}
