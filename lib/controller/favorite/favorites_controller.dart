import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:e_comerece/data/datasource/remote/favorite/favorite_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  FavoriteData favoriteData = FavoriteData(Get.find());
  Map<String, bool> isFavorite = {};
  MyServises myServises = Get.find();

  Future<void> fetchFavorites() async {
    String userId = myServises.sharedPreferences.getString("user_id") ?? "0";
    if (userId == "0") return;

    var response = await favoriteData.viweData(userId: userId);

    if (response is Map &&
        response['status'] == 'success' &&
        response['data'] != null) {
      List favoritesList = response['data'];
      isFavorite.clear();
      for (var item in favoritesList) {
        isFavorite[item['productId']] = true;
      }
    }
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
    String id = myServises.sharedPreferences.getString("user_id")!;

    bool currentStatus = isFavorite[productId] ?? false;

    if (currentStatus == true) {
      setFavorite(productId, false);
      await favoriteData.remove(userId: id, productid: productId);
    } else {
      setFavorite(productId, true);
      await favoriteData.addfavorite(
        userId: id,
        productid: productId.toString(),
        producttitle: productTitle,
        productimage: productImage,
        productprice: productPrice,
        platform: platform,
        categoryid: categoryid ?? "",
        goodsSn: goodsSn ?? "",
      );
      if (Get.isDialogOpen ?? false) return;

      // show dialog
      Get.rawSnackbar(
        titleText: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        maxWidth: Get.width * 0.95,

        margin: EdgeInsets.only(left: 12, right: 12, bottom: 18, top: 50),
        padding: EdgeInsets.zero,
        borderRadius: 0,
        duration: Duration(seconds: 1),

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
      // Get.snackbar(
      //   'ok',
      //   'Added to favorites',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.green.withOpacity(0.5),
      //   colorText: Colors.white,
      //   margin: EdgeInsets.only(bottom: 100),
      // );
      // Get.dialog(
      //   barrierDismissible: false,
      //   Center(
      //     child: FavoriteAnimatedWidget(
      //       size: 110,
      //       onEnd: () {
      //         if (Get.isDialogOpen ?? false) Get.back();
      //       },
      //     ),
      //   ),

      //   barrierColor: Colors.transparent,
      // );
      // await FavoriteAnimationController.to.play();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }
}
