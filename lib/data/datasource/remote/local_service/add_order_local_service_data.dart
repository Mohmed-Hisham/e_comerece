import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class AddOrderLocalServiceData {
  Crud crud;

  AddOrderLocalServiceData(this.crud);

  Future<dynamic> addOrderLocalService(
    int userid,
    int serviceid,
    String note,
    int addressid,
  ) async {
    var response = await crud.postData(Appapi.addOrderlocalService, {
      "userid": userid,
      "serviceid": serviceid,
      "note": note,
      "addressid": addressid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
