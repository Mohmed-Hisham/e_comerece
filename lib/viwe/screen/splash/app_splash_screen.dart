import 'dart:developer';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/helper/circular_widget.dart';
import 'package:e_comerece/core/loacallization/changelocal.dart';
import 'package:e_comerece/core/servises/awesome/awesome_fcm_service.dart';
import 'package:e_comerece/core/servises/awesome/awesome_notification_service.dart';
import 'package:e_comerece/core/servises/awesome/notification_controller.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/firebase_options.dart';
import 'package:e_comerece/viwe/screen/splash/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    try {
      log('Starting app initialization...');

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log('Firebase initialized');

      await AwesomeNotificationService.initialize();
      await AwesomeFcmService.initialize();
      NotificationController.initializeListeners();

      log('Notifications initialized');

      await initlizserviese();
      log('Services initialized');

      Get.put(LocaleController());

      // Initialize Currency Service
      await initCurrencyService();
      log('Currency service initialized');

      // Navigate immediately after initialization is complete
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e, stackTrace) {
      log('Error during app initialization: $e');
      log('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return const MyApp();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: child,
                  );
                },
                child: Image.asset(
                  AppImagesassets.applogo,
                  width: 250.w,
                  height: 250.h,
                ),
              ),
              SizedBox(height: 30.h),
              loadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
