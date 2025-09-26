import 'package:e_comerece/app_api/lin_kapi.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/search_By_image_data.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class SearchByimageController extends GetxController {
  Future<void> fetchShearchByimage(String imageUrl);
  void pickimage();
  void gotoditels({required int id, required String lang});
  void gotoshearchname(String nameCat, int categoryId);
}

class SearchByimageControllerllerImple extends SearchByimageController {
  final SearchByImageData searchByImageData = SearchByImageData(Get.find());
  Statusrequest statusrequest = Statusrequest.loading;
  SearchByImageModel? searchByImageModel;
  List<ResultList> items = [];
  List<CategoryList> catgories = [];
  String? imageUrl;
  XFile? image;

  bool isLoading = false;

  @override
  fetchShearchByimage(imageUrl) async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await searchByImageData.getData(imageUrl: imageUrl);

    statusrequest = handlingData(response);
    if (statusrequest == Statusrequest.success &&
        response is Map &&
        response['result']?['status']?['code'] == 200) {
      final responseAsMap = response as Map<String, dynamic>;
      searchByImageModel = SearchByImageModel.fromJson(responseAsMap);
      items = searchByImageModel!.result!.resultList;
      catgories = searchByImageModel!.result!.base!.categoryList;
      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.failuer;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.arguments["url"];
    image = Get.arguments["image"];
    fetchShearchByimage(imageUrl!);
  }

  @override
  gotoditels({required id, required lang}) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": id, "lang": lang},
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

  @override
  pickimage() {
    Get.put(ImageManagerController())
      ..pickImage().then((image) {
        if (image.path != '') {
          this.image = image;
          Get.dialog(
            barrierDismissible: false,
            // PopScope(
            //   canPop: false,
            //   onPopInvokedWithResult: (bool didPop, dynamic result) {
            //     if (didPop) return;
            //   },
            //   child:,
            // ),
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
                print('Error: $err');
              });
        }
      });
  }
}
