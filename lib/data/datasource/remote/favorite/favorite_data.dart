import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class FavoriteData {
  Crud crud;

  FavoriteData(this.crud);

  addfavorite({
    required String userId,
    required String productid,
    required String producttitle,
    required String productimage,
    required String productprice,
    required String platform,
    String goodsSn = "",
    String categoryid = "",
  }) async {
    var respons = await crud.postData(Appapi.addFavorite, {
      "user_id": userId,
      "product_id": productid,
      "product_title": producttitle,
      "product_image": productimage,
      "product_price": productprice,
      "favorite_platform": platform,
      "goods_sn": goodsSn,
      "category_id": categoryid,
    }, sendJson: true);

    return respons.fold((l) => l, (r) => r);
  }

  remove({required String userId, required String productid}) async {
    var respons = await crud.postData(Appapi.removeFavorite, {
      "user_id": userId,
      "product_id": productid,
    });

    return respons.fold((l) => l, (r) => r);
  }

  viweData({required String userId}) async {
    var respons = await crud.postData(Appapi.viweFavorite, {"user_id": userId});

    return respons.fold((l) => l, (r) => r);
  }
}
