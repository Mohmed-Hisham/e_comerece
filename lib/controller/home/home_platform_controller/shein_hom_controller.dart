import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/repository/shein/shein_repo_impl.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';
import 'package:get/get.dart';

class SheinHomController extends GetxController {
  Statusrequest statusrequestproduct = Statusrequest.loading;
  SheinRepoImpl sheinRepoImpl = SheinRepoImpl(apiService: Get.find());
  List<Product> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int pageindexHotProduct = 1;

  // @override
  // void onInit () {
  //   super.onInit();
  //   fetchproducts();
  // }
  @override
  void onReady() {
    super.onReady();
    fetchproducts();
  }

  loadMoreproductShein() {
    fetchproducts(isLoadMore: true);
  }

  fetchproducts({bool isLoadMore = false}) async {
    if (!AppConfigService.to.showShein) {
      return;
    }
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
      // showCustomGetSnack(isGreen: false, text: r.errorMessage);
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
    Future.delayed(Duration(milliseconds: 100), () {
      if (Get.isRegistered<HomescreenControllerImple>()) {
        Get.find<HomescreenControllerImple>().update(['shein']);
      }
    });
  }
}
