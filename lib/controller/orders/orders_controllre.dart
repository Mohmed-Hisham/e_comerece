import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:e_comerece/data/repository/orders/orders_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderStatus {
  pendingReview, // انتظار مراجعة الأدمن
  adminNotes, // ملاحظات من الأدمن - اليوزر يراجع
  approved, // موافقة الأدمن
  awaitingPayment, // انتظار الدفع
  paid, // تم الدفع
  processing, // في الطلب
  inTransit, // في الطريق
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

  OrderStatus orderStatus = OrderStatus.pendingReview;

  String orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendingReview:
        return "PendingReview";
      case OrderStatus.adminNotes:
        return "AdminNotes";
      case OrderStatus.approved:
        return "Approved";
      case OrderStatus.awaitingPayment:
        return "AwaitingPayment";
      case OrderStatus.paid:
        return "Paid";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.inTransit:
        return "InTransit";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }

  String getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendingReview:
        return "Pending Review";
      case OrderStatus.adminNotes:
        return "Admin Notes";
      case OrderStatus.approved:
        return "Approved";
      case OrderStatus.awaitingPayment:
        return "Awaiting Payment";
      case OrderStatus.paid:
        return "Paid";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.inTransit:
        return "In Transit";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.cancelled:
        return "Cancelled";
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
