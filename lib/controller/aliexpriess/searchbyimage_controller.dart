import 'package:e_comerece/app_api/link_api.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class SearchByimageController extends GetxController {
  Future<void> fetchShearchByimage(String imageUrl);
  void pickimage();
  void gotoditels({
    required int id,
    required String lang,
    required String title,
  });
  void gotoshearchname(String nameCat, int categoryId);
}

class SearchByimageControllerllerImple extends SearchByimageController {
  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );
  Statusrequest statusrequest = Statusrequest.loading;
  SearchByImageModel? searchByImageModel;
  List<ResultList> items = [];
  List<CategoryList> catgories = [];
  String? imageUrl;
  XFile? image;
  bool viewport = false;
  bool isLoading = false;

  @override
  fetchShearchByimage(imageUrl) async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await alexpressRepoImpl.fetchSearchByImage(
      enOrAr(),
      imageUrl,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequest = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is SearchByImageModel) {
      searchByImageModel = r;
      items = r.result!.resultList;
      catgories = r.result!.base!.categoryList;
      statusrequest = Statusrequest.success;
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
  gotoditels({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.detelspage,
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

  @override
  pickimage() {
    Get.put(ImageManagerController()).pickImage().then((image) {
      if (image.path != '') {
        this.image = image;
        if (!Get.isDialogOpen!) {
          loadingDialog();
        }
        uploadToCloudinary(
              filePath: image.path,
              cloudName: Appapi.cloudName,
              uploadPreset: Appapi.uploadPreset,
            )
            .then((url) {
              if (Get.isDialogOpen ?? false) Get.back();
              if (url != null) {
                fetchShearchByimage(url);
              } else {}
            })
            .catchError((err) {});
      }
    });
  }
}
