import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CartAddorremoveData {
  Crud crud;

  CartAddorremoveData(this.crud);

  addprise(
    String userId,
    String productid,
    String attributes,
    String availablequantity,
  ) async {
    var response = await crud.postData(Appapi.addPrise, {
      "user_id": userId,
      "product_id": productid,
      "attributes": attributes,
      "available_quantity": availablequantity,
    });
    return response.fold((l) => l, (r) => r);
  }

  addremov(String userId, String productid, String attributes) async {
    var response = await crud.postData(Appapi.removPrise, {
      "user_id": userId,
      "product_id": productid,
      "attributes": attributes,
    });
    return response.fold((l) => l, (r) => r);
  }
}
