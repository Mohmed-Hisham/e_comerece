import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';

import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart';
import 'package:e_comerece/data/repository/shein/shein_repo_impl.dart';
import 'package:get/get.dart';

abstract class ProductByCategoryController extends GetxController {
  Future<void> fetchProductByCategory({bool isLoadMore = false});
  void loadMoreSearch();
}

class ProductByCategoryControllerImple extends ProductByCategoryController {
  SheinRepoImpl sheinRepoImpl = SheinRepoImpl(apiService: Get.find());

  bool isLoadingSearch = false;
  int pageindex = 1;
  List<Product> searchProducts = [];
  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;

  String categoryid = "";
  String title = "";
  List<Datum> categories = [];

  @override
  onInit() {
    super.onInit();
    categoryid = Get.arguments['categoryid'];
    title = Get.arguments['title'];
    categories = Get.arguments['categories'] ?? [];
    fetchProductByCategory();
  }

  void changeCat(String valnaame, String valid, int index) {
    if (categoryid == valid) return;
    title = valnaame;
    categoryid = valid;
    // selectedIndex = index;
    fetchProductByCategory();
    update();
    update(['searchProducts']);
  }

  void gotoditels({
    required String goodssn,
    required String title,
    required String goodsid,
    required String categoryid,
  }) {
    Get.toNamed(
      AppRoutesname.productDetailsSheinView,
      arguments: {
        "goods_sn": goodssn,
        "title": title,
        "goods_id": goodsid,
        "category_id": categoryid,
      },
    );
  }

  @override
  fetchProductByCategory({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingSearch || !hasMoresearch) return;
      isLoadingSearch = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageindex = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update(['searchProducts']);

    final response = await sheinRepoImpl.fetchProductsByCategories(
      categoryid,
      title,
      pageindex.toString(),
      enOrArShein(),
    );

    statusrequestsearch = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<Product> iterable = r.data?.products ?? [];
        if (iterable.isEmpty && pageindex == 1) {
          hasMoresearch = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageindex > 1) {
          hasMoresearch = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProducts.addAll(iterable);
          pageindex++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoadingSearch = false;
    update(['searchProducts']);
  }

  @override
  loadMoreSearch() {
    fetchProductByCategory(isLoadMore: true);
  }
}
