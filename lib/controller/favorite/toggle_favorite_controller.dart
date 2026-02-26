import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/data/repository/Favorite/favorit_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TogglefavoriteController extends GetxController {
  FavoriteRepoImpl favoriteRepoImpl = FavoriteRepoImpl(apiService: Get.find());

  late bool currentStatus;

  toggleFavorite(
    String productId,
    String productTitle,
    String productImage,
    String productPrice,
    String platform,
  ) async {
    update();

    if (currentStatus == true) {
      var response = await favoriteRepoImpl.delete(productId);
      response.fold(
        (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
        (r) {
          showCustomGetSnack(
            isGreen: true,
            text: r.trim() == 'Success' ? StringsKeys.successSignUpTitle.tr : r,
          );
        },
      );
    } else {
      var response = await favoriteRepoImpl.add(
        Product(
          productId: productId,
          productTitle: productTitle,
          productImage: productImage,
          productPrice: productPrice,
          favoritePlatform: platform,
          goodsSn: "",
          categoryId: "",
        ),
      );
      response.fold(
        (l) => showCustomGetSnack(isGreen: false, text: l.errorMessage),
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
}
