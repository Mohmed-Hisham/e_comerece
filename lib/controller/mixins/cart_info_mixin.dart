import 'dart:developer';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/data/model/cart_item_info.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:get/get.dart';

mixin CartInfoMixin on GetxController {
  bool get isInfoLoading;
  set isInfoLoading(bool value);

  bool get isFavorite;
  set isFavorite(bool value);

  bool get isInCart;
  set isInCart(bool value);

  int get quantity;
  set quantity(int value);

  int get cartquantityDB;
  set cartquantityDB(int value);

  CartButtonState get cartButtonState;
  set cartButtonState(CartButtonState value);

  AddorrmoveControllerimple get addorrmoveController;

  // Method to get product ID and attributes - should be implemented by controllers
  String getProductId();
  String getSelectedAttributesJson();

  Future<void> getCartItemInfo() async {
    try {
      isInfoLoading = true;
      update(['quantity', 'productInfo']); // ID for the bottom bar

      final Map<String, dynamic> responseData = await addorrmoveController
          .cartquintty(getProductId(), getSelectedAttributesJson());

      final cartInfo = CartItemInfo.fromJson(responseData);

      isFavorite = cartInfo.inFavorite;
      isInCart = cartInfo.inCart;

      if (cartInfo.inCart) {
        quantity = cartInfo.quantity;
        cartquantityDB = cartInfo.quantity;
        cartButtonState = CartButtonState.added;
      } else {
        cartquantityDB = 0;
        cartButtonState = CartButtonState.addToCart;
      }
    } catch (e) {
      log('getCartItemInfo error: $e');
      // Handle error case, maybe show a default state
      cartquantityDB = 0;
      isInCart = false;
      cartButtonState = CartButtonState.addToCart;
    } finally {
      isInfoLoading = false;
      update([
        'quantity',
        'productInfo',
        'favorite',
      ]); // Update all relevant parts
    }
  }
}
