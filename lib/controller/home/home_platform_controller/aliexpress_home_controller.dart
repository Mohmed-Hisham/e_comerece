import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:e_comerece/data/repository/slider_repo.dart';
import 'package:e_comerece/data/model/slider_model.dart';
import 'package:get/get.dart';

class AliexpressHomeController extends GetxController {
  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );
  SliderRepoImpl sliderRepoImpl = SliderRepoImpl(apiService: Get.find());
  int pageindexALiexpress = 1;
  List<ResultListHotprosuct> productsAliExpress = [];
  bool hasMore = true;
  bool isLoading = false;
  Statusrequest statusrequestAliExpress = Statusrequest.none;
  Statusrequest statusRequestSlider = Statusrequest.none;
  List<SliderModel> sliders = [];

  fetchSliders() async {
    statusRequestSlider = Statusrequest.loading;
    update(['slider']);
    var response = await sliderRepoImpl.getSliders(platform: 'aliexpress');
    response.fold(
      (l) {
        statusRequestSlider = Statusrequest.failuer;
      },
      (r) {
        sliders.clear();
        sliders.addAll(r);
        statusRequestSlider = Statusrequest.success;
      },
    );
    update(['slider']);
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchProductsAliExpress();
    fetchSliders();
  }

  fetchProductsAliExpress({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestAliExpress = Statusrequest.loading;
      pageindexALiexpress = 1;
      productsAliExpress.clear();
      hasMore = true;
    }
    update(['aliexpress']);

    final response = await alexpressRepoImpl.fetchProducts(
      enOrAr(),
      pageindexALiexpress,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      if (!isLoadMore) {
        statusrequestAliExpress = Statusrequest.failuer;
      }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is HotProductModel) {
      var newProducts = r.result?.resultListHotprosuct;
      if (newProducts == null || newProducts.isEmpty) {
        hasMore = false;
        if (!isLoadMore) statusrequestAliExpress = Statusrequest.noData;
      } else {
        productsAliExpress.addAll(newProducts);
        pageindexALiexpress++;
        if (!isLoadMore) statusrequestAliExpress = Statusrequest.success;
      }
    }

    isLoading = false;
    Future.delayed(Duration(milliseconds: 100), () {
      Get.find<HomescreenControllerImple>().update(['aliexpress']);
    });
  }
}
