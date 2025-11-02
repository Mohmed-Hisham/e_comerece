import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/favorite/favorite_data.dart';
import 'package:e_comerece/data/datasource/remote/favorite/viwefavorite_data.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:get/get.dart';

abstract class FavoriteViewPlatformController extends GetxController {
  void getFavoritesPlatform({required String platform});
  void removeFavorite(String productId);
  void goToProductDetails(int productId, String lang, String title);
}

class FavoriteViewPlatformControllerImpl
    extends FavoriteViewPlatformController {
  late String platform;

  ViewFavoriteData favoriteData = ViewFavoriteData(Get.find());
  FavoriteData removeData = FavoriteData(Get.find());
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  List<FavoriteModel> favorites = [];

  @override
  getFavoritesPlatform({required platform}) async {
    String userId = myServises.sharedPreferences.getString("user_id") ?? "0";
    if (userId == "0") return;

    statusrequest = Statusrequest.loading;
    update();
    var response = await favoriteData.getViweFavoritePlatform(userId, platform);

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == "success") {
        List responseData = response['data'];
        favorites = responseData.map((e) => FavoriteModel.fromJson(e)).toList();

        statusrequest = Statusrequest.success;
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  removeFavorite(productId) {
    favorites.removeWhere((favorite) => favorite.productId == productId);
    update();

    removeData.remove(
      userId: myServises.sharedPreferences.getString("user_id")!,
      productid: productId,
    );
  }

  @override
  onInit() {
    super.onInit();
    platform = Get.arguments['platform'];
    getFavoritesPlatform(platform: platform);
  }

  @override
  goToProductDetails(productId, lang, title) {
    print(platform);
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
    }
  }
}
