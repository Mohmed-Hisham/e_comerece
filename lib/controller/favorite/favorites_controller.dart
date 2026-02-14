import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/data/repository/Favorite/favorit_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  FavoriteRepoImpl favoriteRepoImpl = FavoriteRepoImpl(apiService: Get.find());
  Map<String, bool> isFavorite = {};

  Future<void> fetchFavorites() async {
    var response = await favoriteRepoImpl.getAll();

    response.fold(
      (l) => {showCustomGetSnack(isGreen: false, text: l.errorMessage)},
      (r) {
        isFavorite.clear();
        for (var item in r.data) {
          if (item.productId != null) {
            isFavorite[item.productId!] = true;
          }
        }
      },
    );

    update();
  }

  setFavorite(String productId, bool value) {
    isFavorite[productId] = value;
    update();
  }

  toggleFavorite(
    String productId,
    String productTitle,
    String productImage,
    String productPrice,
    String platform, {
    String? goodsSn,
    String? categoryid,
  }) async {
    bool currentStatus = isFavorite[productId] ?? false;

    if (currentStatus == true) {
      // Optimistic update - remove immediately
      setFavorite(productId, false);
      var response = await favoriteRepoImpl.delete(productId);
      response.fold(
        (l) {
          // Rollback on failure
          setFavorite(productId, true);
          showCustomGetSnack(isGreen: false, text: l.errorMessage);
        },
        (r) {
          showCustomGetSnack(isGreen: true, text: r);
        },
      );
    } else {
      // Optimistic update - add immediately
      setFavorite(productId, true);
      var response = await favoriteRepoImpl.add(
        Product(
          productId: productId,
          productTitle: productTitle,
          productImage: productImage,
          productPrice: productPrice,
          favoritePlatform: platform,
          goodsSn: goodsSn ?? "",
          categoryId: categoryid ?? "",
        ),
      );
      response.fold(
        (l) {
          // Rollback on failure
          setFavorite(productId, false);
          showCustomGetSnack(isGreen: false, text: l.errorMessage);
        },
        (r) async {
          if (Get.isDialogOpen ?? false) return;

          Get.rawSnackbar(
            titleText: const SizedBox.shrink(),
            backgroundColor: Colors.transparent,
            snackStyle: SnackStyle.FLOATING,
            snackPosition: SnackPosition.TOP,
            maxWidth: Get.width * 0.95,
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 18,
              top: 50,
            ),
            padding: EdgeInsets.zero,
            borderRadius: 0,
            duration: const Duration(seconds: 1),
            messageText: Center(
              child: FavoriteAnimatedWidget(
                size: 60,
                onEnd: () {
                  if (Get.isDialogOpen ?? false) Get.back();
                },
              ),
            ),
          );
          await FavoriteAnimationController.to.play();
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    final myServises = Get.find<MyServises>();
    if (myServises.step == "2") {
      fetchFavorites();
    }
  }
}
