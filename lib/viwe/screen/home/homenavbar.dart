import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/core/helper/lazy_indexed_stack.dart';
import 'package:e_comerece/viwe/widget/home/custbottonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homenavbar extends StatelessWidget {
  final int initialTab;
  const Homenavbar({super.key, this.initialTab = 0});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomescreenControllerImple());

    if (controller.pageindexHome != initialTab) {
      controller.setPageWithoutNav(initialTab);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          if (!controller.goBack()) {
            exitDiloge();
          }
        },
        child: Stack(
          children: [
            Obx(
              () => LazyIndexedStack(
                index: controller.pageIndex.value,
                children: controller.pages,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: const RepaintBoundary(child: Custbottonappbar()),
            ),
          ],
        ),
      ),
    );
  }
}
