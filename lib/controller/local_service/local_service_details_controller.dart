import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';

import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalServiceDetailsController extends GetxController {
  late LocalServiceData service;

  // Dependencies
  // AddOrderLocalServiceData addOrderLocalServiceData = AddOrderLocalServiceData(
  //   Get.find(),
  // );
  MyServises myServises = Get.find();

  // State
  Statusrequest statusrequest = Statusrequest.none;
  TextEditingController noteController = .new();

  // UI State for BottomSheet expansion
  bool isShowMore = false;

  @override
  void onInit() {
    service = Get.arguments['service'];
    super.onInit();
  }

  void toggleShowMore() {
    isShowMore = !isShowMore;
    update();
  }

  void goToChat() {
    Get.toNamed(
      AppRoutesname.messagesScreen,
      arguments: {
        "platform": "local_service",
        "reference_id": service.id,
        "service_model": service,
        "auto_message":
            "I want to request this service: ${service.serviceName}",
      },
    );
  }
}
