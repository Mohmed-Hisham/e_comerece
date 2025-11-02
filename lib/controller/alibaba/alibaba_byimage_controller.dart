import 'dart:developer';

import 'package:e_comerece/app_api/link_api.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/alibaba_By_image_data.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_byimage_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class AlibabaByimageController extends GetxController {
  Future<void> fetchShearchByimage(String imageUrl);
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
  final AlibabaByImageData alibabaByImageData = AlibabaByImageData(Get.find());
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

    try {
      var response = await alibabaByImageData.getDataByimage(
        imageUrl: imageUrl,
        pageindex: pageindex,
      );

      statusrequest = handlingData(response);
      if (statusrequest == Statusrequest.success && handle200(response)) {
        final responseAsMap = response as Map<String, dynamic>;
        productAliBabaByImageModel = ProductAliBabaByImageModel.fromJson(
          responseAsMap,
        );
        catgories = productAliBabaByImageModel!.result!.base!.categoryList;

        if (productAliBabaByImageModel!.result!.resultList.isEmpty) {
          hasMore = false;
        } else {
          items.addAll(productAliBabaByImageModel!.result!.resultList);
          pageindex++;
        }

        if (!isLoadMore) statusrequest = Statusrequest.success;
      } else if (handle205(response, pageindex)) {
        hasMore = false;
        statusrequest = Statusrequest.noDataPageindex;
        custSnackBarNoMore();
      } else {
        if (!isLoadMore) {
          statusrequest = response as Statusrequest? ?? Statusrequest.failuer;
        }
        hasMore = false;
      }
    } catch (e) {
      if (!isLoadMore) {
        statusrequest = Statusrequest.failuer;
      }
      log("Error in fetchShearchByimage: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  loadMoreproduct() {
    fetchShearchByimage(imageUrl!, isLoadMore: true);
  }

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.arguments["url"];
    image = Get.arguments["image"];
    fetchShearchByimage(imageUrl!);
  }

  @override
  gotoditels({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAlibabView,
      arguments: {"product_id": id, "lang": lang, "title": Title},
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
    Get.put(ImageManagerController())
      ..pickImage().then((image) {
        if (image.path != '') {
          this.image = image;
          Get.dialog(
            barrierDismissible: false,

            Center(child: CircularProgressIndicator()),
          );
          uploadToCloudinary(
                filePath: image.path,
                cloudName: Appapi.cloudName,
                uploadPreset: Appapi.uploadPreset,
              )
              .then((url) {
                if (Get.isDialogOpen ?? false) Get.back();
                if (url != null) {
                  print('Uploaded to: $url');
                  fetchShearchByimage(url);
                } else {
                  print('Upload failed');
                }
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
