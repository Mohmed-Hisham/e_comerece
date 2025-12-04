import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class GetDetailsLocalService {
  Crud crud;

  GetDetailsLocalService(this.crud);

  Future<dynamic> getOrders({required int serviceid}) async {
    String url = "${Appapi.getlocalService}?service_id=$serviceid";

    var response = await crud.getData(url);

    return response.fold((l) => l, (r) => r);
  }
}
