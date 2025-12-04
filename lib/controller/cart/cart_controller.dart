import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/coupon/get_coupon_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_addorremove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_remove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/coupon_model/get_coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  void gotoditels({
    required id,
    required String lang,
    required String title,
    required String asin,
    required String goodssn,
    required String goodsid,
    required String categoryid,
    required String platform,
  });
}

class CartControllerImpl extends CartController {
  CartviweData cartData = CartviweData(Get.find());
  CartRemoveData removeData = CartRemoveData(Get.find());
  CartAddorremoveData cartAddorremoveData = CartAddorremoveData(Get.find());
  GetCouponData getCouponData = GetCouponData(Get.find());
  TextEditingController couponController = TextEditingController();

  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest couPonstatusrequest = Statusrequest.none;

  List<CartModel> cartItems = [];
  String? couponCode;
  double? discount;

  double totalbuild = 0.0;
  Map<String, List<CartModel>> cartByPlatform = {};
  groupcartByPlatform() {
    cartByPlatform = {};
    for (var cartitem in cartItems) {
      String platform = cartitem.cartPlatform ?? 'Uncategorized';
      if (cartByPlatform.containsKey(platform)) {
        cartByPlatform[platform]!.add(cartitem);
      } else {
        cartByPlatform[platform] = [cartitem];
      }
    }
  }

  double total() {
    double sum = 0.0;
    for (var e in cartItems) {
      String cleanPrice = e.cartPrice.toString().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      double price = double.tryParse(cleanPrice) ?? 0.0;
      double count = double.tryParse(e.cartQuantity!.toString()) ?? 0.0;
      double s = price * count;
      sum += s;
    }
    if (discount != null) {
      sum -= discount!;
    }
    return sum;
  }

  getCartItems() async {
    statusrequest = Statusrequest.loading;
    update();
    update(['1']);
    int id = int.parse(myServises.sharedPreferences.getString("user_id")!);
    var response = await cartData.getData(id);
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        cartItems = responseData.map((e) => CartModel.fromJson(e)).toList();
        groupcartByPlatform();
        totalbuild = total();
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
    update(['1']);
  }

  removeItem(int cartId) async {
    Get.dialog(
      barrierDismissible: false,
      Center(child: CircularProgressIndicator()),
    );

    await removeData.removeCart(
      int.parse(myServises.sharedPreferences.getString("user_id")!),
      cartId,
    );
    getCartItems();
    if (Get.isDialogOpen ?? false) Get.back();
    update();
  }

  addprise({required CartModel cartModel}) async {
    int availableQuantity = cartModel.cartAvailableQuantity!;
    int currentTotalInCart = cartModel.cartQuantity!;
    if (currentTotalInCart >= availableQuantity) {
      Get.rawSnackbar(
        title: "تنبيه",
        messageText: const Text(
          "لقد وصلت إلى أقصى كمية متاحة لهذا المنتج بكل خياراته",
        ),
        backgroundColor: Colors.orange,
      );
      return;
    }

    var response = await cartAddorremoveData.addprise(
      myServises.sharedPreferences.getString("user_id")!,
      cartModel.productId!.toString(),
      cartModel.cartAttributes!,
      cartModel.cartAvailableQuantity!,
    );

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == "success" && response['message'] == "edit") {
        int currentQuantity = cartModel.cartQuantity!;
        cartModel.cartQuantity = (currentQuantity + 1);
        totalbuild = total();

        update(['1']);
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
  }

  removprise({required CartModel cartModel}) async {
    int currentQuantity = cartModel.cartQuantity!;
    if (currentQuantity > 1) {
      await cartAddorremoveData.addremov(
        myServises.sharedPreferences.getString("user_id")!,
        cartModel.productId!.toString(),
        cartModel.cartAttributes!,
      );

      cartModel.cartQuantity = (currentQuantity - 1);
      totalbuild = total();
      update(['1']);
    }
  }

  checkCoupon() async {
    int id = int.parse(myServises.sharedPreferences.getString("user_id")!);
    bool found = false;
    couPonstatusrequest = Statusrequest.loading;
    update(['coupon']);
    var response = await getCouponData.getCoupon(
      couponController.text.trim(),
      id,
    );

    couPonstatusrequest = handlingData(response);
    log("coupon: $couPonstatusrequest");
    if (Statusrequest.success == couPonstatusrequest) {
      final responsModel = CouponResponse.fromJson(response);
      if (responsModel.status == 'success') {
        final model = CouponResponse.fromJson(response);
        if (model.data?.couponPlatform!.toLowerCase() == "all") {
          couponCode = model.data?.couponName;
          discount = model.data?.couponDiscount;
          totalbuild = total();
          showCustomGetSnack(isGreen: true, text: "تم تطبيق الكوبون بنجاح");
          couponController.clear();
          found = true;
        } else {
          for (var plat in cartByPlatform.keys) {
            if (plat.toLowerCase() ==
                model.data?.couponPlatform!.toLowerCase()) {
              couponCode = model.data?.couponName;
              discount = model.data?.couponDiscount;
              totalbuild = total();
              showCustomGetSnack(isGreen: true, text: "تم تطبيق الكوبون بنجاح");
              couponController.clear();
              found = true;
              break;
            }
          }

          if (!found) {
            showCustomGetSnack(
              duration: const Duration(minutes: 10),
              isGreen: false,
              text:
                  "الكوبون خاص بمنصة ${model.data?.couponPlatform!}، ولا يوجد منتجات منها في السلة.",
            );
          }
        }
      }
    } else if (couPonstatusrequest == Statusrequest.failuer) {
      showCustomGetSnack(
        isGreen: false,
        text: " الكوبون مستخدم من قبل او منتهى صلاحيته",
      );
    } else if (couPonstatusrequest == Statusrequest.noData) {
      showCustomGetSnack(isGreen: false, text: " الكوبون غير صحيح");
    } else {
      couPonstatusrequest = Statusrequest.failuerTryAgain;
    }
    update(['coupon', '1']);
  }

  String goTODetails(String platform) {
    final source = PlatformExt.fromString(platform);

    switch (source) {
      case PlatformSource.aliexpress:
        return AppRoutesname.detelspage;

      case PlatformSource.alibaba:
        return AppRoutesname.productDetailsAlibabView;

      case PlatformSource.amazon:
        return AppRoutesname.productDetailsAmazonView;

      case PlatformSource.shein:
        return AppRoutesname.productDetailsSheinView;

      default:
        return '';
    }
  }

  @override
  gotoditels({
    required id,
    required lang,
    required title,
    required asin,
    required goodssn,
    required goodsid,
    required categoryid,
    required platform,
  }) {
    Get.toNamed(
      goTODetails(platform),
      arguments: {
        "product_id": id,
        "lang": lang,
        "title": title,
        "asin": asin,
        "goods_sn": goodssn,
        "goods_id": goodsid,
        "category_id": categoryid,
      },
    );
  }

  goTOCheckout() {
    if (cartItems.isEmpty) {
      showCustomGetSnack(isGreen: false, text: "السلة فارغة");
      return;
    }
    Get.toNamed(
      AppRoutesname.checkout,
      arguments: {
        "cartItems": cartItems,
        "couponCode": couponCode,
        "discount": discount,
        "total": totalbuild,
      },
    );
  }
}
