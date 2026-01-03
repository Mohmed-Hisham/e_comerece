import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/aliexpriess_model/category_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/shearch_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart'
    as searchbyimage;
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:get/get.dart';

abstract class ShearchnameController extends GetxController {
  Future<void> fetchShearchname(String nameCat, int categoryId);
  void changeCat(String valnaame, int valid, int index);
  void loadMoreSearch();
  void gotoditels({
    required int id,
    required String lang,
    required String title,
  });
  void goTofavorite();
}

class ShearchnameControllerImple extends ShearchnameController {
  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );
  Statusrequest statusrequest = Statusrequest.loading;
  SearchFromCatModel? searchFromCatModel;
  List<ResultList> items = [];
  Map<int, SearchFromCatModel?> cachedData = {};
  String? nameCat;
  int? categoryId;
  List<ResultListCat> categorymodel = [];
  List<searchbyimage.CategoryList> categorymodelFromImage = [];

  int selectedIndex = 0;

  int pageIndex = 1;
  bool hasMore = true;
  bool isLoading = false;

  @override
  fetchShearchname(
    String nameCat,
    int categoryId, {
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequest = Statusrequest.loading;
      pageIndex = 1;
      items.clear();
      hasMore = true;
    }
    update();

    final response = await alexpressRepoImpl.searchByName(
      enOrAr(),
      nameCat,
      pageIndex,
      categoryId,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      if (!isLoadMore) {
        statusrequest = Statusrequest.failuer;
      }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is SearchFromCatModel) {
      var newItems = r.result?.resultList;
      if (newItems == null || newItems.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequest = Statusrequest.noData;
      } else {
        items.addAll(newItems);
        pageIndex++;
        if (!isLoadMore) statusrequest = Statusrequest.success;
        cachedData[categoryId] = r;
      }
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameCat = Get.arguments["namecat"];
    categoryId = Get.arguments["categoryId"];

    if (Get.arguments["categorymodel"] is List<ResultListCat>) {
      categorymodel = Get.arguments["categorymodel"];
    } else {
      categorymodelFromImage = Get.arguments["categorymodel"];
    }

    if (cachedData.containsKey(categoryId!) &&
        cachedData[categoryId!] != null) {
      searchFromCatModel = cachedData[categoryId];
      items.assignAll(searchFromCatModel!.result!.resultList!);
      statusrequest = Statusrequest.success;
    } else {
      fetchShearchname(nameCat!, categoryId!, isLoadMore: false);
    }
    // update();
  }

  @override
  changeCat(String valnaame, int valid, int index) {
    if (categoryId == valid) return;
    nameCat = valnaame;
    categoryId = valid;
    selectedIndex = index;
    fetchShearchname(valnaame, valid, isLoadMore: false);
    update();
  }

  @override
  loadMoreSearch() {
    fetchShearchname(nameCat!, categoryId!, isLoadMore: true);
  }

  @override
  gotoditels({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": id, "lang": lang, "title": title},
    );
  }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Aliexpress"},
    );
  }
}
