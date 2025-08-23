import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<bool> exitDiloge() {
  Get.defaultDialog(
    title: "تحذير",
    middleText: "هل تريد الخروج من التطبيق نهائيا",
    actions: [
      ElevatedButton(
        onPressed: () {
          exit(0);
        },
        child: Text("خروج"),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("الغاء"),
      ),
    ],
  );
  return Future.value(true);
}
