import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';

import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/repository/shein/shein_repo_impl.dart';
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
    required String lang,
  });
  // void goToSearchByimage();
  // void gotoshearchname(String nameCat, int categoryId);
  void indexchange(int index);
  custprice(String endPrice, String startPrice);
}

class HomeSheinControllerImpl extends HomeSheinController {
  SheinRepoImpl sheinRepoImpl = SheinRepoImpl(apiService: Get.find());

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
  bool isLoading = false;
  bool hasMoresearch = true;
  bool hasMore = true;
  int pageindex = 1;
  int pageindexHotProduct = 1;

  bool isSearch = false;
  bool showClose = false;

  int currentIndex = 0;
  FocusNode searchFocusNode = FocusNode();

  goTOProductByCat(String catId, String catName) {
    Get.toNamed(
      AppRoutesname.productByCategoryShein,
      arguments: {
        "categoryid": catId,
        "title": catName,
        "categories": categories,
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  @override
  fetchCategories() async {
    statusrequestcat = Statusrequest.loading;
    final response = await sheinRepoImpl.fetchCategories(enOrArShein());
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestcat = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is CatgorySheinModel) {
      if (r.data.isNotEmpty) {
        categories.assignAll(r.data);
        statusrequestcat = Statusrequest.success;
      } else {
        statusrequestcat = Statusrequest.noData;
      }
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
    required lang,
  }) {
    Get.toNamed(
      AppRoutesname.productDetailsSheinView,
      arguments: {
        "goods_sn": goodssn,
        "title": title,
        "goods_id": goodsid,
        "category_id": categoryid,
        "lang": lang,
      },
    );
  }

  @override
  fetchproducts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestproduct = Statusrequest.loading;
      pageindexHotProduct = 1;
      products.clear();
      hasMore = true;
    }

    update();

    final response = await sheinRepoImpl.fetchTrendingProducts(
      enOrArShein(),
      pageindexHotProduct,
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestproduct = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is TrendingProductsModel) {
      if (r.data!.products.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestproduct = Statusrequest.noData;
      } else {
        products.addAll(r.data!.products);
        if (!isLoadMore) statusrequestproduct = Statusrequest.success;
      }
    }
    isLoading = false;
    update();
  }

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

    final response = await sheinRepoImpl.searchProducts(
      detectLangFromQueryShein(searchController.text),
      searchController.text,
      pageindex,
      startPrice,
      endPrice,
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestsearch = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is searsh.SeachSheinModel) {
      if (r.data?.products.isEmpty ?? true) {
        hasMoresearch = false;
        if (!isLoadMore) statusrequestsearch = Statusrequest.noData;
      } else {
        searchProducts.addAll(r.data!.products);
        pageindex++;
        if (!isLoadMore) statusrequestsearch = Statusrequest.success;
      }
    }
    isLoadingSearch = false;
    update();
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

  whenstartSearch(String q) async {
    if (q != "") {
      showClose = true;
      update();
    } else {
      showClose = false;
    }
  }
}
