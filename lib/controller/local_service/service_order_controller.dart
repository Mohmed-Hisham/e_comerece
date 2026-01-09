import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/funcations/success_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';

class ServiceOrderController extends GetxController {
  late LocalServiceData service;
  late double quotedPrice;
  TextEditingController noteController = .new();

  LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
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
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    update();

    String addressid = await myServises.getSecureData("default_address") ?? "";

    if (addressid == "") {
      showCustomGetSnack(isGreen: false, text: "Please select an address");
      statusRequest = Statusrequest.none;
      update();
      return;
    }

    var response = await localServiceRepoImpl.addServiceRequest(
      ServiceRequestData(
        serviceId: service.id,
        note: noteController.text,
        addressId: addressid,
        quotedPrice: quotedPrice,
        status: "paid",
      ),
    );

    await response.fold(
      (l) async {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        statusRequest = Statusrequest.failuer;
      },
      (message) async {
        statusRequest = Statusrequest.success;
        if (Get.isDialogOpen ?? false) Get.back();

        if (chatId != null) {
          try {
            await Get.find<SupabaseService>().updateChatStatus(
              chatId: chatId!,
              status: 'closed',
            );

            await Get.find<SupabaseService>().sendMessage(
              chatId: chatId!,
              content: "chat ended",
              senderType: 'admin',
            );
          } catch (e) {
            log("Error closing chat: $e");
          }
        }

        successDialog(
          title: "Success",
          body: "Order placed successfully",
          onBack: () {
            Get.back(); // close dialog
            Get.back(result: true); // go back to previous screen
          },
          onHome: () {
            Get.offAllNamed(AppRoutesname.homepage);
          },
        );
      },
    );
    update();
  }
}
