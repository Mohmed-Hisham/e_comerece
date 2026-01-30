import 'dart:io';

import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/firebase_storage_helper.dart';
import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_byimage_model.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class AlibabaByimageController extends GetxController {
  Future<void> fetchShearchByimage(String imageUrl, {bool isLoadMore = false});
  void pickimage();
  void gotoditels({
    required int id,
    required String lang,
    required String title,
  });
  void gotoshearchname(String nameCat, int categoryId);
  void loadMoreproduct();
}

class AlibabaByimageControllerllerImple extends AlibabaByimageController {
  AlibabaRepoImpl alibabaRepoImpl = AlibabaRepoImpl(apiService: Get.find());

  Statusrequest statusrequest = Statusrequest.loading;
  ProductAliBabaByImageModel? productAliBabaByImageModel;
  List<ResultList> items = [];
  List<CategoryList> catgories = [];
  String? imageUrl;
  XFile? image;
  int pageindex = 0;

  bool isLoading = false;
  bool hasMore = true;
  bool viewport = false;

  @override
  fetchShearchByimage(imageUrl, {isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      viewport = false;
      update(["viewport"]);
      statusrequest = Statusrequest.loading;
      pageindex = 1;
      items.clear();
      hasMore = true;
    }
    update();

    final response = await alibabaRepoImpl.fetchSearchByImage(
      enOrAr(isArSA: true),
      imageUrl,
      pageindex,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      if (!isLoadMore) {
        statusrequest = Statusrequest.failuer;
      }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is ProductAliBabaByImageModel) {
      productAliBabaByImageModel = r;
      catgories = productAliBabaByImageModel!.result!.base!.categoryList;
      var newProducts = r.result?.resultList;

      if (newProducts == null || newProducts.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequest = Statusrequest.noData;
      } else {
        items.addAll(newProducts);
        pageindex++;
        if (!isLoadMore) statusrequest = Statusrequest.success;
      }
    }

    isLoading = false;
    update();
  }

  @override
  loadMoreproduct() {
    fetchShearchByimage(imageUrl!, isLoadMore: true);
  }

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.arguments["url"] as String?;
    image = Get.arguments["image"] as XFile?;
    fetchShearchByimage(imageUrl!);
  }

  @override
  gotoditels({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAlibabView,
      arguments: {"product_id": id, "lang": lang, "title": title},
    );
  }

  @override
  gotoshearchname(nameCat, categoryId) {
    Get.toNamed(
      AppRoutesname.shearchname,
      arguments: {
        'namecat': nameCat,
        "categoryId": categoryId,
        "categorymodel": catgories,
      },
    );
  }

  showPicker(double height) {
    if (height >= 75 && height <= 300) {
      viewport = true;
      update(["viewport"]);
    } else if (height < 105) {
      viewport = false;
      update(["viewport"]);
    }
  }

  @override
  pickimage() {
    Get.put(ImageManagerController()).pickImage().then((image) {
      if (image.path != '') {
        this.image = image;
        if (!Get.isDialogOpen!) {
          loadingDialog();
        }
        FirebaseStorageHelper.uploadImage(
              imageFile: File(image.path),
              folder: 'alibaba_search_images',
            )
            .then((url) {
              if (Get.isDialogOpen ?? false) Get.back();
              if (url != null) {
                fetchShearchByimage(url);
              } else {}
            })
            .catchError((err) {
              if (kDebugMode) {
                print('Error: $err');
              }
            });
      }
    });
  }
}
