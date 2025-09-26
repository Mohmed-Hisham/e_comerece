import 'package:e_comerece/app_api/lin_kapi.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/productalibaba_home_data.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/search_name_alibaba_data.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductAlibabaHomeController extends GetxController {
  Future<void> fethcProducts();
  Future<void> searshText({
    required String q,
    isLoadMore = false,
    String startPrice,
    String endPrice,
  });
  void loadMoreproduct();
  void indexchange(int index);
  void goToSearchByimage();
  void goTofavorite();
  void loadMoreSearch();
  void onChangeSearch(String val);
  void onTapSearch({required String keyWord});
  void gotoditels({
    required int id,
    required String lang,
    required String Title,
  });
  void startInitShow({int delayMs});
  void stopInitShow();
}

class ProductAlibabaHomeControllerImp extends ProductAlibabaHomeController {
  ProductalibabaHomeData productalibabaHomeData = ProductalibabaHomeData(
    Get.find(),
  );
  SearchNameAlibabaData searchNameAlibabaData = SearchNameAlibabaData(
    Get.find(),
  );
  Statusrequest statusrequestproduct = Statusrequest.loading;
  Statusrequest statusrequestsearch = Statusrequest.none;
  Settings? settings;

  bool isLoading = false;
  bool isLoadingSearch = false;
  int pageindex = 1;
  int pageIndexSearch = 0;

  bool hasMore = true;
  bool hasMoresearch = true;
  bool isSearch = false;

  List<ResultList> products = [];
  List<ResultList> searchProducts = [];

  int currentIndex = 0;
  bool initShow = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController endprice = TextEditingController();
  TextEditingController startprice = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fethcProducts();
    startInitShow();
  }

  @override
  Future<void> fethcProducts({isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestproduct = Statusrequest.loading;
      pageindex = 1;
      products.clear();
      hasMore = true;
    }
    update();

    var hotProductsResponse = await productalibabaHomeData.getproductHome(
      pageindex: pageindex,
    );

    var status = handlingData(hotProductsResponse);
    if (status == Statusrequest.success) {
      if (handle200(hotProductsResponse)) {
        var hotProductModel = ProductAliBabaHomeModel.fromJson(
          hotProductsResponse,
        );

        if (hotProductModel.result!.resultList.isEmpty) {
          hasMore = false;
        } else {
          products.addAll(hotProductModel.result!.resultList);
          pageindex++;
        }
        if (!isLoadMore) statusrequestproduct = Statusrequest.success;
      } else if (handle205(hotProductsResponse, pageindex)) {
        hasMore = false;
        statusrequestproduct = Statusrequest.noDataPageindex;
        custSnackBarNoMore();
      }
      //  else {
      //   if (!isLoadMore) {
      //     statusrequestHotProducts =
      //         status as Statusrequest? ?? Statusrequest.failuer;
      //   }
      //   hasMore = false;
      // }
    } else {
      if (!isLoadMore) {
        statusrequestproduct =
            status as Statusrequest? ?? Statusrequest.failuer;
      }
      hasMore = false;
    }

    isLoading = false;
    print("statusrequestHotProducts=>$statusrequestproduct");
    update();
  }

  @override
  loadMoreproduct() {
    fethcProducts(isLoadMore: true);
  }

  @override
  searshText({
    required q,
    isLoadMore = false,
    startPrice = "",
    endPrice = "",
  }) async {
    if (isLoadMore) {
      if (isLoadingSearch || !hasMoresearch) return;
      isLoadingSearch = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update();

    try {
      var response = await searchNameAlibabaData.getproductsSearch(
        lang: detectLangFromQuery(searchController.text),
        q: q,
        pageindex: pageIndexSearch,
        endPrice: endPrice,
        startPrice: startPrice,
      );

      statusrequestsearch = handlingData(response);
      if (statusrequestsearch == Statusrequest.success) {
        if (handle200(response)) {
          final model = ProductAliBabaHomeModel.fromJson(response);
          final List<ResultList> iterable = model.result!.resultList;
          settings = model.result?.settings;

          if (iterable.isEmpty) {
            hasMoresearch = false;
            statusrequestsearch = Statusrequest.noData;
          } else {
            searchProducts.addAll(iterable);
            pageIndexSearch++;
          }
        } else if (handle205(response, pageIndexSearch)) {
          hasMoresearch = false;
          statusrequestsearch = Statusrequest.noDataPageindex;
          custSnackBarNoMore();
        } else {
          hasMoresearch = false;
          statusrequestsearch = Statusrequest.noData;
        }
      }
    } catch (e) {
      hasMoresearch = false;
      statusrequestsearch = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearch = false;
      update();
    }
  }

  @override
  loadMoreSearch() {
    searshText(
      q: searchController.text,
      isLoadMore: true,
      startPrice: startprice.text,
      endPrice: endprice.text,
    );
  }

  @override
  indexchange(index) {
    currentIndex = index;
    update(["index"]);
  }

  @override
  goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "Alibaba"},
    );
  }

  @override
  onChangeSearch(val) {
    if (val == "") {
      isSearch = false;
      update();
    }
  }

  @override
  onTapSearch({required keyWord}) {
    isSearch = true;
    searshText(q: keyWord);
    update();
  }

  @override
  gotoditels({required id, required lang, required Title}) {
    Get.toNamed(
      AppRoutesname.ProductDetailsAlibabView,
      arguments: {"product_id": id, "lang": lang, "title": Title},
    );
  }

  custprice(String endPrice, String startPrice) {
    searshText(
      q: searchController.text,
      endPrice: endPrice,
      startPrice: startPrice,
    );
  }

  @override
  goToSearchByimage() {
    Get.put(ImageManagerController())
      ..pickImage().then((image) {
        if (image.path != '')
          Get.dialog(
            barrierDismissible: false,
            Center(child: CircularProgressIndicator()),
          );
        uploadToCloudinary(
              filePath: image.path,
              cloudName: Appapi.cloudName,
              uploadPreset: Appapi.uploadPreset,
            )
            .then((url) {
              if (Get.isDialogOpen ?? false) Get.back();
              if (url != null) {
                print('Uploaded to: $url');
                Get.toNamed(
                  AppRoutesname.AlibabaByimageView,
                  arguments: {'url': url, 'image': image},
                );
              } else {}
            })
            .catchError((err) {
              print('Error: $err');
            });
      });
  }

  @override
  startInitShow({int delayMs = 160}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!initShow) {
        initShow = true;
        update(['initShow']);
      }
    });
  }

  @override
  stopInitShow() {
    if (initShow) {
      initShow = false;
      update(['initShow']);
    }
  }
}
