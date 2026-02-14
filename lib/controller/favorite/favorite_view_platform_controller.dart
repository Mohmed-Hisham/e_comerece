import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/data/repository/Favorite/favorit_repo_impl.dart';
import 'package:get/get.dart';

abstract class FavoriteViewPlatformController extends GetxController {
  Future<void> getFavoritesPlatform({required String platform});
  void removeFavorite(String productId);
  void goToProductDetails(
    String productId,
    String lang,
    String title,
    String asin,
    String goodsSn,
    String categoryid,
  );
}

class FavoriteViewPlatformControllerImpl
    extends FavoriteViewPlatformController {
  late String platform;

  FavoriteRepoImpl favoriteRepoImpl = FavoriteRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<Product> favorites = [];

  @override
  getFavoritesPlatform({required platform}) async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await favoriteRepoImpl.getByPlatform(platform);

    statusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        favorites = r.data;
        return Statusrequest.success;
      },
    );

    if (favorites.isEmpty && statusrequest == Statusrequest.success) {
      statusrequest = Statusrequest.noData;
    }

    update();
  }

  @override
  removeFavorite(productId) {
    favorites.removeWhere((favorite) => favorite.productId == productId);
    update();
    favoriteRepoImpl.delete(productId);
  }

  @override
  onInit() {
    super.onInit();
    platform = Get.arguments['platform'];
    getFavoritesPlatform(platform: platform);
  }

  @override
  goToProductDetails(productId, lang, title, asin, goodsSn, categoryid) {
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
          arguments: {"asin": asin, "lang": enOrArAmazon(), "title": title},
        );
        break;
      case "Shein":
        Get.toNamed(
          AppRoutesname.productDetailsSheinView,
          arguments: {
            "goods_sn": goodsSn,
            "title": title,
            "goods_id": productId.toString(),
            "category_id": categoryid,
            "lang": enOrArShein(),
          },
        );
      case "LocalProduct":
        Get.toNamed(
          AppRoutesname.ourProductDetails,
          arguments: {'productid': productId},
        );
        break;
    }
  }
}
