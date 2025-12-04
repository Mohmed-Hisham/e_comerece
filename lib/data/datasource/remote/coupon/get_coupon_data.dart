import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class GetCouponData {
  Crud crud;

  GetCouponData(this.crud);

  getCoupon(String code, int userId) async {
    var response = await crud.postData(Appapi.getCoupons, {
      "code": code,
      "user_id": userId,
    }, sendJson: true);
    return response.fold((l) => l, (r) => r);
  }
}
