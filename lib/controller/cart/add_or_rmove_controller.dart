import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_add_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_addorremove_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AddorrmoveController extends GetxController {
  addprise({required CartModel cartModel, required String availablequantity});
  removprise({required CartModel cartModel});
}

class AddorrmoveControllerimple extends AddorrmoveController {
  CartAddorremoveData cartAddorremoveData = CartAddorremoveData(Get.find());
  CartAddData cartAddData = CartAddData(Get.find());
  late Statusrequest statusRequest;
  MyServises myServices = Get.find();

  add(
    String productid,
    String producttitle,
    String productimage,
    String productprice,
    String platform,
    String quantity,
    String attributes,
    String availableqQuantity,
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
    print("response=>$response");
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
    }
  }

  @override
  addprise({required CartModel cartModel, required availablequantity}) async {
    var response = await cartAddorremoveData.addprise(
      myServices.sharedPreferences.getString("user_id")!,
      cartModel.productId!,
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
        update();
      } else if (response['message'] == "full") {
        Get.rawSnackbar(title: "اشعار", messageText: const Text("غير متاح"));
      } else {
        statusRequest = Statusrequest.failuer;
      }
    }
  }

  @override
  removprise({required CartModel cartModel}) async {
    var response = await cartAddorremoveData.addremov(
      myServices.sharedPreferences.getString("user_id")!,
      cartModel.productId!,
      cartModel.cartAttributes!,
    );

    print("response=>$response");
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
}
