import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_add_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_addorremove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AddorrmoveController extends GetxController {
  Future<void> addprise({
    required CartModel cartModel,
    required String availablequantity,
  });
  Future<void> removprise({required CartModel cartModel});
  Future<int> cartquintty(int productid, String attributes);
  Future<void> add(
    String productid,
    String producttitle,
    String productimage,
    String productprice,
    String platform,
    String quantity,
    String attributes,
    String availableqQuantity,
  );
}

class AddorrmoveControllerimple extends AddorrmoveController {
  CartAddorremoveData cartAddorremoveData = CartAddorremoveData(Get.find());
  CartviweData cartData = CartviweData(Get.find());
  CartAddData cartAddData = CartAddData(Get.find());
  late Statusrequest statusRequest;
  MyServises myServices = Get.find();

  Map<String, bool> isCart = {};
  // Map<String, int> cartQuantities = {};

  @override
  add(
    productid,
    producttitle,
    productimage,
    productprice,
    platform,
    quantity,
    attributes,
    availableqQuantity,
  ) async {
    statusRequest = Statusrequest.loading;
    var response = await cartAddData.addcart(
      userId: myServices.sharedPreferences.getString("user_id")!,
      productid: productid,
      producttitle: producttitle,
      productimage: productimage,
      productprice: productprice,
      platform: platform,
      quantity: quantity,
      attributes: attributes,
      availableqQuantity: availableqQuantity,
    );
    // print("response=>$response");
    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "add") {
        Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم اضافة المنتج الي السله "),
        );
      } else if (response['status'] == "success" &&
          response['message'] == "edit") {
        Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم تحديث المنتج في السله "),
        );
      } else {
        statusRequest = Statusrequest.failuer;
      }
      update();
    }
  }

  @override
  addprise({required cartModel, required availablequantity}) async {
    var response = await cartAddorremoveData.addprise(
      myServices.sharedPreferences.getString("user_id")!,
      cartModel.productId!.toString(),
      cartModel.cartAttributes!,
      availablequantity,
    );

    print("response=>$response");
    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "edit") {
        int currentQuantity = int.parse(cartModel.cartQuantity!);
        cartModel.cartQuantity = (currentQuantity + 1).toString();
        Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم زيادة الكمية"),
        );
        update(['fetchCart']);
      } else if (response['message'] == "full") {
        Get.rawSnackbar(title: "اشعار", messageText: const Text("غير متاح"));
      } else {
        statusRequest = Statusrequest.failuer;
      }
    }
  }

  @override
  removprise({required cartModel}) async {
    var response = await cartAddorremoveData.addremov(
      myServices.sharedPreferences.getString("user_id")!,
      cartModel.productId!.toString(),
      cartModel.cartAttributes!,
    );

    // print("response=>$response");
    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "edit") {
        int currentQuantity = int.parse(cartModel.cartQuantity!);
        if (currentQuantity > 1) {
          cartModel.cartQuantity = (currentQuantity - 1).toString();
          Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم تقليل الكميه بمقدار 1 "),
          );
          update();
        }
      } else {
        statusRequest = Statusrequest.failuer;
      }
    }
  }

  @override
  cartquintty(productid, attributes) async {
    statusRequest = Statusrequest.loading;
    var response = await cartAddData.cartquantity(
      userId: myServices.sharedPreferences.getString("user_id")!,
      productid: productid.toString(),
      attributes: attributes,
    );

    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      int quantity = int.tryParse(response['data'].toString()) ?? 0;

      if (response['status'] == "success") {
        return quantity;
      } else {
        statusRequest = Statusrequest.failuer;
        return quantity;
      }
    }
    update();
    return 0;
  }

  // Future<void> fetchCart() async {
  //   String userId = myServices.sharedPreferences.getString("user_id") ?? "0";
  //   if (userId == "0") return;

  //   var response = await cartData.getData(userId);

  //   if (response is Map &&
  //       response['status'] == 'success' &&
  //       response['data'] != null) {
  //     List cartlist = response['data'];
  //     // print("cartlist=>$cartlist");
  //     isCart.clear();
  //     for (var item in cartlist) {
  //       isCart[item['productId'].toString()] = true;
  //       // print("isCart=>${isCart}");
  //     }
  //   }
  //   update(['fetchCart']);
  // }

  // Future<void> fetchCart() async {
  //   String userId = myServices.sharedPreferences.getString("user_id") ?? "0";
  //   if (userId == "0") return;

  //   var response = await cartData.getData(userId);

  //   if (response is Map &&
  //       response['status'] == 'success' &&
  //       response['data'] != null) {
  //     List cartlist = response['data'];
  //     // print("cartlist=>$cartlist");
  //     cartQuantities.clear();
  //     for (var item in cartlist) {
  //       isCart[item['productId'].toString()] = true;
  //       String productId = item['productId'].toString();
  //       int qu = int.tryParse(item['cart_quantity']?.toString() ?? '0') ?? 0;

  //       if (cartQuantities.containsKey(productId)) {
  //         cartQuantities[productId] = cartQuantities[productId]! + qu;
  //       } else {
  //         cartQuantities[productId] = qu;
  //       }
  //     }
  //   }
  //   update(['fetchCart']);
  // }

  // int getQuantityForProduct(String productId) {
  //   return cartQuantities[productId] ?? 0;
  // }
}
