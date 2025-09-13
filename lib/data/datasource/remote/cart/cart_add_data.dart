import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/lin_kapi.dart';

class CartAddData {
  Crud crud;

  CartAddData(this.crud);

  addcart({
    required String userId,
    required String productid,
    required String producttitle,
    required String productimage,
    required String productprice,
    required String platform,
    required String quantity,
    required String attributes,
    required String availableqQuantity,
  }) async {
    var respons = await crud.postData(Appapi.addCart, {
      "user_id": userId,
      "product_id": productid,
      "product_title": producttitle,
      "product_image": productimage,
      "product_price": productprice,
      "quantity": quantity,
      "attributes": attributes,
      "available_quantity": availableqQuantity,
      "platform": platform,
    });

    return respons.fold((l) => l, (r) => r);
  }

  cartquantity({
    required String userId,
    required String productid,
    required String attributes,
  }) async {
    var respons = await crud.postData(Appapi.cartquantity, {
      "user_id": userId,
      "product_id": productid,
      "attributes": attributes,
    });

    return respons.fold((l) => l, (r) => r);
  }
}
