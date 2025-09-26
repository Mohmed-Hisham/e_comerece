import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_addorremove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cart_remove_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartviweData cartData = CartviweData(Get.find());
  CartRemoveData removeData = CartRemoveData(Get.find());
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  CartAddorremoveData cartAddorremoveData = CartAddorremoveData(Get.find());

  List<CartModel> cartItems = [];

  double totalbuild = 0.0;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double total() {
    double sum = 0.0;
    for (var e in cartItems) {
      String cleanPrice = e.cartPrice.toString().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      double price = double.tryParse(cleanPrice) ?? 0.0;
      double count = double.tryParse(e.cartQuantity!) ?? 0.0;
      double s = price * count;
      sum += s;
    }
    return sum;
  }

  getCartItems() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await cartData.getData(
      myServises.sharedPreferences.getString("user_id")!,
    );
    print("response=>$response");
    statusrequest = handlingData(response);
    print("statusrequest=>$statusrequest");
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        cartItems = responseData.map((e) => CartModel.fromJson(e)).toList();
        totalbuild = total();
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  removeItem(String cartId) async {
    cartItems.removeWhere((item) => item.cartId == cartId);
    totalbuild = total();
    update();

    await removeData.removeCart(
      myServises.sharedPreferences.getString("user_id")!,
      cartId,
    );
  }

  addprise({required CartModel cartModel}) async {
    int availableQuantity = int.parse(cartModel.cartAvailableQuantity!);
    int currentTotalInCart = int.parse(cartModel.cartQuantity!);
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
        int currentQuantity = int.parse(cartModel.cartQuantity!);
        cartModel.cartQuantity = (currentQuantity + 1).toString();
        totalbuild = total();

        update(['1']);
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
  }

  removprise({required CartModel cartModel}) async {
    int currentQuantity = int.parse(cartModel.cartQuantity!);
    if (currentQuantity > 1) {
      await cartAddorremoveData.addremov(
        myServises.sharedPreferences.getString("user_id")!,
        cartModel.productId!.toString(),
        cartModel.cartAttributes!,
      );

      cartModel.cartQuantity = (currentQuantity - 1).toString();
      totalbuild = total();
      update(['1']);
    }
  }

  gotoproductdetails(int productId, String lang) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": productId, "lang": lang},
    );
  }
}
