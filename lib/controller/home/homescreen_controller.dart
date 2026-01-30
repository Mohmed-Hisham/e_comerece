import 'package:e_comerece/controller/home/home_platform_controller/alibaba_home_controller.dart';
import 'package:e_comerece/controller/home/home_platform_controller/aliexpress_home_controller.dart';
import 'package:e_comerece/controller/home/home_platform_controller/amazon_home_con.dart';
import 'package:e_comerece/controller/home/home_platform_controller/shein_hom_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo_impl.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo_impl.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo_impl.dart';
import 'package:e_comerece/data/repository/shein/shein_repo_impl.dart';
import 'package:e_comerece/data/model/slider_model.dart';
import 'package:e_comerece/data/repository/slider_repo.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:e_comerece/viwe/screen/cart/cart_view.dart';
import 'package:e_comerece/viwe/screen/home/homepage.dart';
import 'package:e_comerece/viwe/screen/local_serviess/local_serviess_screen.dart';
import 'package:e_comerece/viwe/screen/orders/orders_screen.dart';
import 'package:e_comerece/viwe/screen/settings/settings.dart';
import 'package:flutter/material.dart';
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
    // Wait for 2 frames to ensure the UI is fully rebuilt
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (scrollContr.hasClients) {
          try {
            await Future.delayed(const Duration(seconds: 2));
            if (!scrollContr.hasClients) return;
            await scrollContr.animateTo(
              300,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
            );
            await Future.delayed(const Duration(milliseconds: 300));
            if (!scrollContr.hasClients) return;
            await scrollContr.animateTo(
              0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
            );
          } catch (_) {}
        }
      });
    });
  }

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollContrAlibaba = ScrollController();

  @override
  void onReady() {
    super.onReady();

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
    fetchSliders();
    fetchOurProducts();
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

  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );
  AlibabaRepoImpl alibabaRepoImpl = AlibabaRepoImpl(apiService: Get.find());
  SheinRepoImpl sheinRepoImpl = SheinRepoImpl(apiService: Get.find());
  AmazonRepoImpl amazonRepoImpl = AmazonRepoImpl(apiService: Get.find());
  SliderRepoImpl sliderRepoImpl = SliderRepoImpl(apiService: Get.find());

  TextEditingController searchController = TextEditingController();

  bool initShow = false;

  List<Widget> pages = [
    const Homepage(),
    const CartView(),
    const OrdersScreen(),
    const LocalServiessScreen(),
    const Setting(),
  ];
  int pageindexHome = 0;
  int previousIndex = 0;
  List nameBottonBar = [
    {'title': 'Home', 'icon': 'assets/svg/home_icon.svg'},
    {'title': 'Cart', 'icon': 'assets/svg/cart_icon.svg'},
    {'title': 'Orders', 'icon': 'assets/svg/orders_icon.svg'},
    {'title': 'Services', 'icon': 'assets/svg/local_service.svg'},
    {'title': 'Profile', 'icon': 'assets/svg/persson_icon.svg'},
  ];
  int currentIndex = 0;
  Statusrequest statusRequestHome = Statusrequest.none;
  Statusrequest statusRequestSlider = Statusrequest.none;

  // Our Products
  Statusrequest ourProductsStatusRequest = Statusrequest.none;
  List<LocalProductModel> ourProducts = [];
  bool hasMoreOurProducts = true;
  bool _isLoadingMoreOurProducts = false;
  bool get isLoadingMoreOurProducts => _isLoadingMoreOurProducts;
  int _ourProductsPage = 1;
  static const int _ourProductsPageSize = 6;
  late LocalProductRepoImpl _localProductRepo;

  List<SliderModel> sliders = [];

  fetchSliders() async {
    statusRequestSlider = Statusrequest.loading;
    update(['slider']);
    var response = await sliderRepoImpl.getSliders();
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

  // Initialize Local Product Repository
  void _initLocalProductRepo() {
    _localProductRepo = LocalProductRepoImpl(apiService: Get.find());
  }

  // Fetch Our Products (Featured) from API
  fetchOurProducts() async {
    _initLocalProductRepo();
    ourProductsStatusRequest = Statusrequest.loading;
    _ourProductsPage = 1;
    hasMoreOurProducts = true;
    ourProducts.clear();
    update(['ourProducts']);

    final result = await _localProductRepo.getProducts(
      page: _ourProductsPage,
      pageSize: _ourProductsPageSize,
    );

    result.fold(
      (failure) {
        ourProductsStatusRequest = Statusrequest.failuer;
      },
      (response) {
        if (response.products != null && response.products!.isNotEmpty) {
          ourProducts.addAll(response.products!);
          hasMoreOurProducts = response.hasMore;
          ourProductsStatusRequest = Statusrequest.success;
        } else {
          ourProductsStatusRequest = Statusrequest.noData;
          hasMoreOurProducts = false;
        }
      },
    );

    update(['ourProducts']);
  }

  // Load more Our Products (Pagination)
  loadMoreOurProducts() async {
    if (_isLoadingMoreOurProducts || !hasMoreOurProducts) return;

    _isLoadingMoreOurProducts = true;
    update(['ourProducts']);
    _ourProductsPage++;

    final result = await _localProductRepo.getProducts(
      page: _ourProductsPage,
      pageSize: _ourProductsPageSize,
    );

    result.fold(
      (failure) {
        _ourProductsPage--;
      },
      (response) {
        if (response.products != null && response.products!.isNotEmpty) {
          ourProducts.addAll(response.products!);
          hasMoreOurProducts = response.hasMore;
        } else {
          hasMoreOurProducts = false;
        }
      },
    );

    _isLoadingMoreOurProducts = false;
    update(['ourProducts']);
  }

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
    update(["slider"]);
  }

  @override
  void changepage(int i) {
    if (pageindexHome == i) return;
    previousIndex = pageindexHome;
    pageindexHome = i;
    update(['bottomBar']); // ✅ تحديث الـ bottom bar فقط
  }

  /// Set page without navigation (used when coming from route)
  void setPageWithoutNav(int i) {
    if (pageindexHome == i) return;
    previousIndex = pageindexHome;
    pageindexHome = i;
    update(['bottomBar']); // ✅ تحديث الـ bottom bar فقط
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
  List<ResultListHotprosuct> searchProductsAliExpress = [];
  bool hasMoreAliexpress = true;
  bool isLoadingAliExpress = false;
  Statusrequest statusrequestAliExpress = Statusrequest.loading;

  searsAliexpress({bool isLoadMore = false}) async {
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

    final response = await alexpressRepoImpl.searchProducts(
      detectLangFromQuery(searchController.text),
      pageindexALiexpress,
      searchController.text,
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
        hasMoreAliexpress = false;
        if (!isLoadMore) statusrequestAliExpress = Statusrequest.noData;
      } else {
        searchProductsAliExpress.addAll(newProducts);
        moveproduct();
        pageindexALiexpress++;
        if (!isLoadMore) statusrequestAliExpress = Statusrequest.success;
      }
    }
    isLoadingAliExpress = false;
    update(['aliexpress']);
  }

  bool hasMoresearchAlibaba = true;
  bool isLoadingSearchAlibaba = false;
  Statusrequest statusrequestsearchAlibaba = Statusrequest.none;
  int pageIndexSearchAlibaba = 0;
  List<ResultList> searchProductsAlibaba = [];
  // SearchNameAlibabaData searchNameAlibabaData = SearchNameAlibabaData(
  //   Get.find(),
  // );

  searshAlibaba({
    isLoadMore = false,
    startPrice = "1",
    endPrice = "1000000",
  }) async {
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

    final response = await alibabaRepoImpl.searchProducts(
      detectLangFromQuery(searchController.text),
      pageIndexSearchAlibaba,
      searchController.text,
      startPrice,
      endPrice,
    );

    statusrequestsearchAlibaba = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<ResultList> iterable = r.result?.resultList ?? [];

        if (iterable.isEmpty && pageIndexSearchAlibaba == 1) {
          hasMoresearchAlibaba = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageIndexSearchAlibaba > 1) {
          hasMoresearchAlibaba = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProductsAlibaba.addAll(iterable);
          pageIndexSearchAlibaba++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoadingSearchAlibaba = false;
    update(['alibaba']);
  }

  bool isLoadingAmazon = false;
  bool hasMoreAmazon = true;
  Statusrequest statusrequestsearchAmazon = Statusrequest.none;
  int pageIndexSearchAmazon = 0;
  List<search.Product> searchProducts = [];

  searshAmazon({bool isLoadMore = false, bool other = false}) async {
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

    final int intStartPrice = 1;
    final int intEndPrice = 1000;

    final response = await amazonRepoImpl.searchProducts(
      detectLangFromQueryAmazon(searchController.text),
      searchController.text,
      pageIndexSearchAmazon,
      intStartPrice.toString(),
      intEndPrice.toString(),
    );

    statusrequestsearchAmazon = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<search.Product> iterable = r.data?.products ?? [];

        if (iterable.isEmpty && pageIndexSearchAmazon == 1) {
          hasMoreAmazon = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageIndexSearchAmazon > 1) {
          hasMoreAmazon = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProducts.addAll(iterable);
          pageIndexSearchAmazon++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoadingAmazon = false;
    update(['amazon']);
  }

  bool isLoadingSearchShein = false;
  bool hasMoresearchShein = true;
  int pageindexSearchShein = 1;
  Statusrequest statusrequestsearchShein = Statusrequest.none;

  List<searshshein.Product> searchProductsShein = [];
  // SearchSheinData searchSheinDataShein = SearchSheinData(Get.find());

  searshShein({
    isLoadMore = false,
    startPrice = "1",
    endPrice = "1000000",
  }) async {
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

    final response = await sheinRepoImpl.searchProducts(
      detectLangFromQueryShein(searchController.text),
      searchController.text,
      pageindexSearchShein,
      startPrice,
      endPrice,
    );

    statusrequestsearchShein = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<searshshein.Product> iterable = r.data?.products ?? [];
        if (iterable.isEmpty && pageindexSearchShein == 1) {
          hasMoresearchShein = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageindexSearchShein > 1) {
          hasMoresearchShein = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProductsShein.addAll(iterable);
          pageindexSearchShein++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoadingSearchShein = false;
    update(['shein']);
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
        "lang": enOrArShein(),
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
