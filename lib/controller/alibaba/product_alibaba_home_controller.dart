import 'dart:io';

import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/firebase_storage_helper.dart';
import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo_impl.dart';
import 'package:e_comerece/data/repository/slider_repo.dart';
import 'package:e_comerece/data/model/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductAlibabaHomeController extends GetxController {
  Future<void> fetchProducts({required bool isLoadMore});
  Future<void> searshText({
    required String q,
    bool isLoadMore = false,
    String startPrice,
    String endPrice,
  });
  void loadMoreproduct();
  void indexchange(int index);
  void goToSearchByimage();
  void goTofavorite();
  void loadMoreSearch();
  void onChangeSearch(String val);
  void onTapSearch({required String keyWord});
  void gotoditels({
    required int id,
    required String lang,
    required String title,
  });
  void startInitShow({int delayMs});
  void stopInitShow();
  void custprice(String endPrice, String startPrice);
}

class ProductAlibabaHomeControllerImp extends ProductAlibabaHomeController {
  AlibabaRepoImpl alibabaRepoImpl = AlibabaRepoImpl(apiService: Get.find());
  SliderRepoImpl sliderRepoImpl = SliderRepoImpl(apiService: Get.find());

  Statusrequest statusrequestproduct = Statusrequest.none;
  Statusrequest statusrequestsearch = Statusrequest.none;
  Settings? settings;

  bool isLoading = false;
  bool isLoadingSearch = false;
  int pageindex = 0;
  int pageIndexSearch = 0;

  bool hasMore = true;
  bool hasMoresearch = true;
  bool isSearch = false;
  FocusNode focusNode = FocusNode();
  bool showClose = false;

  List<ResultList> products = [];
  List<ResultList> searchProducts = [];
  List<SliderModel> sliders = [];
  Statusrequest statusRequestSlider = Statusrequest.none;

  Future<void> fetchSliders() async {
    statusRequestSlider = Statusrequest.loading;
    update(['slider']);
    var response = await sliderRepoImpl.getSliders(platform: 'alibaba');
    response.fold(
      (l) {
        statusRequestSlider = Statusrequest.failuer;
      },
      (r) {
        sliders.clear();
        sliders.addAll(r);
        statusRequestSlider = Statusrequest.success;
      },
    );
    update(['slider']);
  }

  int currentIndex = 0;
  bool initShow = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController endprice = TextEditingController();
  TextEditingController startprice = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts(isLoadMore: false);
    startInitShow();
    fetchSliders();
  }

  @override
  fetchProducts({required bool isLoadMore}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestproduct = Statusrequest.loading;
      pageindex = 1;
      products.clear();
      hasMore = true;
    }
    update();

    final response = await alibabaRepoImpl.fetchProducts(
      enOrAr(isArSA: true),
      pageindex,
      AppConfigService.to.qAlibaba ?? "fashion",
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      if (!isLoadMore) {
        // statusrequestproduct = Statusrequest.failuer;
      }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is ProductAliBabaHomeModel) {
      var newProducts = r.result?.resultList;
      if (newProducts == null || newProducts.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestproduct = Statusrequest.noData;
      } else {
        products.addAll(newProducts);
        pageindex++;
        if (!isLoadMore) statusrequestproduct = Statusrequest.success;
      }
    }

    isLoading = false;
    update();
  }

  @override
  loadMoreproduct() {
    fetchProducts(isLoadMore: true);
  }

  @override
  searshText({
    required q,
    isLoadMore = false,
    startPrice = "",
    endPrice = "",
  }) async {
    if (isLoadMore) {
      if (isLoadingSearch || !hasMoresearch) return;
      isLoadingSearch = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update();

    final response = await alibabaRepoImpl.searchProducts(
      enOrAr(isArSA: true),
      pageIndexSearch,
      q,
      startPrice,
      endPrice,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is ProductAliBabaHomeModel) {
      var newProducts = r.result?.resultList;
      settings = r.result?.settings;

      if (newProducts == null || newProducts.isEmpty) {
        hasMoresearch = false;
        if (!isLoadMore) statusrequestsearch = Statusrequest.noData;
      } else {
        searchProducts.addAll(newProducts);
        pageIndexSearch++;
        if (!isLoadMore) statusrequestsearch = Statusrequest.success;
      }
    }

    isLoadingSearch = false;
    update();
  }

  @override
  loadMoreSearch() {
    searshText(
      q: searchController.text,
      isLoadMore: true,
      startPrice: startprice.text,
      endPrice: endprice.text,
    );
  }

  @override
  indexchange(index) {
    currentIndex = index;
    update(["slider"]);
  }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Alibaba"},
    );
  }

  @override
  onChangeSearch(val) {
    if (val == "") {
      isSearch = false;
      focusNode.unfocus();
      update();
    }
  }

  @override
  onTapSearch({required keyWord}) {
    isSearch = true;
    searshText(q: keyWord);
    update();
  }

  @override
  gotoditels({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAlibabView,
      arguments: {"product_id": id, "lang": lang, "title": title},
    );
  }

  @override
  custprice(endPrice, startPrice) {
    searshText(
      q: searchController.text,
      endPrice: endPrice,
      startPrice: startPrice,
    );
  }

  void whenstartSearch(String q) {
    if (q != "") {
      showClose = true;
      update();
    } else {
      focusNode.unfocus();
      showClose = false;
    }
  }

  void onCloseSearch() {
    if (isSearch) {
      isSearch = false;
      focusNode.unfocus();
      searchController.clear();
      update();
      showClose = false;
    } else {
      searchController.clear();
      focusNode.unfocus();
      showClose = false;
      update();
    }
  }

  @override
  goToSearchByimage() {
    Get.put(ImageManagerController()).pickImage().then((image) {
      if (image.path != '') {
        if (!Get.isDialogOpen!) {
          loadingDialog();
        }
      }
      FirebaseStorageHelper.uploadImage(
            imageFile: File(image.path),
            folder: 'alibaba_search_images',
          )
          .then((url) {
            if (Get.isDialogOpen ?? false) Get.back();
            if (url != null) {
              Get.toNamed(
                AppRoutesname.alibabaByimageView,
                arguments: {'url': url, 'image': image},
              );
            } else {}
          })
          .catchError((err) {});
    });
  }

  @override
  startInitShow({int delayMs = 160}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!initShow) {
        initShow = true;
        update(['initShow']);
      }
    });
  }

  @override
  stopInitShow() {
    if (initShow) {
      initShow = false;
      update(['initShow']);
    }
  }
}
