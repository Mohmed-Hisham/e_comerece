import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

loadingDialog() {
  Get.dialog(
    PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
      },
      child: Center(
        child: CircularProgressIndicator(color: Appcolor.primrycolor),
      ),
    ),
  );
}
