import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/favorite/favorite_data.dart';
import 'package:e_comerece/data/datasource/remote/favorite/viwefavorite_data.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:get/get.dart';

class FavoriteViewController extends GetxController {
  ViewFavoriteData favoriteData = ViewFavoriteData(Get.find());
  FavoriteData removeData = FavoriteData(Get.find());
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  List<FavoriteModel> favorites = [];
  Map<String, List<FavoriteModel>> favoritesByPlatform = {};

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  getFavorites() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await favoriteData.getData(
      myServises.sharedPreferences.getString("user_id")!,
    );
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        favorites = responseData.map((e) => FavoriteModel.fromJson(e)).toList();
        groupFavoritesByPlatform();
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  groupFavoritesByPlatform() {
    favoritesByPlatform = {};
    for (var favorite in favorites) {
      String platform = favorite.platform ?? 'Uncategorized';
      if (favoritesByPlatform.containsKey(platform)) {
        favoritesByPlatform[platform]!.add(favorite);
      } else {
        favoritesByPlatform[platform] = [favorite];
      }
    }
  }

  removeFavorite(String productId) {
    // Optimistically remove from the local list
    favorites.removeWhere((favorite) => favorite.productId == productId);
    groupFavoritesByPlatform();
    update();

    // Call the API to remove from the server
    removeData.remove(
      userId: myServises.sharedPreferences.getString("user_id")!,
      productid: productId,
    );
  }
}
