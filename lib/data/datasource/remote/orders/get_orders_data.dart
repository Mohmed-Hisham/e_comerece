import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class GetOrdersData {
  Crud crud;

  GetOrdersData(this.crud);

  Future<dynamic> getOrders({
    required int userId,
    int? orderId,
    String? status,
  }) async {
    var response = await crud.postData(Appapi.getOrder, {
      "user_id": 1,
      if (orderId != null) "order_id": orderId,
      if (status != null) "status": status,
    }, sendJson: true);

    return response.fold((l) => l, (r) => r);
  }
}
