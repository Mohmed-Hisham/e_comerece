import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo_impl.dart';
import 'package:e_comerece/data/model/amazon_models/categories_amazon_model.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart'
    as search;
import 'package:e_comerece/core/loacallization/translate_data.dart';

abstract class ProductFromCategoriesController extends GetxController {
  void changeCat(String valnaame, String valid, int index);
  Future<void> otherProducts({bool isLoadMore = false});
  void loadMoreOtherProduct();
  void gotoditels({
    required String asin,
    required String lang,
    required String title,
  });
}

class ProductFromCategoriesControllerImpl
    extends ProductFromCategoriesController {
  AmazonRepoImpl amazonRepoImpl = AmazonRepoImpl(apiService: Get.find());

  //
  Statusrequest statusrequestOtherProduct = Statusrequest.none;
  List<search.Product> otherProduct = [];
  int pageIndexOtherProduct = 0;

  //

  @override
  void onInit() {
    super.onInit();
    categories = Get.arguments['categories'];
    categoryId = Get.arguments['categoryId'];
    categoryName = Get.arguments?['categoryName'];
    otherProducts();
  }

  List<Datum> categories = [];
  late String categoryId;
  String categoryName = "";
  int selectedIndex = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  changeCat(valnaame, valid, index) {
    if (categoryId == valid) return;
    categoryName = valnaame;
    categoryId = valid;
    selectedIndex = index;
    otherProducts();
    update();
  }

  @override
  otherProducts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestOtherProduct = Statusrequest.loading;
      pageIndexOtherProduct = 1;
      otherProduct.clear();
      hasMore = true;
    }
    update();

    final response = await amazonRepoImpl.searchProducts(
      enOrArAmazon(),
      categoryId,
      pageIndexOtherProduct,
      "1",
      "1000",
    );

    statusrequestOtherProduct = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<search.Product> iterable = r.data?.products ?? [];

        if (iterable.isEmpty && pageIndexOtherProduct == 1) {
          hasMore = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageIndexOtherProduct > 1) {
          hasMore = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          otherProduct.addAll(iterable);
          pageIndexOtherProduct++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoading = false;
    update();
  }

  @override
  loadMoreOtherProduct() {
    otherProducts(isLoadMore: true);
  }

  @override
  gotoditels({required asin, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAmazonView,
      arguments: {"asin": asin, "lang": lang, "title": title},
    );
  }
}
