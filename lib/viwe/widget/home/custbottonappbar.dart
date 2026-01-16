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
        decoration: BoxDecoration(
          color: Appcolor.white2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        height: 70.h,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(controller.pages.length, (i) {
              return Custombottonbar(
                text: controller.nameBottonBar[i]['title'],
                iconPath: controller.nameBottonBar[i]['icon'],
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
