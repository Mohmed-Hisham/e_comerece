import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class ViewOrdersData {
  Crud crud;

  ViewOrdersData(this.crud);

  Future<dynamic> viewOrders({
    required String userid,
    required String status,
  }) async {
    var response = await crud.postData(Appapi.getOrderlocalService, {
      "userid": userid,
      "state": status,
    });

    return response.fold((l) => l, (r) => r);
  }
}
