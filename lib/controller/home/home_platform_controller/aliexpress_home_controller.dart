import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/helper/db_database.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/hotproductssdata.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:get/get.dart';

class AliexpressHomeController extends GetxController {
  HotProductsData hotProductsData = HotProductsData(Get.find());
  int pageindexALiexpress = 1;
  List<ResultListHotprosuct> productsAliExpress = [];
  bool hasMore = true;
  bool isLoading = false;
  Statusrequest statusrequestAliExpress = Statusrequest.none;

  @override
  void onInit() async {
    super.onInit();
    await fetchProductsAliExpress();
  }

  fetchProductsAliExpress({isLoadMore = false}) async {
    final String platform = 'aliExpress-lang-${enOrAr()}';
    String cacheKey(int p) => 'hotProducts:$platform:page=$p';
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestAliExpress = Statusrequest.loading;
      pageindexALiexpress = 1;
      productsAliExpress.clear();
      hasMore = true;
    }
    // update(['aliexpress']);
    final cache = await DBHelper.getCache(key: cacheKey(pageindexALiexpress));
    if (cache != null) {
      print("get from aliexpress cache=====================");

      final status = handlingData(cache);

      if (status == Statusrequest.success) {
        if (handle200(cache)) {
          var hotProductModel = HotProductModel.fromJson(cache);

          if (hotProductModel.result!.resultListHotprosuct!.isEmpty) {
            hasMore = false;
          } else {
            productsAliExpress.addAll(
              hotProductModel.result!.resultListHotprosuct!,
            );
            pageindexALiexpress++;
          }
          if (!isLoadMore) statusrequestAliExpress = Statusrequest.success;
        }
      } else {
        if (!isLoadMore) {
          statusrequestAliExpress =
              status as Statusrequest? ?? Statusrequest.failuer;
        }
        hasMore = false;
      }
    } else {
      print("get product AliExpress from api=====================");
      final hotProductsResponse = await hotProductsData.getData(
        pageindexALiexpress,
      );

      final status = handlingData(hotProductsResponse);

      if (status == Statusrequest.success) {
        if (handle200(hotProductsResponse)) {
          var hotProductModel = HotProductModel.fromJson(hotProductsResponse);

          if (hotProductModel.result!.resultListHotprosuct!.isEmpty) {
            hasMore = false;
          } else {
            productsAliExpress.addAll(
              hotProductModel.result!.resultListHotprosuct!,
            );
            DBHelper.saveCache(
              key: cacheKey(pageindexALiexpress),
              type: 'hotproduct',
              data: hotProductsResponse,
              platform: platform,
              ttlHours: 24,
            );
            pageindexALiexpress++;
          }
          if (!isLoadMore) statusrequestAliExpress = Statusrequest.success;
        } else if (handle205(hotProductsResponse, pageindexALiexpress)) {
          hasMore = false;
          statusrequestAliExpress = Statusrequest.noDataPageindex;
          custSnackBarNoMore();
        }
      } else {
        if (!isLoadMore) {
          statusrequestAliExpress =
              status as Statusrequest? ?? Statusrequest.failuer;
        }
        hasMore = false;
      }
    }

    isLoading = false;
    Future.delayed(Duration(milliseconds: 100), () {
      Get.find<HomescreenControllerImple>().update(['aliexpress']);
    });
    // update(['aliexpress']);
  }
}
