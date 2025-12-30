import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/supabase_service.dart';
import 'package:e_comerece/data/datasource/remote/local_service/add_service_request_data.dart';
import 'package:e_comerece/viwe/screen/home/homenavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';

class ServiceOrderController extends GetxController {
  late Service service;
  late double quotedPrice;
  TextEditingController noteController = .new();

  AddServiceRequestData addServiceRequestData = AddServiceRequestData(
    Get.find(),
  );
  MyServises myServises = Get.find();

  Statusrequest statusRequest = Statusrequest.none;

  String? chatId;

  @override
  void onInit() {
    service = Get.arguments['service_model'];
    quotedPrice = Get.arguments['quoted_price'];
    chatId = Get.arguments['chat_id'];
    log("quotedPrice $quotedPrice");
    log("chatId $chatId");
    super.onInit();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  void confirmOrder() async {
    statusRequest = Statusrequest.loading;
    update();

    String userid = myServises.sharedPreferences.getString("user_id")!;
    int addressid = myServises.sharedPreferences.getInt("default_address") ?? 0;

    if (addressid == 0) {
      Get.snackbar("Alert", "Please select an address");
      statusRequest = Statusrequest.none;
      update();
      return;
    }

    var response = await addServiceRequestData.addServiceRequest(
      int.parse(userid),
      service.serviceId!,
      noteController.text,
      addressid,
      quotedPrice,
      "3",
    );

    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == 'success') {
        Get.snackbar("Success", "Order placed successfully");

        if (chatId != null) {
          try {
            // Update chat status to closed
            await Get.find<SupabaseService>().updateChatStatus(
              chatId: chatId!,
              status: 'closed',
            );

            // Send "Chat Ended" message
            String userid = myServises.sharedPreferences.getString("user_id")!;
            await Get.find<SupabaseService>().sendMessage(
              chatId: chatId!,
              senderId: userid,
              content: "chat ended",
              senderType: 'admin',
            );
          } catch (e) {
            log("Error closing chat: $e");
          }
        }

        Get.offAllNamed(AppRoutesname.homepage);
      } else {
        Get.snackbar("Error", "Failed to place order");
      }
    }
    update();
  }
}
