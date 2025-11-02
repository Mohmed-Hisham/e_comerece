import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/data/datasource/remote/amazon_data/search_amazon_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';
import 'package:e_comerece/data/model/amazon_models/categories_amazon_model.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart'
    as search;

abstract class ProductFromCategoriesController extends GetxController {
  changeCat(String valnaame, String valid, int index);
  Future<void> otherProducts({bool isLoadMore = false});
  void loadMoreOtherProduct();
}

class ProductFromCategoriesControllerImpl
    extends ProductFromCategoriesController {
  SearchAmazonData searchData = SearchAmazonData(Get.find());
  InsertCashData insertCashData = InsertCashData(Get.find());
  GetCashData getCashData = GetCashData(Get.find());

  //
  Statusrequest statusrequestOtherProduct = Statusrequest.none;
  List<search.Product> otherProduct = [];
  int pageIndexOtherProduct = 0;

  //

  @override
  void onInit() {
    super.onInit();
    categories = Get.arguments['categories'];
    categoryId = Get.arguments['categoryId'];
    otherProducts();
  }

  List<Datum> categories = [];
  late String categoryId;
  int selectedIndex = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  changeCat(valnaame, valid, index) {
    if (categoryId == valid) return;
    // nameCat = valnaame;
    categoryId = valid;
    selectedIndex = index;
    otherProducts();
    update();
  }

  @override
  otherProducts({bool isLoadMore = false}) async {
    cashkey(String q, int p) => 'productcategory:amazon:$q:page=$p';

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

    try {
      final cashe = await getCashData.getCash(
        query: cashkey(categoryId, pageIndexOtherProduct),
        platform: "amazon",
      );
      if (cashe["status"] == "success") {
        log("get from amazon category product cache=====================");
        final response = cashe["data"];

        statusrequestOtherProduct = handlingData(response);
        if (statusrequestOtherProduct == Statusrequest.success) {
          if (response is Map<String, dynamic> && response['status'] == 'OK') {
            final model = search.SearchAmazonModel.fromJson(response);
            final List<search.Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              hasMore = false;
              statusrequestOtherProduct = Statusrequest.noData;
            } else {
              otherProduct.addAll(iterable);
              pageIndexOtherProduct++;
            }
          } else {
            hasMore = false;
            statusrequestOtherProduct = Statusrequest.noData;
          }
        }
      } else {
        log("get from amazon category product api=====================");
        final response = await searchData.getSearch(
          startPrice: 1,
          endPrice: 1000,
          lang: enOrArAmazon(),
          q: categoryId,
          pageindex: pageIndexOtherProduct,
        );

        statusrequestOtherProduct = handlingData(response);
        if (statusrequestOtherProduct == Statusrequest.success) {
          if (response is Map<String, dynamic> && response['status'] == 'OK') {
            final model = search.SearchAmazonModel.fromJson(response);
            final List<search.Product> iterable = model.data!.products;

            if (iterable.isEmpty && pageIndexOtherProduct > 1) {
              hasMore = false;
              statusrequestOtherProduct = Statusrequest.noDataPageindex;
              custSnackBarNoMore();
            } else if (iterable.isEmpty) {
              hasMore = false;
              statusrequestOtherProduct = Statusrequest.noData;
            } else {
              otherProduct.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(categoryId, pageIndexOtherProduct),
                platform: "amazon",
                data: response,
                ttlHours: "24",
              );
              pageIndexOtherProduct++;
            }
          } else {
            hasMore = false;
            statusrequestOtherProduct = Statusrequest.noData;
          }
        }
      }
    } catch (e) {
      hasMore = false;
      statusrequestOtherProduct = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoading = false;
      update();
    }
  }

  @override
  loadMoreOtherProduct() {
    otherProducts(isLoadMore: true);
  }
}
