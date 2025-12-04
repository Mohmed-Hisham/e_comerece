import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CartviweData {
  Crud crud;

  CartviweData(this.crud);

  getData(int userId) async {
    var response = await crud.postData(Appapi.viweCart, {"user_id": userId});
    return response.fold((l) => l, (r) => r);
  }
}
