import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/home/custombottonbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Custbottonappbar extends StatelessWidget {
  const Custbottonappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      builder: (controller) => Container(
        height: 80.h,
        color: Appcolor.white2,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Appcolor.white2, Color.fromARGB(255, 243, 126, 43)],
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(controller.pages.length, (i) {
              return Custombottonbar(
                // text: controller.nameBottonBar[i]['title'],
                iconData: controller.nameBottonBar[i]['icon'],
                textcolor: Colors.black,
                onPressed: () {
                  controller.changepage(i);
                },
                isactive: controller.pageindexHome == i ? true : false,
              );
            }),
          ],
        ),
      ),
    );
  }
}
