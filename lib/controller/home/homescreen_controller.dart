import 'dart:developer';
import 'package:e_comerece/controller/home/home_platform_controller/alibaba_home_controller.dart';
import 'package:e_comerece/controller/home/home_platform_controller/aliexpress_home_controller.dart';
import 'package:e_comerece/controller/home/home_platform_controller/amazon_home_con.dart';
import 'package:e_comerece/controller/home/home_platform_controller/shein_hom_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/search_name_alibaba_data.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/searchtext_data.dart';
import 'package:e_comerece/data/datasource/remote/amazon_data/search_amazon_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/search_shein_data.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searshtextmodel.dart';
import 'package:e_comerece/viwe/screen/cart/cart_view.dart';
import 'package:e_comerece/viwe/screen/home/homepage.dart';
import 'package:e_comerece/viwe/screen/local_serviess/local_serviess_screen.dart';
import 'package:e_comerece/viwe/screen/orders/orders_screen.dart';
import 'package:e_comerece/viwe/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart'
    as search;
import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart'
    as searshshein;

abstract class HomescreenController extends GetxController {
  void changepage(int i);
  void loadMoreproductAlibaba();
  void loadMoreAliexpress();
  void loadMoreAmazon();
  void goToFavorit();
  void gotocart();
  void indexchange(int index);
}

class HomescreenControllerImple extends HomescreenController {
  PlatformSource selected = PlatformSource.all;
  void setPlatform(PlatformSource p) {
    selected = p;
    update();
    scrollToTop();
  }

  final ScrollController scrollContr = ScrollController();

  moveproduct() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (scrollContr.hasClients) {
        try {
          await Future.delayed(const Duration(seconds: 2));
          await scrollContr.animateTo(
            300,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
          );
          await Future.delayed(const Duration(milliseconds: 300));
          await scrollContr.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
          );
        } catch (_) {}
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollContrAlibaba = ScrollController();

  @override
  void onReady() {
    super.onReady();
    moveproduct();
    startInitShow();
    scrollContrAlibaba.addListener(() {
      if (!alibabaHomeController.isLoading && alibabaHomeController.hasMore) {
        final pixels = scrollContrAlibaba.position.pixels;
        final max = scrollContrAlibaba.position.maxScrollExtent;
        if (max > 0 && pixels >= max * 0.8) {
          loadMoreproductAlibaba();
        }
      }
    });
  }

  // @override
  // void onClose() {
  //   searchProducts.clear();
  //   searchProductsAliExpress.clear();
  //   searchProductsAlibaba.clear();
  //   searchProductsShein.clear();
  //   super.onClose();
  //   scrollController.dispose();
  //   scrollContr.dispose();
  //   scrollContrAlibaba.dispose();
  //   aliexpressHomeController.dispose();
  //   alibabaHomeController.dispose();
  //   amazonHomeCon.dispose();
  //   sheinHomController.dispose();
  //   searchController.dispose();
  // }

  void scrollToTop({bool animated = true}) {
    if (!scrollController.hasClients) return;
    if (animated) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.slowMiddle,
      );
    } else {
      scrollController.jumpTo(0.0);
    }
  }

  AliexpressHomeController aliexpressHomeController = Get.put(
    AliexpressHomeController(),
  );
  AlibabaHomeController alibabaHomeController = Get.put(
    AlibabaHomeController(),
  );
  AmazonHomeCon amazonHomeCon = Get.put(AmazonHomeCon());
  SheinHomController sheinHomController = Get.put(SheinHomController());

  TextEditingController searchController = TextEditingController();

  bool initShow = false;

  List<Widget> pages = [
    Homepage(),
    CartView(),
    OrdersScreen(),
    LocalServiessScreen(),
    Setting(),
  ];
  int pageindexHome = 0;
  int previousIndex = 0;
  List nameBottonBar = [
    {'title': 'Home', 'icon': FontAwesomeIcons.house},
    {'title': 'Cart', 'icon': FontAwesomeIcons.cartShopping},
    {'title': 'Orders', 'icon': FontAwesomeIcons.bagShopping},
    {'title': 'Local Services', 'icon': FontAwesomeIcons.store},
    {'title': 'Settings', 'icon': FontAwesomeIcons.gear},
  ];
  int currentIndex = 0;
  Statusrequest statusRequestHome = Statusrequest.none;

  int lengthAliexpress = 10;
  int lengthAlibaba = 10;
  int lengthAmazon = 10;
  int lengthShein = 10;

  bool showClose = false;

  startInitShow({int delayMs = 160}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!initShow) {
        initShow = true;
        update(['initShow']);
      }
    });
  }

  stopInitShow() {
    if (initShow) {
      initShow = false;
      update(['initShow']);
    }
  }

  @override
  indexchange(int index) {
    currentIndex = index;
    update(["index"]);
  }

  @override
  void changepage(int i) {
    if (pageindexHome == i) return;
    pageindexHome = i;
    update();
  }

  @override
  goToFavorit() {
    Get.toNamed(AppRoutesname.favoritescreen);
  }

  @override
  gotocart() {
    Get.toNamed(AppRoutesname.cartscreen);
  }

  @override
  loadMoreAliexpress() {
    aliexpressHomeController.fetchProductsAliExpress(isLoadMore: true);
    update(['aliexpress']);
  }

  @override
  loadMoreproductAlibaba() {
    alibabaHomeController.fethcProductsAlibaba(isLoadMore: true);
    update(['alibaba']);
  }

  @override
  loadMoreAmazon() {
    amazonHomeCon.fetchProducts(isLoadMore: true);
    update(['amazon']);
  }

  chngelengthAliexpress({bool showless = false}) async {
    if (showless) {
      lengthAliexpress = 10;
    } else if (lengthAliexpress == searchProductsAliExpress.length) {
      await searsAliexpress(isLoadMore: true);
      lengthAliexpress = searchProductsAliExpress.length;
    } else {
      lengthAliexpress = searchProductsAliExpress.length;
    }

    update(['aliexpress']);
  }

  chngelengthAlibaba({bool showless = false}) async {
    if (showless) {
      lengthAlibaba = 10;
    } else if (lengthAlibaba == searchProductsAlibaba.length) {
      await searshAlibaba(isLoadMore: true);
      lengthAlibaba = searchProductsAlibaba.length;
    } else {
      lengthAlibaba = searchProductsAlibaba.length;
    }

    update(['alibaba']);
  }

  chngelengthAmazon({bool showless = false}) async {
    if (showless) {
      lengthAmazon = 10;
    } else if (lengthAmazon == searchProducts.length) {
      await searshAmazon(isLoadMore: true);
      lengthAmazon = searchProducts.length;
    } else {
      lengthAmazon = searchProducts.length;
    }

    update(['amazon']);
  }

  chngelengthShein({bool showless = false}) async {
    if (showless) {
      lengthShein = 10;
    } else if (lengthShein == searchProductsShein.length) {
      await searshShein(isLoadMore: true);
      lengthShein = searchProductsShein.length;
    } else {
      lengthShein = searchProductsShein.length;
    }

    update(['shein']);
  }

  bool isSearch = false;
  onChangeSearch(String val) {
    if (val == "") {
      isSearch = false;
      update();
    }
  }

  searshAll() async {
    lengthAliexpress = 10;
    lengthAlibaba = 10;
    lengthAmazon = 10;
    lengthShein = 10;

    isSearch = true;
    statusRequestHome = Statusrequest.loading;
    update();
    await searsAliexpress();
    await searshAlibaba();
    await searshAmazon();
    await searshShein();
    statusRequestHome = Statusrequest.none;
    update();
  }

  onCloseSearch() {
    if (isSearch) {
      isSearch = false;
      lengthAliexpress = 10;
      lengthAlibaba = 10;
      lengthAmazon = 10;
      lengthShein = 10;
      searchController.clear();
      searchProducts.clear();
      searchProductsAliExpress.clear();
      searchProductsAlibaba.clear();
      searchProductsShein.clear();
      update();
      showClose = false;
      update(['initShow']);
    } else {
      searchController.clear();
      showClose = false;
      update(['initShow']);
    }
  }

  whenstartSearch(String q) async {
    if (q != "") {
      showClose = true;
      update(['initShow']);
    } else {
      showClose = false;
      update(['initShow']);
    }
  }

  int pageindexALiexpress = 1;
  List<ResultListSearshTextModel> searchProductsAliExpress = [];
  bool hasMoreAliexpress = true;
  bool isLoadingAliExpress = false;
  Statusrequest statusrequestAliExpress = Statusrequest.loading;
  SearchtextData searchtextDataAliexpress = SearchtextData(Get.find());

  searsAliexpress({bool isLoadMore = false}) async {
    cashkey(String q, int p) => 'search:aliexpress:$q:page=$p';
    if (isLoadMore) {
      if (isLoadingAliExpress || !hasMoreAliexpress) return;
      isLoadingAliExpress = true;
    } else {
      statusrequestAliExpress = Statusrequest.loading;
      pageindexALiexpress = 1;
      searchProductsAliExpress.clear();
      hasMoreAliexpress = true;
    }
    update(['aliexpress']);

    try {
      final cashe = await getCashData.getCash(
        query: cashkey(searchController.text, pageindexALiexpress),
        platform: "aliexpress",
      );
      if (cashe["status"] == "success") {
        log("get search from aliexpress cache server=====================");
        final response = cashe["data"];
        statusrequestAliExpress = handlingData(response);
        if (statusrequestAliExpress == Statusrequest.success) {
          if (handle200(response)) {
            final model = SearshTextModel.fromJson(response);
            final List<ResultListSearshTextModel> iterable =
                model.resultSearshTextModel!.resultListSearshTextModel!;

            if (iterable.isEmpty) {
              hasMoreAliexpress = false;
              statusrequestAliExpress = Statusrequest.noData;
            } else {
              searchProductsAliExpress.addAll(iterable);
              pageindexALiexpress++;
            }
          } else {
            hasMoreAliexpress = false;
            statusrequestAliExpress = Statusrequest.noData;
          }
        }
      } else {
        log("get search from aliexpress api=====================");
        final response = await searchtextDataAliexpress.getData(
          lang: detectLangFromQuery(searchController.text),
          keyWord: searchController.text,
          pageindex: pageindexALiexpress,
        );

        statusrequestAliExpress = handlingData(response);
        if (statusrequestAliExpress == Statusrequest.success) {
          if (handle200(response)) {
            final model = SearshTextModel.fromJson(response);
            final List<ResultListSearshTextModel> iterable =
                model.resultSearshTextModel!.resultListSearshTextModel!;

            if (iterable.isEmpty) {
              hasMoreAliexpress = false;
              statusrequestAliExpress = Statusrequest.noData;
            } else {
              searchProductsAliExpress.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(searchController.text, pageindexALiexpress),
                platform: "aliexpress",
                data: response,
                ttlHours: "24",
              );
              pageindexALiexpress++;
            }
          } else if (handle205(response, pageindexALiexpress)) {
            hasMoreAliexpress = false;
            statusrequestAliExpress = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          } else {
            hasMoreAliexpress = false;
            statusrequestAliExpress = Statusrequest.noData;
          }
        }
      }
    } catch (e) {
      hasMoreAliexpress = false;
      statusrequestAliExpress = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingAliExpress = false;
      update(['aliexpress']);
    }
  }

  bool hasMoresearchAlibaba = true;
  bool isLoadingSearchAlibaba = false;
  Statusrequest statusrequestsearchAlibaba = Statusrequest.none;
  int pageIndexSearchAlibaba = 0;
  List<ResultList> searchProductsAlibaba = [];
  SearchNameAlibabaData searchNameAlibabaData = SearchNameAlibabaData(
    Get.find(),
  );
  InsertCashData insertCashData = InsertCashData(Get.find());
  GetCashData getCashData = GetCashData(Get.find());

  searshAlibaba({
    // required q,
    isLoadMore = false,
    startPrice = "",
    endPrice = "",
  }) async {
    cashkey(String q, int p) => 'search:alibaba:$q:page=$p';
    if (isLoadMore) {
      if (isLoadingSearchAlibaba || !hasMoresearchAlibaba) return;
      isLoadingSearchAlibaba = true;
    } else {
      statusrequestsearchAlibaba = Statusrequest.loading;
      pageIndexSearchAlibaba = 1;
      searchProductsAlibaba.clear();
      hasMoresearchAlibaba = true;
    }
    update(['alibaba']);

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(searchController.text, pageIndexSearchAlibaba),
        platform: "alibaba",
      );
      if (cacheResponse["status"] == "success") {
        log("get from alibaba cache server=====================");
        final data = cacheResponse['data'];
        statusrequestsearchAlibaba = handlingData(data);
        if (statusrequestsearchAlibaba == Statusrequest.success) {
          if (handle200(data)) {
            final model = ProductAliBabaHomeModel.fromJson(data);
            final List<ResultList> iterable = model.result!.resultList;
            // settings = model.result?.settings;

            if (iterable.isEmpty) {
              hasMoresearchAlibaba = false;
              statusrequestsearchAlibaba = Statusrequest.noData;
            } else {
              searchProductsAlibaba.addAll(iterable);
              pageIndexSearchAlibaba++;
            }
          } else {
            hasMoresearchAlibaba = false;
            statusrequestsearchAlibaba = Statusrequest.noData;
          }
        }
      } else {
        log("get product Alibaba from api=====================");
        final response = await searchNameAlibabaData.getproductsSearch(
          lang: detectLangFromQuery(searchController.text),
          q: searchController.text,
          pageindex: pageIndexSearchAlibaba,
          endPrice: endPrice,
          startPrice: startPrice,
        );

        statusrequestsearchAlibaba = handlingData(response);
        if (statusrequestsearchAlibaba == Statusrequest.success) {
          if (handle200(response)) {
            final model = ProductAliBabaHomeModel.fromJson(response);
            final List<ResultList> iterable = model.result!.resultList;
            // settings = model.result?.settings;

            if (iterable.isEmpty) {
              // hasMoresearch = false;
              // statusrequestsearch = Statusrequest.noData;
            } else {
              searchProductsAlibaba.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(searchController.text, pageIndexSearchAlibaba),
                platform: "alibaba",
                data: response,
                ttlHours: "24",
              );
              pageIndexSearchAlibaba++;
            }
          } else if (handle205(response, pageIndexSearchAlibaba)) {
            hasMoresearchAlibaba = false;
            statusrequestsearchAlibaba = Statusrequest.noDataPageindex;
            custSnackBarNoMore();
          } else {
            hasMoresearchAlibaba = false;
            statusrequestsearchAlibaba = Statusrequest.noData;
          }
        }
      }
    } catch (e) {
      hasMoresearchAlibaba = false;
      statusrequestsearchAlibaba = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearchAlibaba = false;
      update(['alibaba']);
    }
  }

  bool isLoadingAmazon = false;
  bool hasMoreAmazon = true;
  Statusrequest statusrequestsearchAmazon = Statusrequest.none;
  int pageIndexSearchAmazon = 0;
  List<search.Product> searchProducts = [];
  SearchAmazonData searchDataAmazon = SearchAmazonData(Get.find());

  searshAmazon({bool isLoadMore = false, bool other = false}) async {
    cashkey(String q, int p) => 'search:amazon:$q:page=$p';

    if (isLoadMore) {
      if (isLoadingAmazon || !hasMoreAmazon) return;
      isLoadingAmazon = true;
    } else {
      statusrequestsearchAmazon = Statusrequest.loading;
      pageIndexSearchAmazon = 1;
      searchProducts.clear();
      hasMoreAmazon = true;
    }
    update(['amazon']);

    try {
      // final int intStartPrice = int.tryParse(startPriceController.text) ?? 0;
      // final int intEndPrice = int.tryParse(endPriceController.text) ?? 0;
      final int intStartPrice = 1;
      final int intEndPrice = 1000;
      final cashe = await getCashData.getCash(
        query: cashkey(
          "${searchController.text}_${intStartPrice}_$intEndPrice",
          pageIndexSearchAmazon,
        ),
        platform: "amazon",
      );
      if (cashe["status"] == "success") {
        log("get from amazon search cash =====================");
        final response = cashe["data"];

        statusrequestsearchAmazon = handlingData(response);
        if (statusrequestsearchAmazon == Statusrequest.success) {
          if (response is Map<String, dynamic> && response['status'] == 'OK') {
            final model = search.SearchAmazonModel.fromJson(response);
            final List<search.Product> iterable = model.data!.products;

            if (iterable.isEmpty) {
              hasMoreAmazon = false;
              statusrequestsearchAmazon = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              pageIndexSearchAmazon++;
            }
          } else {
            hasMoreAmazon = false;
            statusrequestsearchAmazon = Statusrequest.noData;
          }
        }
      } else {
        final response = await searchDataAmazon.getSearch(
          startPrice: intStartPrice,
          endPrice: intEndPrice,
          lang: detectLangFromQueryAmazon(searchController.text),
          q: searchController.text,
          pageindex: pageIndexSearchAmazon,
        );

        statusrequestsearchAmazon = handlingData(response);
        if (statusrequestsearchAmazon == Statusrequest.success) {
          if (response is Map<String, dynamic> && response['status'] == 'OK') {
            final model = search.SearchAmazonModel.fromJson(response);
            final List<search.Product> iterable = model.data!.products;

            if (iterable.isEmpty && pageIndexSearchAmazon > 1) {
              hasMoreAmazon = false;
              statusrequestsearchAmazon = Statusrequest.noDataPageindex;
              custSnackBarNoMore();
            } else if (iterable.isEmpty) {
              hasMoreAmazon = false;
              statusrequestsearchAmazon = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(
                  "${searchController.text}_${intStartPrice}_$intEndPrice",
                  pageIndexSearchAmazon,
                ),
                platform: "amazon",
                data: response,
                ttlHours: "24",
              );
              pageIndexSearchAmazon++;
            }
          } else {
            hasMoreAmazon = false;
            statusrequestsearchAmazon = Statusrequest.noData;
          }
        }
      }
    } catch (e) {
      hasMoreAmazon = false;
      statusrequestsearchAmazon = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingAmazon = false;
      update(['amazon']);
    }
  }

  bool isLoadingSearchShein = false;
  bool hasMoresearchShein = true;
  int pageindexSearchShein = 1;
  Statusrequest statusrequestsearchShein = Statusrequest.none;

  List<searshshein.Product> searchProductsShein = [];
  SearchSheinData searchSheinDataShein = SearchSheinData(Get.find());

  searshShein({isLoadMore = false, startPrice = "", endPrice = ""}) async {
    cashkey(String q, int p) => 'search:shein:$q:page=$p';

    if (isLoadMore) {
      if (isLoadingSearchShein || !hasMoresearchShein) return;
      isLoadingSearchShein = true;
    } else {
      statusrequestsearchShein = Statusrequest.loading;
      pageindexSearchShein = 1;
      searchProductsShein.clear();
      hasMoresearchShein = true;
      if (startPrice == "" && endPrice == "") {
        // startPriceController.clear();
        // endpriceController.clear();
      }
    }
    update(['shein']);

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(searchController.text, pageindexSearchShein),
        platform: "shein",
      );

      if (cacheResponse["status"] == "success") {
        log("get from shein search product cache=====================");
        final response = cacheResponse["data"];
        statusrequestsearchShein = handlingData(response);
        if (statusrequestsearchShein == Statusrequest.success) {
          if (response['success'] == true) {
            final model = searshshein.SeachSheinModel.fromJson(response);
            final List<searshshein.Product> iterable =
                model.data?.products ?? [];

            if (iterable.isEmpty && pageindexSearchShein == 1) {
              hasMoresearchShein = false;
              statusrequestsearchShein = Statusrequest.noData;
            } else {
              searchProductsShein.addAll(iterable);
              pageindexSearchShein++;
            }
          }
        }
      } else {
        final response = await searchSheinDataShein.getsearch(
          q: searchController.text,
          pageindex: pageindexSearchShein.toString(),
          endPrice: endPrice,
          startPrice: startPrice,
          countryCode: detectLangFromQueryShein(searchController.text),
        );

        statusrequestsearchShein = handlingData(response);
        if (statusrequestsearchShein == Statusrequest.success) {
          if (response['success'] == true) {
            final model = searshshein.SeachSheinModel.fromJson(response);
            final List<searshshein.Product> iterable =
                model.data?.products ?? [];

            if (iterable.isEmpty && pageindexSearchShein == 1) {
              hasMoresearchShein = false;
              statusrequestsearchShein = Statusrequest.noData;
            } else if (iterable.isEmpty && pageindexSearchShein > 1) {
              hasMoresearchShein = false;
              statusrequestsearchShein = Statusrequest.noDataPageindex;
              custSnackBarNoMore();
            } else {
              searchProductsShein.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(searchController.text, pageindexSearchShein),
                platform: "shein",
                data: response,
                ttlHours: "24",
              );
              pageindexSearchShein++;
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      hasMoresearchShein = false;
      statusrequestsearchShein = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearchShein = false;
      update(['shein']);
    }
  }

  gotoditels({
    id,
    required lang,
    required title,
    String? asin,
    required PlatformSource platform,
  }) {
    Get.toNamed(
      goTODetails(platform),
      arguments: {"product_id": id, "lang": lang, "title": title, "asin": asin},
    );
  }

  gotoditelsShein({
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
}

String goTODetails(PlatformSource platform) {
  switch (platform) {
    case PlatformSource.aliexpress:
      return AppRoutesname.detelspage;
    case PlatformSource.alibaba:
      return AppRoutesname.productDetailsAlibabView;
    case PlatformSource.amazon:
      return AppRoutesname.productDetailsAmazonView;
    default:
      return '';
  }
}
