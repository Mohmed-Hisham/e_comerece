import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class AddOrdersData {
  Crud crud;

  AddOrdersData(this.crud);

  Future<dynamic> addOrder({
    required int userId,
    required int addressId,
    required String platformCode,
    required List<Map<String, dynamic>> items,
    required String couponCode,
    required double shippingAmount,
    required String paymentMethod,
    double discountAmount = 0,
    bool applyCouponNow = false,
  }) async {
    var response = await crud.postData(Appapi.addOrder, {
      "user_id": userId,
      "address_id": addressId,
      "platform_code": platformCode,
      "items": items,
      "coupon_code": couponCode,
      "shipping_amount": shippingAmount,
      "payment_method": paymentMethod,
      "discount_amount": discountAmount,
      "apply_coupon_now": applyCouponNow,
    }, sendJson: true);

    return response.fold((l) => l, (r) => r);
  }
}
