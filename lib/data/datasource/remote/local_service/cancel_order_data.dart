import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CancelOrderData {
  Crud crud;

  CancelOrderData(this.crud);

  Future<dynamic> cancelOrder(String orderid, String status) async {
    var response = await crud.postData(Appapi.cancelOrderlocalService, {
      "order_id": orderid,
      "status": status,
    });

    return response.fold((l) => l, (r) => r);
  }
}
