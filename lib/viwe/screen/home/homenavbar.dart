import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/funcations/exitdiloge.dart';
import 'package:e_comerece/viwe/widget/home/custbottonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homenavbar extends StatefulWidget {
  const Homenavbar({super.key});

  @override
  State<Homenavbar> createState() => _HomenavbarState();
}

class _HomenavbarState extends State<Homenavbar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late HomescreenControllerImple controller;

  @override
  void initState() {
    super.initState();
    // ضع الكنترولر هنا مرة واحدة فقط
    controller = Get.put(HomescreenControllerImple());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          exitDiloge();
        },
        child: Stack(
          children: [
            GetBuilder<HomescreenControllerImple>(
              // id: 'changePage',
              builder: (controller) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final bool isForward =
                        controller.pageindexHome > controller.previousIndex;

                    final offsetTween = Tween<Offset>(
                      begin: isForward
                          ? const Offset(1.0, 0.0)
                          : const Offset(-1.0, 0.0),
                      end: Offset.zero,
                    );
                    final offsetAnimation = offsetTween.animate(animation);
                    final fadeAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    );
                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: child,
                      ),
                    );
                  },
                  // نفّذ Key على الطفل الفعلي حتى يميّزه AnimatedSwitcher
                  child: KeyedSubtree(
                    key: ValueKey<int>(controller.pageindexHome),
                    child: SizedBox.expand(
                      child: controller.pages.elementAt(
                        controller.pageindexHome,
                      ),
                    ),
                  ),
                );
              },
            ),

            // bottom bar ثابت فوق
            Positioned(left: 0, right: 0, bottom: 0, child: Custbottonappbar()),
          ],
        ),
      ),
    );
  }
}
