import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CartRemoveData {
  Crud crud;

  CartRemoveData(this.crud);

  removeCart(int userId, int cartId) async {
    var response = await crud.postData(Appapi.removcart, {
      "user_id": userId,
      "cart_id": cartId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
