import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/shearshname_data.dart';
import 'package:e_comerece/data/model/aliexpriess_model/category_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/shearch_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart'
    as searchbyimage;
import 'package:get/get.dart';

abstract class ShearchnameController extends GetxController {
  Future<void> fetchShearchname(String nameCat, int categoryId);
  void changeCat(String valnaame, int valid, int index);
  void loadMoreSearch();
  void gotoditels({
    required int id,
    required String lang,
    required String Title,
  });
}

class ShearchnameControllerImple extends ShearchnameController {
  final ShearshnameData shearshnameData = ShearshnameData(Get.find());
  Statusrequest statusrequest = Statusrequest.loading;
  SearchFromCatModel? searchFromCatModel;
  List<ResultList> items = [];
  Map<int, SearchFromCatModel?> _cachedData = {};
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
    _startLoading(isLoadMore: isLoadMore);

    try {
      var response = await shearshnameData.getData(
        keyWord: nameCat,
        categoryId: categoryId,
        pageindex: pageIndex,
      );

      statusrequest = handlingData(response);
      print("statusrequest=>$statusrequest");
      if (statusrequest == Statusrequest.success) {
        final responseAsMap = response as Map<String, dynamic>;
        int code =
            SearchFromCatModel.fromJson(responseAsMap).result!.status!.code
                as int;
        if (code == 200) {
          var newItems = SearchFromCatModel.fromJson(
            responseAsMap,
          ).result!.resultList!;

          if (newItems.isEmpty) {
            hasMore = false;
          } else {
            items.addAll(newItems);
            pageIndex++;
          }
          _cachedData[categoryId] = SearchFromCatModel.fromJson(responseAsMap);
        } else if (code == 205 && pageIndex > 1) {
          hasMore = false;
          statusrequest = Statusrequest.noDataPageindex;
          Get.snackbar(
            "message",
            "no more data",
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          hasMore = false;
          statusrequest = Statusrequest.noData;
        }
      }
    } catch (e) {
      hasMore = false;
      statusrequest = Statusrequest.failuer;
    }
    _endLoading(isLoadMore: isLoadMore);
  }

  @override
  void onInit() {
    super.onInit();
    nameCat = Get.arguments["namecat"];
    categoryId = Get.arguments["categoryId"];
    // print("categoryId=>$categoryId");
    // print("nameCat=>$nameCat");
    if (Get.arguments["categorymodel"] is List<ResultListCat>) {
      categorymodel = Get.arguments["categorymodel"];
    } else {
      categorymodelFromImage = Get.arguments["categorymodel"];
    }

    if (_cachedData.containsKey(categoryId!) &&
        _cachedData[categoryId!] != null) {
      searchFromCatModel = _cachedData[categoryId];
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
  gotoditels({required id, required lang, required Title}) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": id, "lang": lang, "title": Title},
    );
  }
  // ------------------------------------------------------------------

  void _startLoading({bool isLoadMore = false}) {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      pageIndex = 1;
      hasMore = true;
      items.clear();
      statusrequest = Statusrequest.loading;
    }
    update();
  }

  void _endLoading({bool isLoadMore = false}) {
    if (isLoadMore) isLoading = false;
    update();
  }
}
