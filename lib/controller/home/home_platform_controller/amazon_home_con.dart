import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/amazon_models/hotdeals_amazon_model.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo_impl.dart';
import 'package:get/get.dart';

class AmazonHomeCon extends GetxController {
  AmazonRepoImpl amazonRepoImpl = AmazonRepoImpl(apiService: Get.find());
  int offset = 0;
  bool isLoading = false;
  bool hasMore = true;

  Statusrequest statusrequestHotProducts = Statusrequest.loading;
  List<Deal> hotDeals = [];
  @override
  void onReady() {
    super.onReady();
    fetchProducts();
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProducts();
  // }

  fetchProducts({isLoadMore = false}) async {
    if (!AppConfigService.to.showAmazon) {
      return;
    }
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestHotProducts = Statusrequest.loading;
      offset = 1;
      hotDeals.clear();
      hasMore = true;
    }

    final response = await amazonRepoImpl.fetchHotDeals(enOrArAmazon());

    statusrequestHotProducts = response.fold(
      (l) {
        // showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<Deal> iterable = r.data?.deals ?? [];

        if (iterable.isEmpty) {
          hasMore = false;
          return Statusrequest.noData;
        } else {
          hotDeals.addAll(iterable);
          offset++;
          return Statusrequest.success;
        }
      },
    );

    isLoading = false;
    Future.delayed(Duration(milliseconds: 100), () {
      if (Get.isRegistered<HomescreenControllerImple>()) {
        Get.find<HomescreenControllerImple>().update(['amazon']);
      }
    });
  }
}
