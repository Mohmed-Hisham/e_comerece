import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/repository/Cart/cart_repo_impl.dart';
import 'package:e_comerece/data/repository/Coupon/coupon_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  Future<void> getCartItems();
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
  CartRepoImpl cartRepo = CartRepoImpl(apiService: Get.find());
  CouponRepoImpl couponRepo = CouponRepoImpl(apiService: Get.find());
  final TextEditingController couponController = .new();
  final FocusNode couponFocusNode = .new();

  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest couPonstatusrequest = Statusrequest.none;

  List<CartData> cartItems = [];
  String? couponCode;
  double? discount;

  double totalbuild = 0.0;
  Map<String, List<CartData>> cartByPlatform = {};

  // @override
  // void onInit() {
  //   super.onInit();
  //   // cartRepo = CartRepoImpl(apiService: Get.find());
  //   // couponRepo = CouponRepoImpl(apiService: Get.find());
  // }

  @override
  void onClose() {
    couponController.dispose();
    super.onClose();
  }

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
      double price = e.productPrice ?? 0.0;
      double count = (e.cartQuantity ?? 0).toDouble();
      sum += (price * count);
    }
    if (discount != null) {
      sum -= discount!;
    }
    return sum;
  }

  @override
  getCartItems() async {
    statusrequest = Statusrequest.loading;
    update();
    update(['1']);

    var response = await cartRepo.getCart();

    statusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        cartItems = r.cartData;
        groupcartByPlatform();
        totalbuild = total();
        return Statusrequest.success;
      },
    );

    update();
    update(['1']);
  }

  removeItem(String cartId) async {
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    var response = await cartRepo.deleteCart(cartId);
    if (Get.isDialogOpen ?? false) Get.back();

    response.fold(
      (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
      (r) {
        showCustomGetSnack(isGreen: true, text: r);
        getCartItems();
      },
    );

    update();
  }

  addprise({required CartData cartData}) async {
    int availableQuantity = cartData.cartAvailableQuantity ?? 0;
    int currentTotalInCart = cartData.cartQuantity ?? 0;
    if (currentTotalInCart >= availableQuantity) {
      showCustomGetSnack(
        isGreen: false,
        text: StringsKeys.maxQuantityReached.tr,
      );

      return;
    }

    var response = await cartRepo.increaseQuantity(
      cartData.productId!.toString(),
      cartData.cartAttributes,
      availableQuantity,
    );

    response.fold(
      (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
      (r) {
        int index = cartItems.indexWhere(
          (element) => element.id == cartData.id,
        );
        if (index != -1) {
          cartItems[index] = cartItems[index].copyWith(
            cartQuantity: (cartItems[index].cartQuantity ?? 0) + 1,
          );
          groupcartByPlatform();
          totalbuild = total();
          update();
          update(['1']);
        } else {
          getCartItems();
        }
      },
    );
  }

  removprise({required CartData cartData}) async {
    int currentQuantity = cartData.cartQuantity ?? 0;
    if (currentQuantity > 1) {
      var response = await cartRepo.decreaseQuantity(
        cartData.productId!.toString(),
        cartData.cartAttributes,
        cartData.cartAvailableQuantity ?? 0,
      );

      response.fold(
        (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
        (r) {
          int index = cartItems.indexWhere(
            (element) => element.id == cartData.id,
          );
          if (index != -1) {
            cartItems[index] = cartItems[index].copyWith(
              cartQuantity: (cartItems[index].cartQuantity ?? 1) - 1,
            );
            groupcartByPlatform();
            totalbuild = total();
            update();
            update(['1']);
          } else {
            getCartItems();
          }
        },
      );
    }
  }

  checkCoupon() async {
    if (couponController.text.trim().isEmpty) {
      showCustomGetSnack(isGreen: false, text: StringsKeys.couponEmpty.tr);
      return;
    }
    couPonstatusrequest = Statusrequest.loading;
    update(['coupon']);

    var response = await couponRepo.getCoupon(
      code: couponController.text.trim(),
    );

    couPonstatusrequest = response.fold(
      (l) {
        showCustomGetSnack(
          duration: const Duration(minutes: 5),
          isGreen: false,
          text: l.errorMessage,
        );

        return Statusrequest.none;
      },
      (responsModel) {
        bool found = false;
        if (responsModel.data?.couponPlatfrom!.toLowerCase() == "all") {
          couponCode = responsModel.data?.couponName;
          discount = responsModel.data?.couponDiscount;
          totalbuild = total();
          showCustomGetSnack(
            isGreen: true,
            text: StringsKeys.couponAppliedSuccess.tr,
          );
          couponController.clear();
          couponFocusNode.unfocus();

          found = true;
        } else {
          for (var plat in cartByPlatform.keys) {
            if (plat.toLowerCase() ==
                responsModel.data?.couponPlatfrom!.toLowerCase()) {
              couponCode = responsModel.data?.couponName;
              discount = responsModel.data?.couponDiscount;
              totalbuild = total();
              showCustomGetSnack(
                isGreen: true,
                text: StringsKeys.couponAppliedSuccess.tr,
              );
              couponController.clear();
              found = true;
              break;
            }
          }

          if (!found) {
            showCustomGetSnack(
              duration: const Duration(minutes: 5),
              isGreen: false,
              text: StringsKeys.couponSpecificPlatformError.trParams({
                'platform': responsModel.data?.couponPlatfrom! ?? "",
              }),
            );
          }
        }
        return found ? Statusrequest.success : Statusrequest.failuer;
      },
    );

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
      showCustomGetSnack(
        isGreen: false,
        text: StringsKeys.cartEmpty.tr,
        duration: const Duration(minutes: 10),
      );
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
