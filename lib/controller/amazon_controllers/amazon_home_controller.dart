import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/data/model/amazon_models/categories_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/hotdeals_amazon_model.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo_impl.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart'
    as search;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AmazonHomeController extends GetxController {
  Future<void> fetchHomePageData();
  Future<void> searshText();
  // Future<void> fetchOnrefresh();
  Future<void> fetchCategories();
  Future<void> fetchProducts({required bool isLoadMore});
  Future<void> otherProducts({bool isLoadMore = false});
  // void loadMore();
  void loadMoreSearch();
  void onTapSearch();
  void onChangeSearch(String value);
  void goTofavorite();
  loadMoreOtherProduct();
  void gotoditels({
    required String asin,
    required String lang,
    required String title,
  });
  // void goToSearchByimage();
  void indexchange(int index);
}

class AmazonHomeControllerImpl extends AmazonHomeController {
  AmazonRepoImpl amazonRepoImpl = AmazonRepoImpl(apiService: Get.find());

  Statusrequest statusrequestHome = Statusrequest.none;
  Statusrequest statusrequestcat = Statusrequest.none;
  Statusrequest statusrequestsearch = Statusrequest.none;
  Statusrequest statusrequestHotProducts = Statusrequest.none;
  Statusrequest statusrequestOtherProduct = Statusrequest.none;

  TextEditingController searchController = .new();
  TextEditingController startPriceController = .new(text: '1');
  TextEditingController endPriceController = .new(text: '500');
  FocusNode searchFocusNode = .new();
  FocusNode startPriceFocusNode = .new();
  FocusNode endPriceFocusNode = .new();

  List<Datum> categories = [];
  List<Deal> hotDeals = [];
  List<search.Product> searchProducts = [];
  List<search.Product> otherProduct = [];

  int pageIndexSearch = 0;
  int pageIndexOtherProduct = 0;

  bool isLoading = false;
  bool hasMore = true;

  bool firstShowOther = true;

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
    final response = await amazonRepoImpl.fetchCategories(
      enOrAr() == "ar_MA" ? "SA" : "AE",
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestcat = Statusrequest.none;
    }
    if (r is CategoriesAmazonModel) {
      categories.assignAll(r.data);
      statusrequestcat = Statusrequest.success;
    }
    update();
  }

  @override
  fetchProducts({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestHotProducts = Statusrequest.loading;
      hotDeals.clear();
      hasMore = true;
    }
    update();
    final response = await amazonRepoImpl.fetchHotDeals(enOrArAmazon());
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestHotProducts = Statusrequest.failuer;
    }
    if (r is HotDealsAmazonModel) {
      if (r.data!.deals.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestHotProducts = Statusrequest.noData;
      } else {
        hotDeals.addAll(r.data!.deals);
        if (!isLoadMore) statusrequestHotProducts = Statusrequest.success;
      }
    }
    isLoading = false;
    update();
  }

  @override
  fetchHomePageData({bool isrefresh = false}) async {
    statusrequestHome = Statusrequest.loading;
    update();
    try {
      if (isrefresh == false) {
        await Future.wait([fetchCategories(), fetchProducts()]);
      } else {
        await Future.wait([fetchProducts()]);
      }
      if (statusrequestHome == Statusrequest.loading) {
        statusrequestHome = Statusrequest.success;
      }
    } catch (e, s) {
      // سجّل الاستثناء مع الـ stack trace عشان تعرف مكانه بالضبط
      log("error fetch home page amazon: $e\n$s");
      statusrequestHome = Statusrequest.failuer;
    }
    update();
  }

  @override
  gotoditels({required asin, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAmazonView,
      arguments: {"asin": asin, "lang": lang, "title": title},
    );
  }

  @override
  searshText({bool isLoadMore = false, bool other = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMore = true;
    }
    update();

    final int intStartPrice = int.tryParse(startPriceController.text) ?? 1;
    final int intEndPrice = int.tryParse(endPriceController.text) ?? 500;

    final response = await amazonRepoImpl.searchProducts(
      detectLangFromQueryAmazon(searchController.text),
      searchController.text,
      pageIndexSearch,
      intStartPrice.toString(),
      intEndPrice.toString(),
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequestsearch = Statusrequest.failuer;
    }
    if (r is search.SearchAmazonModel) {
      if (r.data!.products.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestsearch = Statusrequest.noData;
      } else {
        searchProducts.addAll(r.data!.products);
        pageIndexSearch++;
        if (!isLoadMore) statusrequestsearch = Statusrequest.success;
      }
    }
    isLoading = false;
    update();
  }

  @override
  loadMoreSearch() {
    searshText(isLoadMore: true);
  }

  @override
  onChangeSearch(String val) {
    if (val == "") {
      isSearch = false;
      update();
    }
  }

  whenstartSearch(String q) async {
    if (q != "") {
      showClose = true;
      update();
    } else {
      showClose = false;
    }
  }

  @override
  onTapSearch() {
    isSearch = true;
    searshText();
    update();
  }

  onCloseSearch() {
    if (isSearch) {
      isSearch = false;
      searchController.clear();
      update();
      showClose = false;
      // update(['initShow']);
    } else {
      searchController.clear();
      showClose = false;
      // update(['initShow']);
    }
  }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Amazon"},
    );
  }

  @override
  indexchange(int index) {
    currentIndex = index;
    update(["index"]);
  }

  @override
  otherProducts({bool isLoadMore = false}) async {
    final String query = "fashion";

    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestOtherProduct = Statusrequest.loading;
      pageIndexOtherProduct = 1;
      otherProduct.clear();
      hasMore = true;
    }
    update();

    final response = await amazonRepoImpl.searchProducts(
      enOrArAmazon(),
      query,
      pageIndexOtherProduct,
      "1",
      "1000",
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequestOtherProduct = Statusrequest.failuer;
    }
    if (r is search.SearchAmazonModel) {
      if (r.data!.products.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestOtherProduct = Statusrequest.noData;
      } else {
        otherProduct.addAll(r.data!.products);
        pageIndexOtherProduct++;
        if (!isLoadMore) statusrequestOtherProduct = Statusrequest.success;
      }
    }
    isLoading = false;
    update();
  }

  @override
  loadMoreOtherProduct() {
    otherProducts(isLoadMore: true);
  }

  goTOProductFromCategory(String categoryid, String categoryName) {
    Get.toNamed(
      AppRoutesname.productFromCatView,
      arguments: {
        'categories': categories,
        'categoryId': categoryid,
        'categoryName': categoryName,
      },
    );
  }
}
