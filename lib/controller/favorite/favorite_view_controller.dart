import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
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
    favorites.removeWhere((favorite) => favorite.productId == productId);
    groupFavoritesByPlatform();
    update();
    showCustomGetSnack(isGreen: true, text: 'Removed from favorites');
    removeData.remove(
      userId: myServises.sharedPreferences.getString("user_id")!,
      productid: productId,
    );
  }

  goToProductDetails({
    int? productId,

    String? lang,
    required String title,
    required String platform,
    String? goodssn,
    String? goodsid,
    String? categoryid,
    String? asin,
    String? langamazon,
  }) {
    switch (platform) {
      case "Aliexpress":
        Get.toNamed(
          AppRoutesname.detelspage,
          arguments: {"product_id": productId, "lang": lang, "title": title},
        );
        break;
      case "Alibaba":
        Get.toNamed(
          AppRoutesname.productDetailsAlibabView,
          arguments: {"product_id": productId, "lang": lang, "title": title},
        );
        break;
      case "Amazon":
        Get.toNamed(
          AppRoutesname.productDetailsAmazonView,
          arguments: {"lang": langamazon, "title": title, "asin": asin},
        );
        break;
      case "Shein":
        Get.toNamed(
          AppRoutesname.productDetailsSheinView,
          arguments: {
            "goods_sn": goodssn,
            "title": title,
            "goods_id": goodsid,
            "category_id": categoryid,
          },
        );
        break;
    }
  }
}
