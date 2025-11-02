import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class AddAddressesData {
  Crud crud;
  AddAddressesData(this.crud);

  addAddress({required Map<String, dynamic> data}) async {
    var respons = await crud.postData(Appapi.addAddress, data, sendJson: true);

    return respons.fold((l) => l, (r) => r);
  }
}
