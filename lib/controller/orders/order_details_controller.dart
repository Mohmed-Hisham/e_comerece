import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/orders/cancel_order.dart';
import 'package:e_comerece/data/model/ordres/order_details_model.dart';
import 'package:e_comerece/data/repository/orders/orders_repo_impl.dart';
import 'package:e_comerece/core/servises/supabase_service.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderDetailsController extends GetxController {
  Future<void> getOrderDetails(String orderId);
  Future<void> cancelOrder();
}

class OrderDetailsControllerImp extends OrderDetailsController {
  OrdersRepoImpl ordersRepo = OrdersRepoImpl(apiService: Get.find());
  CancelOrderData cancelOrderData = CancelOrderData(Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  OrderDetailsData? orderData;
  bool isCancelling = false;

  // Chat related
  late TextEditingController messsageController;
  ScrollController chatScrollController = ScrollController();
  Stream<List<Message>>? messagesStream;
  bool isChatClosed = false;
  Statusrequest sendMessagestatusrequest = Statusrequest.none;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  String? plateform;
  String? chatid;
  dynamic serviceRequestDetails;
  dynamic serviceModel;

  @override
  void onInit() {
    super.onInit();
    // Assuming passed argument is order_id as String now, or we convert it.
    // The previous code had `int? orderId`. GUIDs are Strings.
    // I will try to support both or expect String.
    var orderIdArg = Get.arguments['order_id'];
    if (orderIdArg != null) {
      getOrderDetails(orderIdArg.toString());
    }
    messsageController = TextEditingController();
  }

  void scrollToBottom() {
    if (chatScrollController.hasClients) {
      chatScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    messsageController.dispose();
    chatScrollController.dispose();
    focusNode.dispose();
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
        if (orderData!.chatId != null) {
          chatid = orderData!.chatId;
          initChat(chatid!);
        }
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

  void initChat(String chatId) {
    messagesStream = Get.find<SupabaseService>()
        .getMessagesStream(chatId)
        .map((data) => data.map((e) => Message.fromJson(e)).toList());
    checkChatStatus(chatId);
    update();
  }

  Future<void> checkChatStatus(String chatId) async {
    try {
      final chatData = await Get.find<SupabaseService>().getChatById(chatId);
      if (chatData != null && chatData['status'] == 'closed') {
        isChatClosed = true;
        update();
      }
    } catch (e) {
      debugPrint("Error checking chat status: $e");
    }
  }

  Future<void> sendMessage({
    String? platform,
    String? referenceid,
    String? imagelink,
  }) async {
    if (messsageController.text.trim().isEmpty || chatid == null) {
      return;
    }

    sendMessagestatusrequest = Statusrequest.loading;
    update();

    final content = messsageController.text.trim();
    messsageController.clear();

    await Get.find<SupabaseService>().sendMessage(
      chatId: chatid!,
      content: content,
      senderType: 'user',
    );

    sendMessagestatusrequest = Statusrequest.success;
    update();

    scrollToBottom();
  }

  bool canCancelOrder() {
    if (orderData == null) return false;
    final status = orderData!.status?.toLowerCase();
    return status == 'pendingreview' ||
        status == 'adminnotes' ||
        status == 'approved' ||
        status == 'awaitingpayment' ||
        status == 'pending_approval'; // legacy
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
      orderId: orderData!.id!,
    );

    isCancelling = false;

    final processedStatus = handlingData(response);

    if (processedStatus == Statusrequest.success) {
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
        status: 'Cancelled', // Update status
        statusName: 'Cancelled',
        noteUser: orderData!.noteUser,
        noteAdmin: orderData!.noteAdmin,
        createdAt: orderData!.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
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
}
