import 'dart:developer';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';

import 'package:e_comerece/data/datasource/remote/shein/categories_shein_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/search_shein_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/trendaing_shein_data.dart';
import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';
import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart'
    as searsh;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeSheinController extends GetxController {
  Future<void> fetchHomePageData();
  Future<void> fetchproducts();
  // Future<void> fetchOnrefresh();
  Future<void> fetchCategories();
  // Future<void> fetchProducts({required bool isLoadMore});
  void loadMore();
  Future<void> searshProduct({
    // required String q,
    isLoadMore = false,
    String startPrice,
    String endPrice,
  });
  void loadMoreSearch();
  void onTapSearch();
  void onChangeSearch(String value);
  void goTofavorite();
  void gotoditels({
    required String goodssn,
    required String title,
    required String goodsid,
    required String categoryid,
  });
  // void goToSearchByimage();
  // void gotoshearchname(String nameCat, int categoryId);
  void indexchange(int index);
  custprice(String endPrice, String startPrice);
}

class HomeSheinControllerImpl extends HomeSheinController {
  CategoriesSheinData categoryData = CategoriesSheinData(Get.find());
  TrendaingSheinData trendaingSheinData = TrendaingSheinData(Get.find());
  SearchSheinData searchSheinData = SearchSheinData(Get.find());
  InsertCashData insertCashData = InsertCashData(Get.find());
  GetCashData getCashData = GetCashData(Get.find());

  TextEditingController searchController = TextEditingController();
  TextEditingController startPriceController = TextEditingController();
  TextEditingController endpriceController = TextEditingController();

  Statusrequest statusrequestcat = Statusrequest.none;
  Statusrequest statusrequestproduct = Statusrequest.none;
  Statusrequest statusrequestHomeData = Statusrequest.none;
  Statusrequest statusrequestsearch = Statusrequest.none;

  List<Datum> categories = [];
  List<Product> products = [];
  List<searsh.Product> searchProducts = [];

  bool isLoadingSearch = false;
  bool hasMoresearch = true;
  int pageindex = 1;
  bool isSearch = false;

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  @override
  fetchCategories() async {
    statusrequestcat = Statusrequest.loading;
    update();
    try {
      final cacheResponse = await getCashData.getCash(
        query: 'categories:shein',
        platform: "Shein",
      );
      log('CACHE RESPONSE: ${cacheResponse["status"]}');
      if (cacheResponse["status"] == "success") {
        log('FETCH CACHED SERVER DATA SUCCESSFULLY');
        final categoryResponse = cacheResponse["data"];
        statusrequestcat = handlingData(categoryResponse);
        if (statusrequestcat == Statusrequest.success) {
          if (categoryResponse is Map<String, dynamic> &&
              categoryResponse['success'] == true) {
            final catModel = CatgorySheinModel.fromJson(categoryResponse);

            if (catModel.data.isNotEmpty) {
              categories.assignAll(catModel.data);
            } else {
              categories.clear();
              statusrequestcat = Statusrequest.noData;
            }
          } else {
            statusrequestcat = Statusrequest.failuer;
          }
        }
      } else {
        log('FETCH FROM API');
        final categoryResponse = await categoryData.getCategories();

        statusrequestcat = handlingData(categoryResponse);
        if (statusrequestcat == Statusrequest.success) {
          if (categoryResponse is Map<String, dynamic> &&
              categoryResponse['success'] == true) {
            final catModel = CatgorySheinModel.fromJson(categoryResponse);

            if (catModel.data.isNotEmpty) {
              categories.assignAll(catModel.data);
              insertCashData.insertCash(
                query: 'categories:shein',
                platform: "Shein",
                data: categoryResponse,
                ttlHours: "24",
              );
            } else {
              // categories.clear();
              statusrequestcat = Statusrequest.noData;
            }
          } else {
            statusrequestcat = Statusrequest.failuer;
          }
        }
      }
    } catch (e) {
      log('FETCH ERROR: $e');
      statusrequestcat = Statusrequest.failuer;
    }

    update();
  }

  @override
  fetchHomePageData({bool isrefresh = false}) async {
    statusrequestHomeData = Statusrequest.loading;
    update();
    if (isrefresh == false) {
      await Future.wait([fetchCategories(), fetchproducts()]);
    } else {
      await Future.wait({fetchproducts()});
    }
    if (statusrequestHomeData == Statusrequest.loading) {
      statusrequestHomeData = Statusrequest.success;
      // }
      update();
    }
  }

  @override
  gotoditels({
    required goodssn,
    required title,
    required goodsid,
    required categoryid,
  }) {
    Get.toNamed(
      AppRoutesname.productDetailsSheinView,
      arguments: {
        "goods_sn": goodssn,
        "title": title,
        "goods_id": goodsid,
        "category_id": categoryid,
      },
    );
  }

  @override
  fetchproducts({bool isLoadMore = false}) async {
    cashkey(String q, int p) => 'homeproduct:shein:$q:page=$p';

    statusrequestproduct = Statusrequest.loading;

    update();

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey("", pageindex),
        platform: "shein",
      );

      if (cacheResponse["status"] == "success") {
        log("get from shein home product cache=====================");
        final response = cacheResponse["data"];
        statusrequestproduct = handlingData(response);
        if (statusrequestproduct == Statusrequest.success) {
          if (response['success'] == true) {
            final model = TrendingProductsModel.fromJson(response);
            final List<Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              statusrequestproduct = Statusrequest.noData;
            } else {
              products.assignAll(iterable);
              statusrequestproduct = Statusrequest.success;
            }
          }
        }
      } else {
        log("get from shein home product api=====================");
        final response = await trendaingSheinData.getTrendingproduct();
        print(response);
        statusrequestproduct = handlingData(response);
        if (statusrequestproduct == Statusrequest.success) {
          if (response['success'] == true) {
            final model = TrendingProductsModel.fromJson(response);
            final List<Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              statusrequestproduct = Statusrequest.noData;
            } else {
              products.assignAll(iterable);
              statusrequestproduct = Statusrequest.success;
              insertCashData.insertCash(
                query: cashkey("", pageindex),
                platform: "shein",
                data: response,
                ttlHours: "24",
              );
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      statusrequestproduct = Statusrequest.failuer;
    } finally {
      update();
    }
  }

  // @override
  // loadMoreSearch(lang) {
  //   searshText(keyWord: searchController.text, isLoadMore: true, lang: lang);
  // }

  // @override
  // onChangeSearch(String val) {
  //   if (val == "") {
  //     isSearch = false;
  //     update();
  //   }
  // }

  // @override
  // onTapSearch({required keyWord, required lang}) {
  //   isSearch = true;
  //   searshText(keyWord: keyWord, lang: lang);
  //   update();
  // }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Shein"},
    );
  }

  @override
  indexchange(int index) {
    currentIndex = index;
    update(["index"]);
  }

  @override
  loadMore() {
    fetchproducts(isLoadMore: true);
  }

  @override
  searshProduct({isLoadMore = false, startPrice = "", endPrice = ""}) async {
    cashkey(String q, int p) => 'search:shein:$q:page=$p';

    if (isLoadMore) {
      if (isLoadingSearch || !hasMoresearch) return;
      isLoadingSearch = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageindex = 1;
      searchProducts.clear();
      hasMoresearch = true;
      if (startPrice == "" && endPrice == "") {
        startPriceController.clear();
        endpriceController.clear();
      }
    }
    update();

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(searchController.text, pageindex),
        platform: "shein",
      );

      if (cacheResponse["status"] == "success") {
        log("get from shein search product cache=====================");
        final response = cacheResponse["data"];
        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = searsh.SeachSheinModel.fromJson(response);
            final List<searsh.Product> iterable = model.data?.products ?? [];

            if (iterable.isEmpty && pageindex == 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              pageindex++;
            }
          }
        }
      } else {
        final response = await searchSheinData.getsearch(
          q: searchController.text,
          pageindex: pageindex.toString(),
          endPrice: endPrice,
          startPrice: startPrice,
        );

        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = searsh.SeachSheinModel.fromJson(response);
            final List<searsh.Product> iterable = model.data?.products ?? [];

            if (iterable.isEmpty && pageindex == 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else if (iterable.isEmpty && pageindex > 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noDataPageindex;
              custSnackBarNoMore();
            } else {
              searchProducts.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(searchController.text, pageindex),
                platform: "shein",
                data: response,
                ttlHours: "24",
              );
              pageindex++;
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      hasMoresearch = false;
      statusrequestsearch = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearch = false;
      update();
      log("statusrequestsearch $statusrequestsearch");
    }
  }

  @override
  onTapSearch() {
    isSearch = true;
    searshProduct();
    update();
  }

  @override
  loadMoreSearch() {
    searshProduct(
      // q: searchController.text,
      isLoadMore: true,
      startPrice: startPriceController.text,
      endPrice: endpriceController.text,
    );
  }

  @override
  custprice(endPrice, startPrice) {
    searshProduct(endPrice: endPrice, startPrice: startPrice);
  }

  @override
  onChangeSearch(val) {
    if (val == "") {
      isSearch = false;
      update();
    }
  }

  // @override
  // goToSearchByimage() {
  //   Get.put(ImageManagerController())
  //     ..pickImage().then((image) {
  //       if (image.path != '')
  //         Get.dialog(
  //           PopScope(
  //             canPop: false,
  //             onPopInvokedWithResult: (bool didPop, dynamic result) {
  //               if (didPop) return;
  //             },
  //             child: Center(child: CircularProgressIndicator()),
  //           ),
  //         );
  //       uploadToCloudinary(
  //             filePath: image.path,
  //             cloudName: Appapi.cloudName,
  //             uploadPreset: Appapi.uploadPreset,
  //           )
  //           .then((url) {
  //             if (Get.isDialogOpen ?? false) Get.back();
  //             if (url != null) {
  //               print('Uploaded to: $url');
  //               Get.toNamed(
  //                 AppRoutesname.searchByimagealiexpress,
  //                 arguments: {'url': url, 'image': image},
  //               );
  //             } else {}
  //           })
  //           .catchError((err) {
  //             print('Error: $err');
  //           });
  //     });
  // }
}
