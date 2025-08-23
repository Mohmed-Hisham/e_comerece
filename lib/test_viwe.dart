import 'package:e_comerece/controller/test_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class TestViwe extends StatelessWidget {
  const TestViwe({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Tset"),
        backgroundColor: Appcolor.primrycolor,
      ),

      body: GetBuilder<TestController>(
        builder: (controller) {
          return Handlingdataviwe(
            statusrequest: controller.statusrequest,
            widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, i) {
                return Center(child: Text("${controller.data}"));
              },
            ),
          );
        },
      ),
    );
  }
}
