import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/ordres/order_details_model.dart';
import 'package:e_comerece/data/repository/orders/orders_repo_impl.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderDetailsController extends GetxController {
  Future<void> getOrderDetails(String orderId);
  Future<void> cancelOrder();
}

class OrderDetailsControllerImp extends OrderDetailsController {
  OrdersRepoImpl ordersRepo = OrdersRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  OrderDetailsData? orderData;
  bool isCancelling = false;

  Statusrequest sendMessagestatusrequest = Statusrequest.none;
  String? chatid;

  @override
  void onInit() {
    super.onInit();
    var orderIdArg = Get.arguments?['order_id'];
    if (orderIdArg != null) {
      getOrderDetails(orderIdArg.toString());
    }
  }

  void scrollToBottom() {
    // This method is no longer used after removing chat functionality
    // but kept if there's a future use case or for minimal change.
    // If not needed, it can be removed.
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future<void> getOrderDetails(String orderId) async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await ordersRepo.getOrderDetails(orderId);

    statusrequest = response.fold((failure) => Statusrequest.failuer, (
      dataModel,
    ) {
      if (dataModel.success == true && dataModel.data != null) {
        orderData = dataModel.data;
        chatid = orderData?.chatId;
        return Statusrequest.success;
      } else {
        return Statusrequest.failuer;
      }
    });

    if (statusrequest == Statusrequest.failuer) {
      // Handle specific failure message if needed
    }

    update();
  }

  void goToChat() {
    if (chatid != null) {
      Get.toNamed(
        AppRoutesname.messagesScreen,
        arguments: {
          'chat_id': chatid,
          'platform': 'order', // Optional: backend might use it
        },
      );
    }
  }

  bool canCancelOrder() {
    if (orderData == null) return false;
    final status = orderData!.status?.toLowerCase();
    // يمكن الإلغاء فقط إذا كان الطلب في حالة Pending أو ActionRequired
    return status == 'pending' || status == 'actionrequired';
  }

  @override
  Future<void> cancelOrder() async {
    if (!canCancelOrder()) {
      showCustomGetSnack(
        isGreen: false,
        text:
            'لا يمكن إلغاء هذا الطلب. يمكن إلغاء الطلبات في حالة المراجعة أو بانتظار العميل فقط',
        duration: const Duration(seconds: 3),
      );
      return;
    }

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('تأكيد الإلغاء'),
        content: const Text('هل أنت متأكد من إلغاء هذا الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('نعم، إلغاء الطلب'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isCancelling = true;
    update();

    final result = await ordersRepo.cancelOrder(orderData!.id!);

    isCancelling = false;

    result.fold(
      (failure) {
        showCustomGetSnack(
          isGreen: false,
          text: failure.errorMessage,
          duration: const Duration(seconds: 4),
        );
      },
      (response) {
        if (response['success'] == true) {
          // Create a new instance with updated status
          orderData = OrderDetailsData(
            id: orderData!.id,
            orderNumber: orderData!.orderNumber,
            addressId: orderData!.addressId,
            address: orderData!.address,
            paymentMethod: orderData!.paymentMethod,
            chatId: orderData!.chatId,
            subtotal: orderData!.subtotal,
            couponId: orderData!.couponId,
            coupon: orderData!.coupon,
            couponDiscount: orderData!.couponDiscount,
            couponName: orderData!.couponName,
            productReviewFee: orderData!.productReviewFee,
            deliveryTips: orderData!.deliveryTips,
            total: orderData!.total,
            status: 'Cancelled',
            statusName: 'Cancelled',
            noteUser: orderData!.noteUser,
            noteAdmin: orderData!.noteAdmin,
            createdAt: orderData!.createdAt,
            updatedAt: DateTime.now().toIso8601String(),
            items: orderData!.items,
          );

          showCustomGetSnack(
            isGreen: true,
            text: 'تم إلغاء الطلب بنجاح',
            duration: const Duration(seconds: 3),
          );
        } else {
          showCustomGetSnack(
            isGreen: false,
            text: response['message'] ?? 'حدث خطأ أثناء إلغاء الطلب',
            duration: const Duration(seconds: 4),
          );
        }
      },
    );

    update();
  }
}
