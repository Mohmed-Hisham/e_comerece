import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/lin_kapi.dart';

class ViewFavoriteData {
  Crud crud;

  ViewFavoriteData(this.crud);

  getData(String userId) async {
    var response = await crud.postData(Appapi.viweFavorite, {
      "user_id": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
