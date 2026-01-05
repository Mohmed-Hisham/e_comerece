import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/data/repository/Favorite/favorit_repo_impl.dart';
import 'package:get/get.dart';

class FavoriteViewController extends GetxController {
  FavoriteRepoImpl favoriteRepoImpl = FavoriteRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<Product> favorites = [];
  Map<String, List<Product>> favoritesByPlatform = {};

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  getFavorites() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await favoriteRepoImpl.getAll();

    statusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        favorites = r.data;
        groupFavoritesByPlatform();
        return Statusrequest.success;
      },
    );

    if (favorites.isEmpty && statusrequest == Statusrequest.success) {
      statusrequest = Statusrequest.noData;
    }

    update();
  }

  groupFavoritesByPlatform() {
    favoritesByPlatform = {};
    for (var favorite in favorites) {
      String platform = favorite.favoritePlatform ?? 'Uncategorized';
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
    favoriteRepoImpl.delete(productId);
  }

  goToProductDetails({
    String? productId,
    String? lang,
    required String title,
    required String platform,
    String? goodssn,
    String? goodsid,
    String? categoryid,
    String? asin,
    String? langamazon,
    required String langShein,
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
            "lang": langShein,
          },
        );
        break;
    }
  }
}
