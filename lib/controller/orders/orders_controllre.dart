import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/orders/get_orders_data.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderStatus {
  pendingApproval, // قيد المراجعة
  approved, // تم الموافقة
  rejected, // مرفوض
  ordered, // تم الطلب من المنصة
  completed, // تم التسليم
  cancelled, // ملغي
}

abstract class OrdersControllre extends GetxController {
  Future<void> getOrders();
}

class OrdersControllreImp extends OrdersControllre {
  GetOrdersData getOrdersData = GetOrdersData(Get.find());
  Statusrequest statusrequestss = Statusrequest.loading;
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  List<Orders> data = [];
  ScrollController scrollController = ScrollController();

  OrderStatus orderStatus = OrderStatus.pendingApproval;
  String orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendingApproval:
        return "pending_approval";
      case OrderStatus.approved:
        return "approved";
      case OrderStatus.rejected:
        return "rejected";
      case OrderStatus.ordered:
        return "ordered";
      case OrderStatus.completed:
        return "completed";
      case OrderStatus.cancelled:
        return "cancelled";
    }
  }

  String getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendingApproval:
        return StringsKeys.orderStatusPendingApproval.tr;
      case OrderStatus.approved:
        return StringsKeys.orderStatusApproved.tr;
      case OrderStatus.rejected:
        return StringsKeys.orderStatusRejected.tr;
      case OrderStatus.ordered:
        return StringsKeys.orderStatusOrdered.tr;
      case OrderStatus.completed:
        return StringsKeys.orderStatusCompleted.tr;
      case OrderStatus.cancelled:
        return StringsKeys.orderStatusCancelled.tr;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  @override
  getOrders() async {
    statusrequest = Statusrequest.loading;
    int id = int.parse(
      myServises.sharedPreferences.getString("user_id") ?? "0",
    );

    if (id == 0) {
      statusrequest = Statusrequest.failuer;
      update();
      return;
    }
    update();
    final response = await getOrdersData.getOrders(
      userId: id,
      status: orderStatusToString(orderStatus),
    );
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      final result = GetOrderWithStatusModel.fromJson(response);
      data = result.data;
      if (data.isEmpty) {
        statusrequest = Statusrequest.noData;
      }
    } else {
      statusrequest = Statusrequest.failuer;
    }
    update();
  }
}
