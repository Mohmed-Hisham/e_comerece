import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/orders/add_orders_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckOutController extends GetxController {
  Future<void> checkOut();
}

class CheckOutControllerImpl extends CheckOutController {
  AddOrdersData addOrdersData = AddOrdersData(Get.find());
  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;
  final PageController pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 2,
  );

  List<CartModel> cartItems = [];
  String? couponCode;
  double discount = 0;
  double? total;
  bool isShowMore = false;
  @override
  void onInit() {
    super.onInit();
    cartItems = Get.arguments?['cartItems'];
    couponCode = Get.arguments?['couponCode'];
    discount = Get.arguments?['discount'] ?? 0;
    total = Get.arguments['total'];
  }

  @override
  Future<void> checkOut() async {
    statusrequest = Statusrequest.loading;
    int id = int.parse(
      myServises.sharedPreferences.getString("user_id") ?? "0",
    );
    int addressid = myServises.sharedPreferences.getInt("default_address") ?? 0;
    if (id == 0 || addressid == 0) {
      statusrequest = Statusrequest.failuer;
      update();
      return;
    }

    // step 1 check Payment method
    List<Map<String, dynamic>> itemsList = cartItems
        .map(
          (element) => {
            "product_id": element.productId,
            "product_platform": element.cartPlatform,
            "product_title": element.cartProductTitle,
            "product_link": element.productink,
            "product_image": element.cartProductImage,
            "product_price": element.cartPrice,
            "quantity": element.cartQuantity,
            "attributes": element.cartAttributes,
          },
        )
        .toList();

    final response = await addOrdersData.addOrder(
      userId: id,
      addressId: addressid,
      discountAmount: discount,
      platformCode: "",
      items: itemsList,
      couponCode: couponCode ?? "",
      shippingAmount: 0,
      paymentMethod: "visa",
      applyCouponNow: discount > 0,
    );
    log('response: $response');
    statusrequest = handlingData(response);
    if (statusrequest == Statusrequest.success) {
      if (response['status'] == 'success') {
        log('${response['data']}');
      }
    }
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
}
