import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_add_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_addorremove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:get/get.dart';

abstract class AddorrmoveController extends GetxController {
  Future<void> addprise({
    required CartModel cartModel,
    required int availablequantity,
  });
  Future<void> removprise({required CartModel cartModel});
  Future<Map<String, dynamic>> cartquintty(String productid, String attributes);
  Future<void> add(
    String productid,
    String producttitle,
    String productimage,
    double productprice,
    String platform,
    int quantity,
    String attributes,
    int availableqQuantity, {
    String? tier,
    String? goodsSn,
    String? categoryId,
    required String porductink,
  });
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
    availableqQuantity, {
    tier,
    goodsSn,
    categoryId,
    required porductink,
  }) async {
    statusRequest = Statusrequest.loading;
    var response = await cartAddData.addcart(
      userId: int.parse(myServices.sharedPreferences.getString("user_id")!),
      productid: productid.toString(),
      producttitle: producttitle,
      productimage: productimage,
      productprice: productprice,
      platform: platform,
      quantity: quantity,
      attributes: attributes,
      availableqQuantity: availableqQuantity,
      tier: tier,
      categoryId: categoryId,
      goodsSn: goodsSn,
      productLink: porductink,
    );
    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "add") {
        showCustomGetSnack(
          isGreen: true,
          text: StringsKeys.productAddedToCart.tr,
        );
      } else if (response['status'] == "success" &&
          response['message'] == "edit") {
        showCustomGetSnack(
          isGreen: true,
          text: StringsKeys.productUpdatedInCart.tr,
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

    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "edit") {
        int currentQuantity = cartModel.cartQuantity!;
        cartModel.cartQuantity = (currentQuantity + 1);
        Get.rawSnackbar(
          title: StringsKeys.alert.tr,
          messageText: Text(StringsKeys.quantityIncreased.tr),
        );
        update(['fetchCart']);
      } else if (response['message'] == "full") {
        Get.rawSnackbar(
          title: StringsKeys.alert.tr,
          messageText: Text(StringsKeys.notAvailable.tr),
        );
        statusRequest = Statusrequest.failuer;
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

    statusRequest = handlingData(response);
    if (Statusrequest.success == statusRequest) {
      if (response['status'] == "success" && response['message'] == "edit") {
        int currentQuantity = cartModel.cartQuantity!;
        if (currentQuantity > 1) {
          cartModel.cartQuantity = (currentQuantity - 1);
          Get.rawSnackbar(
            title: StringsKeys.alert.tr,
            messageText: Text(StringsKeys.quantityDecreased.tr),
          );
          update(['fetchCart']);
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
      final int quantity =
          int.tryParse(response['cart_quantity'].toString()) ?? 0;
      final bool infavorite = response['in_favorite'];

      if (response['status'] == "success") {
        return {"quantity": quantity, "in_favorite": infavorite};
      } else {
        statusRequest = Statusrequest.failuer;
        return {"quantity": 0, "in_favorite": false};
      }
    }
    update();
    return {"quantity": 0, "in_favorite": false};
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
