import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/viwe/widget/home/custbottonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homenavbar extends StatefulWidget {
  final int initialTab;
  const Homenavbar({super.key, this.initialTab = 0});

  // Routes للتنقل بين الصفحات
  static const List<String> tabRoutes = [
    AppRoutesname.homepage,
    AppRoutesname.cartTab,
    AppRoutesname.ordersTab,
    AppRoutesname.localServicesTab,
    AppRoutesname.settingsTab,
  ];

  /// Navigate to tab using Get.offNamed
  static void navigateToTab(int index) {
    if (index >= 0 && index < tabRoutes.length) {
      Get.offNamed(tabRoutes[index]);
    }
  }

  @override
  State<Homenavbar> createState() => _HomenavbarState();
}

class _HomenavbarState extends State<Homenavbar> {
  late HomescreenControllerImple controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomescreenControllerImple());

    // Set initial tab بشكل مباشر
    if (controller.pageindexHome != widget.initialTab) {
      controller.setPageWithoutNav(widget.initialTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          if (controller.pageindexHome != 0) {
            Homenavbar.navigateToTab(0);
          } else {
            exitDiloge();
          }
        },
        child: Stack(
          children: [
            // ✅ RepaintBoundary لعزل إعادة الرسم
            RepaintBoundary(
              child: GetBuilder<HomescreenControllerImple>(
                builder: (ctrl) => ctrl.pages[ctrl.pageindexHome],
              ),
            ),

            // ✅ Bottom bar مع RepaintBoundary
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: RepaintBoundary(child: Custbottonappbar()),
            ),
          ],
        ),
      ),
    );
  }
}
