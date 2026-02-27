import 'dart:convert';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
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
    required dynamic id,
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
  bool isNoLoading = false;

  List<CartData> cartItems = [];
  String? couponCode;
  String? couponId;
  double? discountPercentage; // Percentage value (e.g., 10 = 10%)
  double? discountAmount; // Calculated discount amount

  double totalbuild = 0.0;
  Map<String, List<CartData>> cartByPlatform = {};

  @override
  void onClose() {
    couponController.dispose();
    super.onClose();
  }

  void groupcartByPlatform() {
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

  double getSubtotal() {
    double sum = 0.0;
    for (var e in cartItems) {
      double price = e.productPrice ?? 0.0;
      double count = (e.cartQuantity ?? 0).toDouble();
      sum += (price * count);
    }
    return sum;
  }

  void calculateDiscountAmount() {
    if (discountPercentage != null && discountPercentage! > 0) {
      discountAmount = (getSubtotal() * discountPercentage!) / 100;
    } else {
      discountAmount = null;
    }
  }

  double total() {
    double sum = getSubtotal();
    if (discountAmount != null) {
      sum -= discountAmount!;
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

  Future<void> removeItem(String cartId) async {
    // Remove from list immediately
    cartItems.removeWhere((item) => item.id == cartId);
    groupcartByPlatform();
    calculateDiscountAmount();
    totalbuild = total();
    update();
    update(['1']);

    var response = await cartRepo.deleteCart(cartId);

    response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        // Re-fetch on failure to restore the item
        getCartItems();
      },
      (r) {
        showCustomGetSnack(
          isGreen: true,
          text: r.trim() == 'Success' ? StringsKeys.successSignUpTitle.tr : r,
        );
      },
    );
  }

  List<Map<String, dynamic>> _parseTiers(String? tierJson) {
    if (tierJson == null || tierJson.isEmpty) return [];
    try {
      final decoded = jsonDecode(tierJson);
      if (decoded is List) {
        return List<Map<String, dynamic>>.from(decoded);
      }
    } catch (e) {
      debugPrint("Error parsing tiers: $e");
    }
    return [];
  }

  double _getDynamicPrice(String? tierJson, int quantity) {
    final tiers = _parseTiers(tierJson);
    if (tiers.isEmpty) return 0.0;

    double? selectedPrice;

    for (var tier in tiers) {
      int minQty = int.tryParse(tier['minquantity'].toString()) ?? 0;
      int maxQty = int.tryParse(tier['maxquantity'].toString()) ?? -1;
      double price = double.tryParse(tier['price'].toString()) ?? 0.0;

      if (quantity >= minQty && (maxQty == -1 || quantity <= maxQty)) {
        selectedPrice = price;
        break;
      }
    }

    if (selectedPrice == null) {
      if (quantity <
          (int.tryParse(tiers.first['minquantity'].toString()) ?? 0)) {
        return double.tryParse(tiers.first['price'].toString()) ?? 0.0;
      }
      return double.tryParse(tiers.last['price'].toString()) ?? 0.0;
    }

    return selectedPrice;
  }

  Future<void> addprise({required CartData cartData}) async {
    int availableQuantity = cartData.cartAvailableQuantity ?? 0;
    int currentTotalInCart = cartData.cartQuantity ?? 0;

    // Alibaba Custom Logic for Quantity Limit
    if (cartData.cartPlatform?.toLowerCase() == 'alibaba' &&
        cartData.cartTier != null) {
      final tiers = _parseTiers(cartData.cartTier);
      if (tiers.isNotEmpty) {
        int maxTierQty = 0;
        for (var tier in tiers) {
          int tMax = int.tryParse(tier['maxquantity'].toString()) ?? 0;
          if (tMax == -1) {
            maxTierQty = 999999; // effectively infinite
            break;
          }
          if (tMax > maxTierQty) maxTierQty = tMax;
        }
        availableQuantity = maxTierQty;
      }
    }

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
          int newQuantity = (cartItems[index].cartQuantity ?? 0) + 1;
          double? newPrice = cartItems[index].productPrice;

          if (cartData.cartPlatform?.toLowerCase() == 'alibaba' &&
              cartData.cartTier != null) {
            final dynamicPrice = _getDynamicPrice(
              cartData.cartTier,
              newQuantity,
            );
            if (dynamicPrice > 0) {
              newPrice = dynamicPrice;
            }
          }

          cartItems[index] = cartItems[index].copyWith(
            cartQuantity: newQuantity,
            productPrice: newPrice,
          );
          groupcartByPlatform();
          calculateDiscountAmount();
          totalbuild = total();
          update();
          update(['1']);
        } else {
          getCartItems();
        }
      },
    );
  }

  Future<void> removprise({required CartData cartData}) async {
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
            int newQuantity = (cartItems[index].cartQuantity ?? 1) - 1;
            double? newPrice = cartItems[index].productPrice;

            if (cartData.cartPlatform?.toLowerCase() == 'alibaba' &&
                cartData.cartTier != null) {
              final dynamicPrice = _getDynamicPrice(
                cartData.cartTier,
                newQuantity,
              );
              if (dynamicPrice > 0) {
                newPrice = dynamicPrice;
              }
            }

            cartItems[index] = cartItems[index].copyWith(
              cartQuantity: newQuantity,
              productPrice: newPrice,
            );
            groupcartByPlatform();
            calculateDiscountAmount();
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

  Future<void> checkCoupon() async {
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
          couponId = responsModel.data?.id;
          couponCode = responsModel.data?.couponName;
          discountPercentage = responsModel.data?.couponDiscount?.toDouble();
          calculateDiscountAmount();
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
              couponId = responsModel.data?.id;
              couponCode = responsModel.data?.couponName;
              discountPercentage = responsModel.data?.couponDiscount
                  ?.toDouble();
              calculateDiscountAmount();
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

      case PlatformSource.localProduct:
        return AppRoutesname.ourProductDetails;

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
  }) async {
    isNoLoading = true;
    update();
    await Get.toNamed(
      goTODetails(platform),
      arguments: {
        "product_id": id,
        "productid": id,
        "lang": lang,
        "title": title,
        "asin": asin,
        "goods_sn": goodssn,
        "goods_id": goodsid,
        "category_id": categoryid,
        "attributes": "",
      },
    );
    getCartItems();
  }

  void goTOCheckout() {
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
        "discountPercentage": discountPercentage,
        "discountAmount": discountAmount,
        "total": totalbuild,
        "couponId": couponId,
      },
    );
  }
}
