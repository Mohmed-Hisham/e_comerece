import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/orders/cancel_order.dart';
import 'package:e_comerece/data/datasource/remote/orders/get_orders_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_add_data.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_id_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderDetailsController extends GetxController {
  Future<void> getOrderDetails(int orderId);
  Future<void> cancelOrder();
  Future<void> reorderItems();
}

class OrderDetailsControllerImp extends OrderDetailsController {
  GetOrdersData getOrdersData = GetOrdersData(Get.find());
  CancelOrderData cancelOrderData = CancelOrderData(Get.find());
  CartAddData cartAddData = CartAddData(Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  Data? orderData;
  bool isCancelling = false;
  bool isReordering = false;

  @override
  void onInit() {
    super.onInit();
    final orderId = Get.arguments['order_id'] as int?;
    if (orderId != null) {
      getOrderDetails(orderId);
    }
  }

  @override
  getOrderDetails(int orderId) async {
    statusrequest = Statusrequest.loading;
    update();

    int userId = int.parse(
      myServises.sharedPreferences.getString("user_id") ?? "0",
    );

    if (userId == 0) {
      statusrequest = Statusrequest.failuer;
      update();
      return;
    }

    final response = await getOrdersData.getOrders(
      userId: userId,
      orderId: orderId,
    );

    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      final result = GetOrderWithIdModel.fromJson(response);
      orderData = result.data;

      if (orderData == null) {
        statusrequest = Statusrequest.noData;
      }
    } else {
      statusrequest = Statusrequest.failuer;
    }

    update();
  }

  bool canCancelOrder() {
    if (orderData == null) return false;
    final status = orderData!.status?.toLowerCase();
    return status == 'pending_approval' || status == 'approved';
  }

  @override
  Future<void> cancelOrder() async {
    if (!canCancelOrder()) {
      Get.snackbar(
        'خطأ',
        'لا يمكن إلغاء هذا الطلب. يمكن إلغاء الطلبات قيد المراجعة أو المعتمدة فقط',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
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

    int userId = int.parse(
      myServises.sharedPreferences.getString("user_id") ?? "0",
    );

    if (userId == 0) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ. يرجى تسجيل الدخول مرة أخرى',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      isCancelling = false;
      update();
      return;
    }

    final response = await cancelOrderData.cancelOrder(
      userId: userId,
      orderId: orderData!.orderId!,
    );

    isCancelling = false;

    final processedStatus = handlingData(response);

    if (processedStatus == Statusrequest.success) {
      orderData = Data(
        orderId: orderData!.orderId,
        userId: orderData!.userId,
        status: 'cancelled',
        subtotal: orderData!.subtotal,
        discountAmount: orderData!.discountAmount,
        shippingAmount: orderData!.shippingAmount,
        totalAmount: orderData!.totalAmount,
        paymentMethod: orderData!.paymentMethod,
        paymentStatus: orderData!.paymentStatus,
        createdAt: orderData!.createdAt,
        updatedAt: DateTime.now(),
        address: orderData!.address,
        coupon: orderData!.coupon,
        items: orderData!.items,
      );

      Get.snackbar(
        'نجح',
        'تم إلغاء الطلب بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } else {
      String errorMessage = 'حدث خطأ أثناء إلغاء الطلب';

      if (response is Map && response.containsKey('message')) {
        errorMessage = response['message'] ?? errorMessage;
      }

      Get.snackbar(
        'خطأ',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }

    update();
  }

  bool canReorder() {
    if (orderData == null) return false;
    final status = orderData!.status?.toLowerCase();
    return status == 'completed' || status == 'cancelled';
  }

  @override
  Future<void> reorderItems() async {
    if (!canReorder()) {
      Get.snackbar(
        'خطأ',
        'لا يمكن إعادة طلب هذا الطلب. يمكن إعادة الطلبات المكتملة أو الملغية فقط',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (orderData!.items.isEmpty) {
      Get.snackbar(
        'خطأ',
        'لا توجد منتجات في هذا الطلب',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    isReordering = true;
    update();

    int userId = int.parse(
      myServises.sharedPreferences.getString("user_id") ?? "0",
    );

    if (userId == 0) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ. يرجى تسجيل الدخول مرة أخرى',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      isReordering = false;
      update();
      return;
    }

    int successCount = 0;
    int failCount = 0;

    for (var item in orderData!.items) {
      try {
        final response = await cartAddData.addcart(
          userId: userId,
          productid: item.productId?.toString() ?? '',
          producttitle: item.productTitle ?? '',
          productimage: item.productImage ?? '',
          productprice: double.tryParse(item.productPrice ?? '0') ?? 0.0,
          platform: item.productPlatform ?? '',
          productLink: item.productLink ?? '',
          quantity: item.quantity ?? 1,
          attributes: item.attributes ?? '{}',
          availableqQuantity: 999,
          tier: null,
          goodsSn: null,
          categoryId: null,
        );

        final processedStatus = handlingData(response);
        if (processedStatus == Statusrequest.success) {
          successCount++;
        } else {
          failCount++;
        }
      } catch (e) {
        failCount++;
      }
    }

    isReordering = false;
    update();

    if (successCount > 0) {
      Get.snackbar(
        'نجح',
        'تمت إضافة $successCount منتج إلى السلة${failCount > 0 ? ' (فشل إضافة $failCount منتج)' : ''}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate to cart
      Get.back();
      // Get.toNamed('/cartscreen');
    } else {
      Get.snackbar(
        'خطأ',
        'فشل في إضافة المنتجات إلى السلة. يرجى المحاولة مرة أخرى',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
