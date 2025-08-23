import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/category_data.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/hotproductssdata.dart';
import 'package:e_comerece/data/model/categorymodel.dart';
import 'package:e_comerece/data/model/hotproductmodel.dart';
import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  fetchHomePageData();
  loadMore();
  gotoditels(String id);
  gotoshearchname(String nameCat, int categoryId);
}

class HomePageControllerImpl extends HomePageController {
  CategoryData categoryData = CategoryData(Get.find());
  HotProductsData hotProductsData = HotProductsData(Get.find());

  Statusrequest statusrequest = Statusrequest.none;

  List<CategoryModel> categories = [];
  List<ItemList> hotProducts = [];

  int pageIndex = 0;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchCategories() async {
    var categoryResponse = await categoryData.getData();

    // نتحقق أولاً أن الرد هو Map
    if (categoryResponse is Map && categoryResponse['status']?['code'] == 200) {
      // ==========================================================
      // >> هذا هو التعديل لإصلاح الخطأ <<
      // ==========================================================

      // قم بعمل cast للمتغير إلى النوع الصحيح قبل تمريره
      final responseAsMap = categoryResponse as Map<String, dynamic>;

      // 1. حوّل الرد الكامل إلى قائمة من الفئات باستخدام الموديل الجديد
      List<CategoryModel> allCategories = CategoryModel.fromJsonList(
        responseAsMap,
      );

      // 2. قم بعملية الفلترة المزدوجة (رئيسية ومطلوبة)
      List<CategoryModel> filteredMainCategories = allCategories.where((
        category,
      ) {
        final isMainCategory = category.parentCategoryId == null;
        final isWanted = wantedCategoryIds.contains(category.categoryId);
        return isMainCategory && isWanted;
      }).toList();

      // 3. قم بتحديث قائمة الفئات بالنتائج النهائية
      categories.assignAll(filteredMainCategories);
    }
  }

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequest = Statusrequest.loading;
      pageIndex = 1;
      hotProducts.clear();
      hasMore = true;
    }
    update(['products']);

    var hotProductsResponse = await hotProductsData.getData(pageIndex);
    print(hotProductsResponse);

    if (hotProductsResponse is Map &&
        hotProductsResponse['data']?['itemList'] != null) {
      var hotProductModel = Hotproductmodel.fromJson(
        hotProductsResponse['data'],
      );

      if (hotProductModel.itemList!.isEmpty) {
        hasMore = false;
      } else {
        hotProducts.addAll(hotProductModel.itemList!);
        pageIndex++;
      }
      if (!isLoadMore) statusrequest = Statusrequest.success;
    } else {
      if (!isLoadMore) {
        statusrequest =
            hotProductsResponse as Statusrequest? ?? Statusrequest.failuer;
      }
      hasMore = false;
    }

    isLoading = false;
    update();
  }

  @override
  void loadMore() {
    fetchProducts(isLoadMore: true);
  }

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  @override
  Future<void> fetchHomePageData() async {
    statusrequest = Statusrequest.loading;
    update();
    await Future.wait([fetchCategories(), fetchProducts()]);
    if (statusrequest == Statusrequest.loading) {
      statusrequest = Statusrequest.success;
    }
    update();
  }

  @override
  gotoditels(id) {
    Get.toNamed(AppRoutesname.detelspage, arguments: {"product_id": id});
  }

  @override
  gotoshearchname(nameCat, categoryId) {
    Get.toNamed(
      AppRoutesname.shearchname,
      arguments: {
        'namecat': nameCat,
        "categoryId": categoryId,
        "categorymodel": categories,
      },
    );
  }
}
