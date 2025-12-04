import 'dart:developer';
import 'package:e_comerece/app_api/link_api.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/productalibaba_home_data.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/search_name_alibaba_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductAlibabaHomeController extends GetxController {
  Future<void> fethcProducts();
  Future<void> searshText({
    required String q,
    isLoadMore = false,
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
  custprice(String endPrice, String startPrice);
}

class ProductAlibabaHomeControllerImp extends ProductAlibabaHomeController {
  ProductalibabaHomeData productalibabaHomeData = ProductalibabaHomeData(
    Get.find(),
  );
  SearchNameAlibabaData searchNameAlibabaData = SearchNameAlibabaData(
    Get.find(),
  );
  InsertCashData insertCashData = InsertCashData(Get.find());
  GetCashData getCashData = GetCashData(Get.find());
  Statusrequest statusrequestproduct = Statusrequest.loading;
  Statusrequest statusrequestsearch = Statusrequest.none;
  Settings? settings;

  bool isLoading = false;
  bool isLoadingSearch = false;
  int pageindex = 1;
  int pageIndexSearch = 0;

  bool hasMore = true;
  bool hasMoresearch = true;
  bool isSearch = false;
  FocusNode focusNode = FocusNode();
  bool showClose = false;

  List<ResultList> products = [];
  List<ResultList> searchProducts = [];

  int currentIndex = 0;
  bool initShow = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController endprice = TextEditingController();
  TextEditingController startprice = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fethcProducts();
    startInitShow();
  }

  @override
  Future<void> fethcProducts({isLoadMore = false}) async {
    log("enOrAr(isArSA: true)=>${enOrAr(isArSA: true)}");
    cashkey(String q, int p) =>
        'homeproduct:alibaba:$q:page=$p:${enOrAr(isArSA: true)}';
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
    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey("", pageindex),
        platform: "alibaba",
      );

      if (cacheResponse["status"] == "success") {
        log("get from alibaba cache server=====================");
        final data = cacheResponse['data'];
        final status = handlingData(data);
        if (status == Statusrequest.success) {
          if (handle200(data)) {
            var hotProductModel = ProductAliBabaHomeModel.fromJson(data);

            if (hotProductModel.result!.resultList.isEmpty) {
              hasMore = false;
            } else {
              products.addAll(hotProductModel.result!.resultList);
              pageindex++;
            }
            if (!isLoadMore) statusrequestproduct = Statusrequest.success;
          }
        } else {
          if (!isLoadMore) {
            statusrequestproduct =
                status as Statusrequest? ?? Statusrequest.failuer;
          }
          hasMore = false;
        }
      } else {
        log("get product Alibaba from api=====================");
        final hotProductsResponse = await productalibabaHomeData.getproductHome(
          pageindex: pageindex,
        );

        final status = handlingData(hotProductsResponse);
        if (status == Statusrequest.success) {
          if (handle200(hotProductsResponse)) {
            var hotProductModel = ProductAliBabaHomeModel.fromJson(
              hotProductsResponse,
            );

            if (hotProductModel.result!.resultList.isEmpty) {
              hasMore = false;
            } else {
              products.addAll(hotProductModel.result!.resultList);
              insertCashData.insertCash(
                query: cashkey("", pageindex),
                platform: "alibaba",
                data: hotProductsResponse,
                ttlHours: "24",
              );
              pageindex++;
            }
            if (!isLoadMore) statusrequestproduct = Statusrequest.success;
          } else if (handle205(hotProductsResponse, pageindex)) {
            hasMore = false;
            statusrequestproduct = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          }
        } else {
          if (!isLoadMore) {
            statusrequestproduct =
                status as Statusrequest? ?? Statusrequest.failuer;
          }
          hasMore = false;
        }
      }
    } catch (e) {
      log("error fetch product alibaba home controller $e");
    }

    isLoading = false;
    log("statusrequestHotProducts=>$statusrequestproduct");
    update();
  }

  @override
  loadMoreproduct() {
    fethcProducts(isLoadMore: true);
  }

  @override
  searshText({
    required q,
    isLoadMore = false,
    startPrice = "",
    endPrice = "",
  }) async {
    cashkey(String q, int p) =>
        'search:alibaba:$q:page=$p:${detectLangFromQuery(searchController.text)}';
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

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(q, pageIndexSearch),
        platform: "alibaba",
      );
      if (cacheResponse["status"] == "success") {
        log("get from alibaba cache server=====================");
        final data = cacheResponse['data'];
        statusrequestsearch = handlingData(data);
        if (statusrequestsearch == Statusrequest.success) {
          if (handle200(data)) {
            final model = ProductAliBabaHomeModel.fromJson(data);
            final List<ResultList> iterable = model.result!.resultList;
            settings = model.result?.settings;

            if (iterable.isEmpty) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              pageIndexSearch++;
            }
          } else {
            hasMoresearch = false;
            statusrequestsearch = Statusrequest.noData;
          }
        }
      } else {
        log("get product Alibaba from api=====================");
        final response = await searchNameAlibabaData.getproductsSearch(
          lang: detectLangFromQuery(searchController.text),
          q: q,
          pageindex: pageIndexSearch,
          endPrice: endPrice,
          startPrice: startPrice,
        );

        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (handle200(response)) {
            final model = ProductAliBabaHomeModel.fromJson(response);
            final List<ResultList> iterable = model.result!.resultList;
            settings = model.result?.settings;

            if (iterable.isEmpty) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              await insertCashData.insertCash(
                query: cashkey(q, pageIndexSearch),
                platform: "alibaba",
                data: response,
                ttlHours: "24",
              );
              pageIndexSearch++;
            }
          } else if (handle205(response, pageIndexSearch)) {
            hasMoresearch = false;
            statusrequestsearch = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          } else {
            hasMoresearch = false;
            statusrequestsearch = Statusrequest.noData;
          }
        }
      }
    } catch (e) {
      hasMoresearch = false;
      statusrequestsearch = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearch = false;
      update();
    }
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
    update(["index"]);
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
      update();
    }
  }

  @override
  onTapSearch({required keyWord}) {
    isSearch = true;
    searshText(q: keyWord);
    focusNode.unfocus();
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
      uploadToCloudinary(
            filePath: image.path,
            cloudName: Appapi.cloudName,
            uploadPreset: Appapi.uploadPreset,
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
