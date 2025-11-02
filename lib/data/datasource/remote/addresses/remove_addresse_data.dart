import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class RemoveAddresseData {
  Crud crud;
  RemoveAddresseData(this.crud);

  removeAddresse({required int addressId}) async {
    var respons = await crud.postData(Appapi.removeAddress, {
      "address_id": addressId,
    });

    return respons.fold((l) => l, (r) => r);
  }
}
