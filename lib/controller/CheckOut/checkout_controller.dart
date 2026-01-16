import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/checkout/checkout_review_fee_model.dart';
import 'package:e_comerece/data/model/ordres/create_order_request.dart';
import 'package:e_comerece/data/repository/Checkout/checkout_repo_impl.dart';
import 'package:e_comerece/data/repository/orders/orders_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckOutController extends GetxController {
  Future<void> placeOrder();
  void updateTip(double amount);
}

class CheckOutControllerImpl extends CheckOutController {
  OrdersRepoImpl ordersRepo = OrdersRepoImpl(apiService: Get.find());
  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;
  // pageController no longer needed for vertical list, but keeping if referenced
  final PageController pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 2,
  );

  List<CartData> cartItems = [];
  String? couponCode;
  String? couponId;
  double discount = 0;
  double? total;
  // Address
  bool isShowMore = false; // Legacy, can keep or remove

  double selectedTip = 0.0;
  // Custom Tip
  bool isCustomTipInputVisible = false;
  TextEditingController customTipController = TextEditingController();
  // Order Note
  TextEditingController noteController = TextEditingController();

  void toggleCustomTipInput() {
    isCustomTipInputVisible = !isCustomTipInputVisible;
    if (!isCustomTipInputVisible) {
      customTipController.clear();
    }
    update(['tips']);
  }

  void applyCustomTip() {
    if (customTipController.text.isNotEmpty) {
      final double? amount = double.tryParse(customTipController.text);
      if (amount != null && amount > 0) {
        updateTip(amount);
        isCustomTipInputVisible = false;
      } else {
        Get.snackbar("Invalid Amount", "Please enter a valid number");
      }
    }
  }

  // Review Fee
  CheckoutRepoImpl checkoutRepo = CheckoutRepoImpl(apiService: Get.find());
  CheckoutReviewFeeData? reviewFeeData;
  bool isReviewFeeEnabled = false;
  double reviewFeeAmount = 0.0;

  @override
  void onInit() {
    super.onInit();
    cartItems = Get.arguments?['cartItems'] ?? [];
    couponCode = Get.arguments?['couponCode'];
    couponId = Get.arguments?['couponId'];
    discount = Get.arguments?['discount'] ?? 0;
    total = Get.arguments['total'];
    getReviewFee();
  }

  double getSubtotal() {
    double sum = 0.0;
    for (var e in cartItems) {
      double price = e.productPrice ?? 0.0;
      double count = (e.cartQuantity ?? 0).toDouble();
      sum += (price * count);
    }
    return sum;
  }

  double getFinalTotal() {
    double subTotal = getSubtotal();
    double totalVal = subTotal - discount; // Apply discount
    if (isReviewFeeEnabled) totalVal += reviewFeeAmount;
    totalVal += selectedTip;
    // Add Delivery Fee if available (currently hardcoded 0 or not in controller properly)
    // Assuming 'total' arg passed in includes basic calc, but let's recalculate mostly.
    return totalVal > 0 ? totalVal : 0;
  }

  // @override
  // void updatePaymentMethod(String method) {
  //   selectedPaymentMethod = method;
  //   update(['payment']);
  // }

  @override
  void updateTip(double amount) {
    if (selectedTip == amount) {
      selectedTip = 0.0; // toggle off
    } else {
      selectedTip = amount;
    }
    update(['tips', 'breakdown']);
  }

  // @override
  // void updateAlternativeAction(String action) {
  //   selectedAlternativeAction = action;
  //   update(['alternative']);
  // }

  @override
  Future<void> placeOrder() async {
    statusrequest = Statusrequest.loading;
    update();

    String addressId = await myServises.getSecureData("default_address") ?? "";

    if (addressId.isEmpty) {
      showCustomGetSnack(
        isGreen: false,
        text: "Please select a delivery address",
      );
      statusrequest = Statusrequest.none;
      update();
      return;
    }

    String userNote = noteController.text.isNotEmpty
        ? "Note: ${noteController.text} | "
        : "";
    String finalNote = userNote; // Removed tip from note as it's now a field

    final request = CreateOrderRequest(
      addressId: addressId,
      productReviewFee: isReviewFeeEnabled ? reviewFeeAmount : 0,
      couponId: couponId,
      noteUser: finalNote.isEmpty ? null : finalNote,
      paymentMethod: 'Watting',
      deliveryFee: 0,
      deliveryTips: selectedTip,
    );

    final response = await ordersRepo.createOrder(request);

    response.fold((failure) {}, (data) {
      statusrequest = Statusrequest.success;
      showCustomGetSnack(isGreen: true, text: "Order placed successfully");
      Get.toNamed(AppRoutesname.homepage);
    });

    update();
  }

  showMore() {
    if (isShowMore) {
      isShowMore = false;
      update(['location']);
    } else {
      isShowMore = true;
      update(['location']);
    }
  }

  getReviewFee() async {
    final response = await checkoutRepo.getCheckOutReviewFee();
    response.fold(
      (failure) {
        log('Error fetching review fee: ${failure.errorMessage}');
      },
      (model) {
        if (model.data != null) {
          reviewFeeData = model.data;
          reviewFeeAmount = model.data!.value ?? 0.0;
        }
        update(['reviewFee', 'breakdown']);
      },
    );
  }

  void toggleReviewFee(bool value) {
    isReviewFeeEnabled = value;
    // total calculation is now dynamic in getFinalTotal(), but we might need to update total var if used elsewhere
    update(['reviewFee', 'breakdown']);
  }

  void showReviewFeeInfo(BuildContext context) {
    if (reviewFeeData == null) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(reviewFeeData!.key ?? 'Info'),
        content: Text(
          reviewFeeData!.description ?? 'No description available.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
