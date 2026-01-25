import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/repository/Cart/cart_repo_impl.dart';
import 'package:get/get.dart';

abstract class AddorrmoveController extends GetxController {
  Future<void> addprise({
    required CartData cartData,
    required int availablequantity,
  });
  Future<void> removprise({required CartData cartData});
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
  late CartRepoImpl cartRepo;
  late Statusrequest statusRequest;

  Map<String, bool> isCart = {};

  @override
  void onInit() {
    super.onInit();
    cartRepo = CartRepoImpl(apiService: Get.find());
  }

  @override
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
  }) async {
    statusRequest = Statusrequest.loading;
    update();

    CartData cartData = CartData(
      productId: productid.toString(),
      productTitle: producttitle,
      productImage: productimage,
      productPrice: productprice,
      cartQuantity: quantity,
      cartAttributes: attributes,
      cartAvailableQuantity: availableqQuantity,
      cartPlatform: platform,
      cartTier: tier,
      goodsSn: goodsSn ?? "",
      categoryId: categoryId ?? "",
      productLink: porductink,
    );

    var response = await cartRepo.addCart(cartData);

    statusRequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        showCustomGetSnack(isGreen: true, text: r);
        return Statusrequest.success;
      },
    );
    update();
  }

  @override
  addprise({required CartData cartData, required int availablequantity}) async {
    var response = await cartRepo.increaseQuantity(
      cartData.productId!.toString(),
      cartData.cartAttributes,
      availablequantity,
    );

    statusRequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        Get.rawSnackbar(
          title: StringsKeys.alert.tr,
          messageText: Text(StringsKeys.quantityIncreased.tr),
        );
        return Statusrequest.success;
      },
    );
    update(['fetchCart']);
  }

  @override
  removprise({required CartData cartData}) async {
    var response = await cartRepo.decreaseQuantity(
      cartData.productId!.toString(),
      cartData.cartAttributes,
      cartData.cartAvailableQuantity ?? 0,
    );

    statusRequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        Get.rawSnackbar(
          title: StringsKeys.alert.tr,
          messageText: Text(StringsKeys.quantityDecreased.tr),
        );
        return Statusrequest.success;
      },
    );
    update(['fetchCart']);
  }

  @override
  cartquintty(productid, attributes) async {
    statusRequest = Statusrequest.loading;
    var response = await cartRepo.getQuantity(productid.toString(), attributes);

    return response.fold(
      (l) {
        statusRequest = Statusrequest.failuer;
        return {"quantity": 0, "in_favorite": false};
      },
      (r) {
        statusRequest = Statusrequest.success;
        return {
          "quantity": r['cart_quantity'] ?? 0,
          "in_favorite": r['in_favorite'] ?? false,
        };
      },
    );
  }
}
