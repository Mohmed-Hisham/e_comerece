import 'dart:developer';

import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/data/datasource/remote/shein/trendaing_shein_data.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';
import 'package:get/get.dart';

class SheinHomController extends GetxController {
  Statusrequest statusrequestproduct = Statusrequest.none;
  TrendaingSheinData trendaingSheinData = TrendaingSheinData(Get.find());
  List<Product> products = [];

  @override
  void onInit() {
    super.onInit();
    fetchproducts();
  }

  fetchproducts({bool isLoadMore = false}) async {
    final String platform = 'shein';
    String cacheKey(int p) => 'hotProducts:$platform:page=$p';
    statusrequestproduct = Statusrequest.loading;

    try {
      final cache = await DBHelper.getCache(key: cacheKey(1));
      if (cache != null) {
        print("get product Shein from cache=====================");
        statusrequestproduct = handlingData(cache);
        if (statusrequestproduct == Statusrequest.success) {
          if (cache['success'] == true) {
            final model = TrendingProductsModel.fromJson(cache);
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
        print("fetch product Shein from api=====================");
        final response = await trendaingSheinData.getTrendingproduct();
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
              DBHelper.saveCache(
                key: cacheKey(1),
                type: 'hotproduct',
                data: response,
                platform: platform,
                ttlHours: 24,
              );
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      statusrequestproduct = Statusrequest.failuer;
    } finally {
      Future.delayed(Duration(milliseconds: 100), () {
        Get.find<HomescreenControllerImple>().update(['shein']);
      });
    }
  }
}
