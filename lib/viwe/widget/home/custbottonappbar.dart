import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/viwe/widget/home/custombottonbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Custbottonappbar extends StatelessWidget {
  const Custbottonappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      builder: (controller) => BottomAppBar(
        // color: Colors.amber,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        child: Row(
          children: [
            ...List.generate(controller.pages.length + 1, (index) {
              int i = index > 2 ? index - 1 : index;
              return index == 2
                  ? Spacer()
                  : Custombottonbar(
                      // text: controller.nameBottonBar[i]['title'],
                      iconData: controller.nameBottonBar[i]['icon'],
                      textcolor: Colors.black,
                      onPressed: () {
                        controller.changepage(i);
                      },
                      isactive: controller.pageindex == i ? true : false,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
