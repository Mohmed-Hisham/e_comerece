import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/funcations/success_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';

class ServiceOrderController extends GetxController {
  LocalServiceData? service;
  late double quotedPrice;
  TextEditingController noteController = .new();

  LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
  );
  MyServises myServises = Get.find();

  Statusrequest statusRequest = Statusrequest.none;

  String? chatId;
  String? referenceId;

  @override
  void onInit() {
    service = Get.arguments['service_model'];
    quotedPrice = Get.arguments['quoted_price'];
    chatId = Get.arguments['chat_id'];
    referenceId = Get.arguments['reference_id'];
    log("quotedPrice $quotedPrice");
    log("chatId $chatId");
    log("referenceId $referenceId");

    if (service == null && referenceId != null) {
      _fetchServiceByReferenceId();
    }
    super.onInit();
  }

  Future<void> _fetchServiceByReferenceId() async {
    statusRequest = Statusrequest.loading;
    update();

    var response = await localServiceRepoImpl.getLocalServiceById(referenceId!);

    response.fold(
      (failure) {
        statusRequest = Statusrequest.failuer;
        showCustomGetSnack(isGreen: false, text: failure.errorMessage);
      },
      (model) {
        if (model.data.isNotEmpty) {
          service = model.data.first;
          statusRequest = Statusrequest.success;
        } else {
          statusRequest = Statusrequest.noData;
        }
      },
    );
    update();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  void confirmOrder() async {
    if (service == null) {
      showCustomGetSnack(isGreen: false, text: StringsKeys.serviceNotFound.tr);
      return;
    }

    statusRequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    update();

    String addressid = await myServises.getSecureData("default_address") ?? "";

    if (addressid == "") {
      showCustomGetSnack(
        isGreen: false,
        text: StringsKeys.pleaseSelectAddress.tr,
      );
      statusRequest = Statusrequest.none;
      update();
      return;
    }

    var response = await localServiceRepoImpl.addServiceRequest(
      ServiceRequestData(
        serviceId: service!.id,
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
            await Get.find<ApiService>().put(
              endPoints: ApisUrl.closeChat(chatId!),
              data: {},
            );
            log("Chat closed successfully");
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
