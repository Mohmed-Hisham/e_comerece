import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/product_by_categories_data.dart';
import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/product_from_categories_shein_model.dart'
    as product_from_categories_shein_model;
import 'package:get/get.dart';

abstract class ProductByCategoryController extends GetxController {
  Future<void> fetchProductByCategory({isLoadMore = false});
  void loadMoreSearch();
}

class ProductByCategoryControllerImple extends ProductByCategoryController {
  ProductByCategoriesData productByCategoriesData = ProductByCategoriesData(
    Get.find(),
  );
  GetCashData getCashData = GetCashData(Get.find());
  InsertCashData insertCashData = InsertCashData(Get.find());

  bool isLoadingSearch = false;
  int pageindex = 1;
  List<product_from_categories_shein_model.Product> searchProducts = [];
  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;

  String categoryid = "";
  String title = "";
  List<Datum> categories = [];

  @override
  onInit() {
    super.onInit();
    categoryid = Get.arguments['categoryid'];
    title = Get.arguments['title'];
    categories = Get.arguments['categories'] ?? [];
    fetchProductByCategory();
  }

  changeCat(String valnaame, String valid, int index) {
    if (categoryid == valid) return;
    title = valnaame;
    categoryid = valid;
    // selectedIndex = index;
    fetchProductByCategory();
    update();
    update(['searchProducts']);
  }

  gotoditels({
    required String goodssn,
    required String title,
    required String goodsid,
    required String categoryid,
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
  fetchProductByCategory({isLoadMore = false}) async {
    cashkey(String q, int p) =>
        'productcdetails:shein:$q:page=$p:${enOrArShein()}';

    if (isLoadMore) {
      if (isLoadingSearch || !hasMoresearch) return;
      isLoadingSearch = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageindex = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update(['searchProducts']);

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(title, pageindex),
        platform: "shein",
      );

      if (cacheResponse["status"] == "success") {
        log("get from alibaba cache server=====================");
        final response = cacheResponse["data"];
        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = product_from_categories_shein_model
                .ProductFromCategoriesSheinModel.fromJson(response);
            final List<product_from_categories_shein_model.Product> iterable =
                model.data?.products ?? [];

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
        final response = await productByCategoriesData.getproductbycategories(
          categoryId: categoryid,
          pageindex: pageindex.toString(),
          countryCode: enOrArShein(),
        );

        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = product_from_categories_shein_model
                .ProductFromCategoriesSheinModel.fromJson(response);
            final List<product_from_categories_shein_model.Product> iterable =
                model.data?.products ?? [];

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
                query: cashkey(title, pageindex),
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
      update(['searchProducts']);
      log("statusrequestsearch $statusrequestsearch");
    }
  }

  @override
  loadMoreSearch() {
    fetchProductByCategory(isLoadMore: true);
  }
}
