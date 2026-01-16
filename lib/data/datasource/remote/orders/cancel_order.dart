import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CancelOrderData {
  Crud crud;

  CancelOrderData(this.crud);

  Future<dynamic> cancelOrder({
    required int userId,
    required String orderId,
  }) async {
    var response = await crud.postData(Appapi.cancelOrder, {
      "user_id": userId,
      "order_id": orderId,
    }, sendJson: true);

    return response.fold((l) => l, (r) => r);
  }
}
