import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo_impl.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart'
    as alibabamodel;

class AlibabaHomeController extends GetxController {
  AlibabaRepoImpl alibabaRepoImpl = AlibabaRepoImpl(apiService: Get.find());
  int pageindexALiba = 1;
  List<alibabamodel.ResultList> productsAlibaba = [];
  bool hasMore = true;
  bool isLoading = false;
  Statusrequest statusrequestAlibaba = Statusrequest.loading;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fethcProductsAlibaba();
  // }
  @override
  void onReady() {
    super.onReady();
    fethcProductsAlibaba();
  }

  Future<void> fethcProductsAlibaba({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestAlibaba = Statusrequest.loading;
      pageindexALiba = 1;
      productsAlibaba.clear();
      hasMore = true;
    }

    final response = await alibabaRepoImpl.searchProducts(
      enOrAr(isArSA: true),
      pageindexALiba,
      "fashion",
      "1",
      "1000",
    );

    statusrequestAlibaba = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<alibabamodel.ResultList> iterable =
            r.result?.resultList ?? [];

        if (iterable.isEmpty && pageindexALiba == 1) {
          hasMore = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageindexALiba > 1) {
          hasMore = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          productsAlibaba.addAll(iterable);
          pageindexALiba++;
          return Statusrequest.success;
        }
      },
    );

    isLoading = false;
    Future.delayed(Duration(milliseconds: 100), () {
      if (Get.isRegistered<HomescreenControllerImple>()) {
        Get.find<HomescreenControllerImple>().update(['alibaba']);
      }
    });
  }
}
