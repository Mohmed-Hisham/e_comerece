import 'dart:developer';

import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/data/datasource/remote/amazon_data/hot_deals_amazon_data.dart';
import 'package:e_comerece/data/model/amazon_models/hotdeals_amazon_model.dart';
import 'package:get/get.dart';

class AmazonHomeCon extends GetxController {
  HotDealsAmazonData hotDealsData = HotDealsAmazonData(Get.find());
  int offset = 0;
  bool isLoading = false;
  bool hasMore = true;

  Statusrequest statusrequestHotProducts = Statusrequest.none;
  List<Deal> hotDeals = [];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  fetchProducts({isLoadMore = false}) async {
    final String platform = 'amazon-lang-${enOrArAmazon()}';
    String cacheKey(int p) => 'hotProducts:$platform:page=$p';
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestHotProducts = Statusrequest.loading;
      offset = 1;
      hotDeals.clear();
      hasMore = true;
    }
    try {
      final cache = await DBHelper.getCache(key: cacheKey(offset));
      if (cache != null) {
        log("get product amazon from cache=====================");
        final status = handlingData(cache);
        if (status == Statusrequest.success) {
          if (cache['status'] == 'OK') {
            final hotProductModel = HotDealsAmazonModel.fromJson(cache);

            if (hotProductModel.data!.deals.isEmpty) {
              hasMore = false;
            } else {
              hotDeals.addAll(hotProductModel.data!.deals);
            }
            if (!isLoadMore) statusrequestHotProducts = Statusrequest.success;
          } else if (cache['data']['deals'].isEmpty) {
            hasMore = false;
            statusrequestHotProducts = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          }
        } else {
          if (!isLoadMore) {
            statusrequestHotProducts =
                status as Statusrequest? ?? Statusrequest.failuer;
          }
          hasMore = false;
        }

        isLoading = false;
      } else {
        log(" get product amazon from API=====================");
        final hotProductsResponse = await hotDealsData.getHotDeals(offset);

        final status = handlingData(hotProductsResponse);
        if (status == Statusrequest.success) {
          if (hotProductsResponse is Map<String, dynamic> &&
              hotProductsResponse['status'] == 'OK') {
            final hotProductModel = HotDealsAmazonModel.fromJson(
              hotProductsResponse,
            );

            if (hotProductModel.data!.deals.isEmpty) {
              hasMore = false;
            } else {
              hotDeals.addAll(hotProductModel.data!.deals);
              DBHelper.saveCache(
                key: cacheKey(offset),
                type: 'hotproduct',
                data: hotProductsResponse,
                platform: platform,
                ttlHours: 24,
              );
            }
            if (!isLoadMore) statusrequestHotProducts = Statusrequest.success;
          } else if (hotProductsResponse['data']['deals'].isEmpty) {
            hasMore = false;
            statusrequestHotProducts = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          }
        } else {
          if (!isLoadMore) {
            statusrequestHotProducts =
                status as Statusrequest? ?? Statusrequest.failuer;
          }
          hasMore = false;
        }
        isLoading = false;
      }
      Future.delayed(Duration(milliseconds: 100), () {
        Get.find<HomescreenControllerImple>().update(['amazon']);
      });
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      statusrequestHotProducts = Statusrequest.failuer;
    } finally {
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        Get.find<HomescreenControllerImple>().update(['amazon']);
      });
    }
  }
}
