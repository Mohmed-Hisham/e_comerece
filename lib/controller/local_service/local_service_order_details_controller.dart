import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/local_service/get_details_order_local_service_data.dart';
import 'package:e_comerece/data/model/local_service/get_details_order_local_service_model.dart';
import 'package:e_comerece/data/datasource/remote/local_service/cancel_order_data.dart';
import 'package:flutter/material.dart'; // For Widget/Material types in dialog
import 'package:get/get.dart';

class LocalServiceOrderDetailsController extends GetxController {
  GetDetailsOrderLocalServiceData getDetailsOrderLocalServiceData =
      GetDetailsOrderLocalServiceData(Get.find());

  late GetDetailsOrderLocalServiceModel orderDetails;
  Statusrequest statusrequest = Statusrequest.none;
  late int orderId;

  CancelOrderData cancelOrderData = CancelOrderData(Get.find());

  @override
  void onInit() {
    orderId = Get.arguments['order_id'];
    getData();
    super.onInit();
  }

  getData() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await getDetailsOrderLocalServiceData.getDetailsOrder(
      orderId: orderId,
    );
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        orderDetails = GetDetailsOrderLocalServiceModel.fromJson(response);
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  cancelOrder() async {
    if (orderDetails.data?.order?.status == 'cancelled') return;

    statusrequest = Statusrequest.loading;
    update();

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    var response = await cancelOrderData.cancelOrder(
      orderId.toString(),
      "cancelled", // or the appropriate status string expected by backend
    );

    Get.back(); // Close loading dialog

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.defaultDialog(
          title: "نجاح",
          middleText: "تم إلغاء الطلب بنجاح",
          onConfirm: () {
            getData(); // Refresh data
            Get.back(); // Close success dialog
          },
        );
      } else {
        Get.defaultDialog(title: "تنبيه", middleText: "فشل إلغاء الطلب");
      }
    }
    update();
  }
}
