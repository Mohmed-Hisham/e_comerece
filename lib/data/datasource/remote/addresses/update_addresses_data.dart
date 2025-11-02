import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class UpdateAddressesData {
  Crud crud;
  UpdateAddressesData(this.crud);

  updateAddress({required Map<String, dynamic> data}) async {
    var respons = await crud.postData(Appapi.updateAddress, data);

    return respons.fold((l) => l, (r) => r);
  }
}
