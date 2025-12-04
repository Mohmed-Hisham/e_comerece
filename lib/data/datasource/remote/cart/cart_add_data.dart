import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class CartAddData {
  Crud crud;

  CartAddData(this.crud);

  addcart({
    required int userId,
    required String productid,
    required String producttitle,
    required String productimage,
    required double productprice,
    required String platform,
    required String productLink,
    required int quantity,
    required String attributes,
    required int availableqQuantity,
    String? tier,
    String? goodsSn,
    String? categoryId,
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
      "cart_tier": tier,
      "goods_sn": goodsSn,
      "category_id": categoryId,
      "product_link": productLink,
    }, sendJson: true);

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
    }, sendJson: true);

    return respons.fold((l) => l, (r) => r);
  }
}
