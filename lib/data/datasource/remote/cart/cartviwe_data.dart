import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/lin_kapi.dart';

class CartviweData {
  Crud crud;

  CartviweData(this.crud);

  getData(String userId) async {
    var response = await crud.postData(Appapi.viweCart, {"user_id": userId});
    return response.fold((l) => l, (r) => r);
  }
}
