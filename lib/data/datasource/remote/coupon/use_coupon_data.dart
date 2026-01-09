// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/app_api/link_api.dart';

// class UseCouponData {
//   Crud crud;

//   UseCouponData(this.crud);

//   getCoupon(String code, int userId, int orderId) async {
//     var response = await crud.postData(Appapi.useCoupon, {
//       "code": code,
//       "user_id": userId,
//       "order_id": orderId,
//     }, sendJson: true);
//     return response.fold((l) => l, (r) => r);
//   }
// }
