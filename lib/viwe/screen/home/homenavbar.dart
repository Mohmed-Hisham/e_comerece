import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/viwe/widget/home/custbottonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homenavbar extends StatefulWidget {
  final int initialTab;
  const Homenavbar({super.key, this.initialTab = 0});

  @override
  State<Homenavbar> createState() => _HomenavbarState();
}

class _HomenavbarState extends State<Homenavbar> {
  late HomescreenControllerImple controller;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomescreenControllerImple());

    _pageController = PageController(initialPage: widget.initialTab);

    if (controller.pageindexHome != widget.initialTab) {
      controller.setPageWithoutNav(widget.initialTab);
    }

    ever<int>(controller.pageIndex, (index) {
      if (_pageController.hasClients &&
          _pageController.page?.round() != index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            RepaintBoundary(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  if (controller.pageindexHome != index) {
                    controller.setPageWithoutNav(index);
                  }
                },
                children: controller.pages,
              ),
            ),

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
