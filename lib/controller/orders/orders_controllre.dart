import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:e_comerece/data/repository/orders/orders_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderStatus {
  pending, // قيد المراجعة
  actionRequired, // تعديل من الإدارة - بانتظار العميل
  processing, // قيد التنفيذ
  shipped, // تم الشحن
  completed, // مكتمل
  cancelled, // ملغي
}

abstract class OrdersControllre extends GetxController {
  Future<void> getOrders();
}

class OrdersControllreImp extends OrdersControllre {
  OrdersRepoImpl ordersRepo = OrdersRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  List<Orders> data = [];
  ScrollController scrollController = ScrollController();

  OrderStatus orderStatus = OrderStatus.pending;

  String orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.actionRequired:
        return "ActionRequired";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }

  String getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "قيد المراجعة";
      case OrderStatus.actionRequired:
        return "بانتظار العميل";
      case OrderStatus.processing:
        return "قيد التنفيذ";
      case OrderStatus.shipped:
        return "تم الشحن";
      case OrderStatus.completed:
        return "مكتمل";
      case OrderStatus.cancelled:
        return "ملغي";
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
    update();

    final response = await ordersRepo.getUserOrders(
      status: orderStatusToString(orderStatus),
      page: 1,
      pageSize: 10,
    );

    statusrequest = response.fold((l) => Statusrequest.failuer, (r) {
      data = r.data;
      if (data.isEmpty) {
        return Statusrequest.noData;
      }
      return Statusrequest.success;
    });

    update();
  }
}
