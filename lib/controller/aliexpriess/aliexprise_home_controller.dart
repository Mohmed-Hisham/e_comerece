import 'dart:developer';

import 'package:e_comerece/app_api/link_api.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/aliexpriess_model/category_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AliexpriseHomeController extends GetxController {
  Future<void> fetchHomePageData();
  Future<void> searshText({required String keyWord});
  // Future<void> fetchOnrefresh();
  Future<void> fetchCategories();
  Future<void> fetchProducts({required bool isLoadMore});
  void loadMore();
  void loadMoreSearch(String lang);
  void onTapSearch({required String keyWord});
  void onChangeSearch(String value);
  void goTofavorite();
  void gotoditels({
    required int id,
    required String lang,
    required String title,
  });
  void goToSearchByimage();
  void gotoshearchname(String nameCat, int categoryId);
  void indexchange(int index);
}

class HomePageControllerImpl extends AliexpriseHomeController {
  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );

  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest statusrequestcat = Statusrequest.none;
  Statusrequest statusrequestsearch = Statusrequest.none;
  Statusrequest statusrequestHotProducts = Statusrequest.none;
  TextEditingController searchController = TextEditingController();

  List<ResultListCat> categories = [];
  List<ResultListHotprosuct> hotProducts = [];
  List<ResultListHotprosuct> searchProducts = [];

  int pageIndex = 0;
  int pageIndexSearch = 0;
  FocusNode focusNode = FocusNode();
  bool isLoading = false;

  bool hasMore = true;
  bool hasMoresearch = true;

  bool isSearch = false;
  bool showClose = false;

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  @override
  fetchCategories() async {
    statusrequestcat = Statusrequest.loading;
    final response = await alexpressRepoImpl.fetchCategories(enOrAr());
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is CategorisModel) {
      categories = r.data!.result!.resultList;
    }
    statusrequestcat = Statusrequest.success;
    update();
  }

  @override
  fetchProducts({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestHotProducts = Statusrequest.loading;
      pageIndex = 1;
      hotProducts.clear();
      hasMore = true;
    }
    update();

    final response = await alexpressRepoImpl.fetchProducts(enOrAr(), pageIndex);
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      // if (!isLoadMore) {
      //   statusrequestHotProducts = Statusrequest.failuer;
      // }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is HotProductModel) {
      var newProducts = r.result?.resultListHotprosuct;
      if (newProducts == null || newProducts.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestHotProducts = Statusrequest.noData;
      } else {
        hotProducts.addAll(newProducts);
        pageIndex++;
        if (!isLoadMore) statusrequestHotProducts = Statusrequest.success;
      }
    }

    isLoading = false;
    update();
  }

  @override
  void loadMore() {
    fetchProducts(isLoadMore: true);
  }

  @override
  fetchHomePageData({bool isrefresh = false}) async {
    statusrequest = Statusrequest.loading;
    update();
    if (isrefresh == false) {
      // await fetchCategories();
      // await fetchProducts();
      await Future.wait([fetchCategories(), fetchProducts()]);
    } else {
      await Future.wait({fetchProducts()});
    }
    if (statusrequest == Statusrequest.loading) {
      statusrequest = Statusrequest.success;
    }
    update();
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
        "categorymodel": categories,
      },
    );
  }

  @override
  searshText({required String keyWord, bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMoresearch) return;
      isLoading = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update();

    final response = await alexpressRepoImpl.searchProducts(
      enOrAr(),
      pageIndexSearch,
      keyWord,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      // if (!isLoadMore) {
      //   statusrequestsearch = Statusrequest.failuer;
      // }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is HotProductModel) {
      var newProducts = r.result?.resultListHotprosuct;
      if (newProducts == null || newProducts.isEmpty) {
        hasMoresearch = false;
        if (!isLoadMore) statusrequestsearch = Statusrequest.noData;
      } else {
        searchProducts.addAll(newProducts);
        pageIndexSearch++;
        if (!isLoadMore) statusrequestsearch = Statusrequest.success;
      }
    }

    isLoading = false;
    update();
  }

  @override
  loadMoreSearch(lang) {
    searshText(keyWord: searchController.text, isLoadMore: true);
  }

  @override
  onChangeSearch(String val) {
    if (val == "") {
      isSearch = false;
      focusNode.unfocus();
      update();
    }
  }

  @override
  onTapSearch({required keyWord}) {
    isSearch = true;

    searshText(keyWord: keyWord);
    update();
  }

  whenstartSearch(String q) async {
    if (q != "") {
      showClose = true;
      update();
    } else {
      focusNode.unfocus();
      showClose = false;
    }
  }

  onCloseSearch() {
    if (isSearch) {
      isSearch = false;
      focusNode.unfocus();
      searchController.clear();
      update();
      showClose = false;
      // update(['initShow']);
    } else {
      searchController.clear();
      focusNode.unfocus();
      showClose = false;
      // update(['initShow']);
    }
  }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Aliexpress"},
    );
  }

  @override
  indexchange(int index) {
    currentIndex = index;
    update(["index"]);
  }

  @override
  goToSearchByimage() {
    Get.put(ImageManagerController()).pickImage().then((image) {
      if (image.path != '') {
        if (!Get.isDialogOpen!) {
          loadingDialog();
        }
      }
      uploadToCloudinary(
            filePath: image.path,
            cloudName: Appapi.cloudName,
            uploadPreset: Appapi.uploadPreset,
          )
          .then((url) {
            log("url $url");
            if (Get.isDialogOpen ?? false) Get.back();
            if (url != null) {
              Get.toNamed(
                AppRoutesname.searchByimagealiexpress,
                arguments: {'url': url, 'image': image},
              );
            } else {}
          })
          .catchError((err) {});
    });
  }
}
