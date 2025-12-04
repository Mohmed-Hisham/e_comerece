import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/productalibaba_home_data.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart'
    as alibabamodel;

class AlibabaHomeController extends GetxController {
  ProductalibabaHomeData productalibabaHomeData = ProductalibabaHomeData(
    Get.find(),
  );
  int pageindexALiba = 1;
  List<alibabamodel.ResultList> productsAlibaba = [];
  bool hasMore = true;
  bool isLoading = false;
  Statusrequest statusrequestAlibaba = Statusrequest.none;

  @override
  void onInit() {
    super.onInit();
    fethcProductsAlibaba();
  }

  Future<void> fethcProductsAlibaba({isLoadMore = false}) async {
    final String platform = 'alibaba-lang-${enOrAr(isArSA: true)}';
    String cacheKey(int p) => 'hotProducts:$platform:page=$p';
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestAlibaba = Statusrequest.loading;
      pageindexALiba = 1;
      productsAlibaba.clear();
      hasMore = true;
    }
    // update(['alibaba']);

    final cache = await DBHelper.getCache(key: cacheKey(pageindexALiba));
    if (cache != null) {
      print("get product AliBaba from cache=====================");
      final status = handlingData(cache);
      if (status == Statusrequest.success) {
        if (handle200(cache)) {
          var hotProductModel = alibabamodel.ProductAliBabaHomeModel.fromJson(
            cache,
          );

          if (hotProductModel.result!.resultList.isEmpty) {
            hasMore = false;
          } else {
            productsAlibaba.addAll(hotProductModel.result!.resultList);
            pageindexALiba++;
          }
          if (!isLoadMore) statusrequestAlibaba = Statusrequest.success;
        }
      } else {
        if (!isLoadMore) {
          statusrequestAlibaba =
              status as Statusrequest? ?? Statusrequest.failuer;
        }
        hasMore = false;
      }
    } else {
      print("get product AliBaba from api=====================");
      final hotProductsResponse = await productalibabaHomeData.getproductHome(
        pageindex: pageindexALiba,
      );

      final status = handlingData(hotProductsResponse);
      if (status == Statusrequest.success) {
        if (handle200(hotProductsResponse)) {
          var hotProductModel = alibabamodel.ProductAliBabaHomeModel.fromJson(
            hotProductsResponse,
          );

          if (hotProductModel.result!.resultList.isEmpty) {
            hasMore = false;
          } else {
            productsAlibaba.addAll(hotProductModel.result!.resultList);
            DBHelper.saveCache(
              key: cacheKey(pageindexALiba),
              type: 'hotproduct',
              data: hotProductsResponse,
              platform: platform,
              ttlHours: 24,
            );
            pageindexALiba++;
          }
          if (!isLoadMore) statusrequestAlibaba = Statusrequest.success;
        } else if (handle205(hotProductsResponse, pageindexALiba)) {
          hasMore = false;
          statusrequestAlibaba = Statusrequest.noDataPageindex;
          custSnackBarNoMore();
        }
      } else {
        if (!isLoadMore) {
          statusrequestAlibaba =
              status as Statusrequest? ?? Statusrequest.failuer;
        }
        hasMore = false;
      }
    }

    isLoading = false;
    Future.delayed(Duration(milliseconds: 100), () {
      Get.find<HomescreenControllerImple>().update(['alibaba']);
    });
    // update(['alibaba']);
  }
}
