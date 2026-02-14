import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/mixins/cart_info_mixin.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/repository/shein/shein_repo_impl.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_image_list.dart'
    as shein_image_list;
import 'package:e_comerece/data/model/shein_models/details_shein_size.dart'
    as shein_size;
import 'package:e_comerece/data/model/shein_models/product_ditels_shein_model.dart'
    as shein_model;
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart'
    as shein_model_search;

abstract class ProductDetailsSheinController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  // Future<void> getquiqtity(String attributes);
  Future<void> searshText();
  Future<void> searshProduct({isLoadMore = false});
  // Selection and quantity
  void initializeDefaultAttributes();
  void updateSelectedVariant(shein_model.Variant variant);
  void incrementQuantity();
  void decrementQuantity();
  double? getCurrentPrice();
  String getCurrentPriceFormatted();
  String getTotalPriceFormatted();
  String getCurrentQuantityFormatted();
  int getMinQuantity();
  void indexchange(int index);
  void loadMoreSearch();
  void chaingPruduct({required String id, required String titleReload});
  void resetStateForNewProduct();
  gotoditels({
    required goodssn,
    required title,
    required goodsid,
    required categoryid,
  });

  // Simple getters for UI
  String? get subject;
  List<String> get imageList;
  String? get sellerName;
  String? get videoUrlString;
  // bool isProductAvailable();
  String getUnitName();
}

class ProductDetailsSheinControllerImple extends ProductDetailsSheinController
    with CartInfoMixin {
  SheinRepoImpl sheinRepoImpl = SheinRepoImpl(apiService: Get.find());

  @override
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );

  Statusrequest statusrequest = Statusrequest.loading;
  Statusrequest statusrequestImagesList = Statusrequest.loading;
  Statusrequest statusrequestSize = Statusrequest.loading;
  shein_model.ProductDitelsSheinDart? productDitelsSheinModel;
  String? goodssn;
  String? goodsid;
  String? categoryid;

  String? title;
  final PageController pageController = PageController(viewportFraction: 0.7);

  // Shein has variants list, pick one as current selection
  @override
  bool isInfoLoading = true;
  shein_model.Variant? currentVariant;
  @override
  int quantity = 1;
  @override
  int cartquantityDB = 0;
  @override
  bool isInCart = false;
  @override
  bool isFavorite = false;
  @override
  CartButtonState cartButtonState = CartButtonState.addToCart;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();

  Map<String, int> cartQuantities = {};
  List<CartData> cartItems = [];

  int currentIndex = 0;

  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;

  changisfavorite() {
    isFavorite = !isFavorite;
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  List<String> imageListFromApi = [];
  List<shein_size.SecondSaleAttribute> sizeAttributes = [];
  Map<int, String> selectedAttributeValue = {};

  bool isOneSearch = true;
  String label = '';
  String lang = '';

  @override
  void onInit() {
    super.onInit();
    goodssn = Get.arguments['goods_sn'];
    goodsid = Get.arguments['goods_id'];
    title = Get.arguments['title'];
    categoryid = Get.arguments['category_id'];
    lang = Get.arguments['lang'];
    fetchProductDetails();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  @override
  fetchProductDetails({String? prodId}) async {
    statusrequest = Statusrequest.loading;
    update();
    final response = await sheinRepoImpl.fetchProductDetails(
      goodssn ?? '',
      lang,
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequest = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is shein_model.ProductDitelsSheinDart) {
      productDitelsSheinModel = r;
      initializeDefaultAttributes();
      await fetchImageListFromApi();
      await fetchSizeProductDetails();
      getCartItemInfo();
      statusrequest = Statusrequest.success;
    }
    update();
  }

  fetchImageListFromApi() async {
    statusrequestImagesList = Statusrequest.loading;
    update(['imagesList']);
    final response = await sheinRepoImpl.fetchProductDetailsImageList(
      goodssn!,
      lang,
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestImagesList = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is shein_image_list.DetailsSheinImageList) {
      imageListFromApi = r.data?.detailImage ?? [];
      imageListFromApi.insert(0, r.data?.goodsImg ?? '');
      statusrequestImagesList = Statusrequest.success;
    }
    update(['imagesList']);
  }

  fetchSizeProductDetails() async {
    statusrequestSize = Statusrequest.loading;
    update();
    final response = await sheinRepoImpl.fetchProductDetailsSize(
      goodsid!,
      lang,
    );
    final r = response.fold((l) => l, (r) => r);
    if (r is Failure) {
      statusrequestSize = Statusrequest.failuer;
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }
    if (r is shein_size.DetailsSheinSize) {
      sizeAttributes = r.data?.secondSaleAttributes ?? [];
      initDefaultSelections();
      statusrequestSize = Statusrequest.success;
    }
    update();
  }

  void initDefaultSelections() {
    selectedAttributeValue.clear();
    for (var attr in sizeAttributes) {
      final list = attr.attrValueList;
      if (list.isNotEmpty) {
        // استخدم attrValueId لو موجود وإلا استخدم attrValue نفسه
        final first = list.first;
        final selectedId =
            (first.attrValueId != null && first.attrValueId!.isNotEmpty)
            ? first.attrValueId!
            : (first.attrValue ?? '');
        if (attr.attrId != null) {
          selectedAttributeValue[attr.attrId!] = selectedId;
        }
      }
    }
    update(); // لإعادة رسم الـ UI
  }

  /// تفحص هل القيمة المحددة هي نفسها للاختبار في الـ UI
  bool isSelectedValue(int attrId, String valueId) {
    return selectedAttributeValue[attrId] == valueId;
  }

  /// عند الضغط نغيّر الاختيار
  void selectValue(int attrId, String valueId) {
    selectedAttributeValue[attrId] = valueId;
    // لو حابب تعمل شيء آخر عند الاختيار (مثلاً تحميل بيانات بناءً على الاختيار) أضفه هنا
    update(['Size']);
  }

  @override
  initializeVideoPlayer() async {
    // Shein responses provided do not include a video url
    return;
  }

  // @override
  // getquiqtity(attributes) async {
  //   try {
  //     final Map<String, dynamic> newQty = await addorrmoveController
  //         .cartquintty(goodssn!.toString(), attributes);
  //     isFavorite = newQty['in_favorite'] == true;
  //     if (newQty['quantity'] != 0) {
  //       quantity = newQty['quantity'];
  //       cartquantityDB = newQty['quantity'];
  //       update(['quantity']);
  //       isInCart = true;
  //     } else {
  //       quantity = getMinQuantity();
  //       cartquantityDB = 0;
  //       isInCart = false;
  //       update(['quantity']);
  //     }
  //   } catch (e) {
  //     log('getquiqtity error: $e');
  //   }
  // }

  @override
  void indexchange(index) {
    currentIndex = index;
    update(["imagesList"]);
    // update();
  }

  @override
  searshText({bool isLoadMore = false, String? titleReload}) async {
    // Placeholder: integrate with your Shein search controller/data if needed
    statusrequestsearch = Statusrequest.noData;
    update(["searshText"]);
  }

  @override
  chaingPruduct({required id, required titleReload}) {
    resetStateForNewProduct();
    goodssn = id;
    title = titleReload;
    fetchProductDetails(prodId: id);
  }

  @override
  gotoditels({
    required goodssn,
    required title,
    required goodsid,
    required categoryid,
  }) {
    Get.toNamed(
      AppRoutesname.productDetailsSheinView,
      arguments: {
        "goods_sn": goodssn,
        "title": title,
        "goods_id": goodsid,
        "category_id": categoryid,
        "lang": lang,
      },
      preventDuplicates: false,
    );
  }

  // ===== Helpers & Getters =====
  shein_model.Products? get _product => productDitelsSheinModel?.data?.products;

  @override
  String? get subject => _product?.goodsName;

  String? get productLink => _product?.productUrl;

  @override
  List<String> get imageList {
    final imgs = <String>[];
    if (_product?.originalImg != null) {
      imgs.add(_fixMediaUrl(_product!.originalImg!));
    }
    if (_product?.goodsImg != null) imgs.add(_fixMediaUrl(_product!.goodsImg!));
    if (_product?.goodsThumb != null) {
      imgs.add(_fixMediaUrl(_product!.goodsThumb!));
    }
    return imgs;
  }

  @override
  String? get sellerName => _product?.brand;

  @override
  String? get videoUrlString => null;

  String _fixMediaUrl(String raw) {
    if (raw.isEmpty) return raw;
    if (raw.startsWith('//')) return 'https:$raw';
    if (raw.startsWith('http')) return raw;
    return 'https://$raw';
  }

  // Public variant helpers
  List<shein_model.Variant> get variants => _product?.variants ?? const [];

  List<String> getVariantImages([shein_model.Variant? variant]) {
    final imgs = <String>[];
    final v = variant ?? currentVariant;
    if (v != null) {
      if (v.originalImg != null && v.originalImg!.isNotEmpty) {
        imgs.add(_fixMediaUrl(v.originalImg!));
      }
      if (v.goodsImg != null && v.goodsImg!.isNotEmpty) {
        imgs.add(_fixMediaUrl(v.goodsImg!));
      }
      if (v.goodsThumb != null && v.goodsThumb!.isNotEmpty) {
        imgs.add(_fixMediaUrl(v.goodsThumb!));
      }
      // Color swatch image first for context
      if (v.goodsColorImage != null && v.goodsColorImage!.isNotEmpty) {
        imgs.insert(0, _fixMediaUrl(v.goodsColorImage!));
      }
    } else {
      imgs.addAll(imageList);
    }
    // Deduplicate
    final seen = <String>{};
    return imgs.where((e) => seen.add(e)).toList();
  }

  List<String> get availableColorImages {
    final set = <String>{};
    for (final v in variants) {
      if (v.goodsColorImage != null && v.goodsColorImage!.isNotEmpty) {
        set.add(_fixMediaUrl(v.goodsColorImage!));
      }
    }
    return set.toList();
  }

  List<dynamic> get sizeTemplateOptions => _product?.sizeTemplate ?? const [];

  List<shein_model.MallPrice> get activeMallPrices =>
      (currentVariant?.mallPrice.isNotEmpty == true)
      ? currentVariant!.mallPrice
      : (_product?.mallPrice ?? const []);

  List<shein_model.MallList> get activeMallList =>
      (currentVariant?.mallList.isNotEmpty == true)
      ? currentVariant!.mallList
      : (_product?.mallList ?? const []);

  void _selectDefaultVariant() {
    if (_product?.variants.isNotEmpty == true) {
      currentVariant = _product!.variants.first;
    } else {
      currentVariant = null;
    }
  }

  @override
  void initializeDefaultAttributes() {
    _selectDefaultVariant();
    quantity = getMinQuantity();
    update(['quantity']);
  }

  @override
  void updateSelectedVariant(shein_model.Variant variant) {
    currentVariant = variant;
    update();
  }

  @override
  double? getCurrentPrice() {
    // Prefer salePrice.usdAmount if present else retailPrice.usdAmount
    final priceStr =
        currentVariant?.salePrice?.usdAmount ??
        _product?.salePrice?.usdAmount ??
        currentVariant?.retailPrice?.usdAmount ??
        _product?.retailPrice?.usdAmount;
    if (priceStr == null) return null;

    final currencyService = Get.find<CurrencyService>();
    const sourceCurrency = 'USD';

    return currencyService.convert(
      amount: extractPrice(priceStr),
      from: sourceCurrency,
    );
  }

  @override
  String getCurrentPriceFormatted() {
    final priceStr =
        currentVariant?.salePrice?.usdAmount ??
        _product?.salePrice?.usdAmount ??
        currentVariant?.retailPrice?.usdAmount ??
        _product?.retailPrice?.usdAmount;

    if (priceStr == null) return 'N/A';

    final currencyService = Get.find<CurrencyService>();
    const sourceCurrency = 'USD';

    return currencyService.convertAndFormat(
      amount: extractPrice(priceStr),
      from: sourceCurrency,
    );
  }

  double getRawUsdPrice() {
    final priceStr =
        currentVariant?.salePrice?.usdAmount ??
        _product?.salePrice?.usdAmount ??
        currentVariant?.retailPrice?.usdAmount ??
        _product?.retailPrice?.usdAmount;
    return extractPrice(priceStr ?? '0');
  }

  @override
  String getTotalPriceFormatted() {
    final currentPrice = getCurrentPrice();
    if (currentPrice == null) return '0.00';
    final total =
        currentPrice *
        quantity; // Changed math.max(1, quantity) to quantity as min quantity is already handled.

    final currencyService = Get.find<CurrencyService>();
    final symbol = currencyService.getCurrencySymbol(
      currencyService.selectedCurrency,
    );

    if (currencyService.selectedCurrency == 'USD') {
      return '$symbol${total.toStringAsFixed(2)}';
    }
    return '${total.toStringAsFixed(2)} $symbol';
  }

  @override
  String getCurrentQuantityFormatted() {
    // Shein response does not provide tiered quantity formatting; return quantity
    return quantity.toString();
  }

  @override
  int getMinQuantity() {
    // Shein listing typically has min 1
    return 1;
  }

  @override
  void incrementQuantity({int? pressedCount}) {
    if (pressedCount == null) {
      quantity++;
      update(['quantity']);
    } else if (pressedCount >= getMinQuantity()) {
      quantity = pressedCount;
      update(['quantity']);
    }
  }

  @override
  void decrementQuantity() {
    final minQ = getMinQuantity();
    if (quantity > minQ) {
      quantity--;
      update(['quantity']);
    }
  }

  // @override
  // bool isProductAvailable() {
  //   final malls = _product?.mallList ?? currentVariant?.mallList ?? [];
  //   for (final mall in malls) {
  //     if (mall.stock != null && mall.stock! > 0) return true;
  //   }
  //   return false;
  // }

  @override
  String getUnitName() {
    return quantity == 1 ? 'piece' : 'pieces';
  }

  String _getSelectedAttributesJson() {
    return '{"size":"$label", "model":"${imageListFromApi.isNotEmpty ? imageListFromApi.first : ''}"}';
  }

  void addToCart() async {
    final productid = goodssn?.toString() ?? '';
    final title = subject?.toString() ?? '';
    final imageUrl = imageListFromApi.isNotEmpty ? imageListFromApi.first : '';

    cartButtonState = CartButtonState.loadingAddButton;
    update(['quantity']);

    try {
      bool success = await addorrmoveController.add(
        productid,
        title,
        imageUrl,
        getRawUsdPrice(),
        'Shein',
        quantity,
        _getSelectedAttributesJson(),
        1000, // stock
        tier: "",
        goodsSn: goodssn?.toString(),
        categoryId: categoryid?.toString(),
        porductink: productLink ?? "",
      );
      if (success) {
        cartquantityDB = quantity;
        isInCart = true;
        cartButtonState = CartButtonState.added;
        update(['quantity']);
        // getquiqtity(_getSelectedAttributesJson());
      }
    } catch (e) {
      log('addToCart error: $e');
      cartButtonState = CartButtonState.addToCart;
      update(['quantity']);
    }
  }

  @override
  String getProductId() => goodssn?.toString() ?? '';

  @override
  String getSelectedAttributesJson() => _getSelectedAttributesJson();
  @override
  void resetStateForNewProduct() {
    try {
      if (chewieController != null) {
        chewieController!.pause();
        chewieController!.dispose();
        chewieController = null;
      }
    } catch (_) {}
    try {
      if (videoPlayerController != null) {
        videoPlayerController!.pause();
        videoPlayerController!.dispose();
        videoPlayerController = null;
      }
    } catch (_) {}

    productDitelsSheinModel = null;
    currentVariant = null;
    quantity = 1;
    currentIndex = 0;
    statusrequest = Statusrequest.loading;
    isLoading = false;
    hasMoresearch = true;
    pageIndexSearch = 0;
    statusrequestsearch = Statusrequest.loading;
    cartQuantities.clear();
    try {
      if (pageController.hasClients) {
        pageController.jumpToPage(0);
      }
    } catch (_) {}
    update();
  }

  bool isLoadingSearch = false;
  int pageindex = 1;
  List<shein_model_search.Product> searchProducts = [];

  @override
  searshProduct({isLoadMore = false}) async {
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
      categoryid ?? '',
      title ?? '',
      pageindex.toString(),
      detectLangFromQueryShein(title ?? "SA"),
    );

    statusrequestsearch = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<shein_model_search.Product> iterable =
            r.data?.products ?? [];
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
    searshProduct(isLoadMore: true);
  }
}
