import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/home/custbottonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomescreenControllerImple());
    return GetBuilder<HomescreenControllerImple>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Appcolor.primrycolor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            onPressed: () {
              controller.gotocart();
            },
            icon: Icon(Icons.card_travel, size: 30),
            color: Appcolor.white,
          ),
        ),

        bottomNavigationBar: Custbottonappbar(),
        body: controller.pages.elementAt(controller.pageindex),
      ),
    );
  }
}
