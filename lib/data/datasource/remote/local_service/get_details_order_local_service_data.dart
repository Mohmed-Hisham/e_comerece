import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class GetDetailsOrderLocalServiceData {
  Crud crud;

  GetDetailsOrderLocalServiceData(this.crud);

  Future<dynamic> getDetailsOrder({required int orderId}) async {
    var response = await crud.postData(Appapi.getDetailsOrderLocalService, {
      "orderid": orderId,
    });

    return response.fold((l) => l, (r) => r);
  }
}
