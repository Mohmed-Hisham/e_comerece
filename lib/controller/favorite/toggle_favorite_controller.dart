import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:e_comerece/data/datasource/remote/favorite/favorite_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TogglefavoriteController extends GetxController {
  FavoriteData favoriteData = FavoriteData(Get.find());
  MyServises myServises = Get.find();

  late bool currentStatus;
  // @override
  // onInit() {
  //   super.onInit();
  //   print('currentStatus:$currentStatus');
  // }

  toggleFavorite(
    String productId,
    String productTitle,
    String productImage,
    String productPrice,
    String platform,
  ) async {
    String id = myServises.sharedPreferences.getString("user_id")!;

    update();

    if (currentStatus == true) {
      await favoriteData.remove(userId: id, productid: productId);
    } else {
      await favoriteData.addfavorite(
        userId: id,
        productid: productId.toString(),
        producttitle: productTitle,
        productimage: productImage,
        productprice: productPrice,
        platform: platform,
      );
      if (Get.isDialogOpen ?? false) return;
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

      // show dialog
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
}
