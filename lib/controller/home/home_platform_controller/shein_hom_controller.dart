import 'dart:developer';

import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/data/datasource/remote/shein/trendaing_shein_data.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';
import 'package:get/get.dart';

class SheinHomController extends GetxController {
  Statusrequest statusrequestproduct = Statusrequest.none;
  TrendaingSheinData trendaingSheinData = TrendaingSheinData(Get.find());
  List<Product> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int pageindexHotProduct = 1;

  @override
  void onInit() {
    super.onInit();
    fetchproducts();
  }

  loadMoreproductShein() {
    fetchproducts(isLoadMore: true);
  }

  fetchproducts({bool isLoadMore = false}) async {
    final String platform = 'shein';
    String cacheKey(int p) => 'hotProducts:$platform:page=$p:${enOrArShein()}';

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

    try {
      final cache = await DBHelper.getCache(key: cacheKey(pageindexHotProduct));
      if (cache != null) {
        log("get product Shein from cache=====================");
        statusrequestproduct = handlingData(cache);
        if (statusrequestproduct == Statusrequest.success) {
          if (cache['success'] == true) {
            final model = TrendingProductsModel.fromJson(cache);
            final List<Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              if (pageindexHotProduct == 1) {
                statusrequestproduct = Statusrequest.noData;
              }
              hasMore = false;
            } else {
              products.addAll(iterable);
              pageindexHotProduct++;
              if (!isLoadMore) statusrequestproduct = Statusrequest.success;
            }
          }
        }
      } else {
        log("fetch product Shein from api=====================");
        final response = await trendaingSheinData.getTrendingproduct(
          pageindexHotProduct,
        );
        statusrequestproduct = handlingData(response);

        if (statusrequestproduct == Statusrequest.success) {
          if (response['success'] == true) {
            final model = TrendingProductsModel.fromJson(response);
            final List<Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              if (pageindexHotProduct > 1) {
                statusrequestproduct = Statusrequest.noDataPageindex;
                custSnackBarNoMore();
              } else {
                statusrequestproduct = Statusrequest.noData;
              }

              log("statusrequestproduct $statusrequestproduct");
              // Note: If you want to show a specific message for "no more data" like the other controller,
              // you would need to import that function logic here or handle it in UI.
              hasMore = false;
            } else {
              products.addAll(iterable);
              statusrequestproduct = Statusrequest.success;
              DBHelper.saveCache(
                key: cacheKey(pageindexHotProduct),
                type: 'hotproduct',
                data: response,
                platform: platform,
                ttlHours: 24,
              );
              pageindexHotProduct++;
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      statusrequestproduct = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoading = false;
      update();
      Future.delayed(Duration(milliseconds: 100), () {
        if (Get.isRegistered<HomescreenControllerImple>()) {
          Get.find<HomescreenControllerImple>().update(['shein']);
        }
      });
    }
  }
}
