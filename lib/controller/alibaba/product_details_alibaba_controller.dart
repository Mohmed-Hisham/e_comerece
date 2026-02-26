import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/mixins/cart_info_mixin.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/selected_attributes_tomap_fordb.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart'
    as alibaba_model;
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo_impl.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

abstract class ProductDetailsAlibabaController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  Future<void> searshText();

  // SKU and Attribute Management
  void initializeDefaultAttributes();
  void updateSelectedAttribute(String attributeId, alibaba_model.Value value);
  void incrementQuantity();
  void decrementQuantity();
  void updateCurrentSku();
  double? getCurrentPrice();
  alibaba_model.PriceList? getCurrentPriceList();
  int getMinQuantity();
  String getCurrentSkuId();
  void indexchange(int index);
  void loadMoreSearch(String lang);
  void chaingPruduct({
    required int id,
    required String lang,
    required String title,
  });
  // void resetStateForNewProduct();
}

class ProductDetailsAlibabaControllerImple
    extends ProductDetailsAlibabaController
    with CartInfoMixin {
  AlibabaRepoImpl alibabaRepoImpl = AlibabaRepoImpl(apiService: Get.find());

  @override
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );

  Statusrequest statusrequest = Statusrequest.loading;
  alibaba_model.ProductDitelsAliBabaModel? productDitelsAliBabaModel;
  int? productId;
  String? lang;
  String? title;

  Map<String, alibaba_model.Value> selectedAttributes = {};
  alibaba_model.Base? currentSku;
  @override
  int quantity = 1;
  @override
  int cartquantityDB = 0;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();
  Map<String, int> cartQuantities = {};

  List<CartData> cartItems = [];
  List<alibaba_model.PriceList> priceList = [];
  List<alibaba_model.Prop> uiSkuProperties = [];

  int currentIndex = 0;
  String? imgageAttribute;

  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;
  List<ResultList> searchProducts = [];
  int loadSearchOne = 0;

  @override
  bool isInfoLoading = true;
  @override
  bool isInCart = false;
  @override
  bool isFavorite = false;
  @override
  CartButtonState cartButtonState = CartButtonState.addToCart;

  changisfavorite() {
    isFavorite = !isFavorite;
    // update();
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'] as int?;
    lang = Get.arguments['lang'] as String?;
    title = Get.arguments['title'] as String?;
    fetchProductDetails();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  @override
  fetchProductDetails({int? prodId}) async {
    final int resolvedId = prodId ?? productId!;

    statusrequest = Statusrequest.loading;
    update();

    final response = await alibabaRepoImpl.fetchProductDetails(
      lang!,
      resolvedId.toString(),
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequest = Statusrequest.failuer;
    }

    if (r is alibaba_model.ProductDitelsAliBabaModel) {
      productDitelsAliBabaModel = r;
      _buildUiSchemasFromModel();
      initializeDefaultAttributes();

      statusrequest = Statusrequest.success;
      getCartItemInfo();
    }
    update(['selectedAttributes']);

    update();
    final videoUrl = videoUrlString;
    if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
      await initializeVideoPlayer();
      update(['videoPlayerController']);
    }
  }

  @override
  initializeVideoPlayer() async {
    final raw = videoUrlString ?? '';
    if (raw.isEmpty || raw == '0') return;

    final fixedUrl = raw.startsWith('//')
        ? 'https:$raw'
        : (raw.startsWith('http') ? raw : 'https://$raw');

    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(fixedUrl),
      );

      await videoPlayerController!.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: true,
        showControls: true,
        errorBuilder: (context, error) =>
            Center(child: Text('${StringsKeys.error.tr}: $error')),
      );
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.code} - ${e.message} - ${e.details}');
    } catch (e, st) {
      debugPrint('Video init failed: $e\n$st');
    }
  }

  @override
  indexchange(index) {
    currentIndex = index;
    update(["videoPlayerController"]);
  }

  @override
  searshText({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMoresearch) return;
      isLoading = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMoresearch = true;
    }
    update(["searshText"]);

    final response = await alibabaRepoImpl.searchProducts(
      lang! == "ar_MA" ? "ar_SA" : "en_US",
      pageIndexSearch,
      title!,
      "1",
      "1000",
    );

    statusrequestsearch = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<ResultList> iterable = r.result?.resultList ?? [];

        if (iterable.isEmpty && pageIndexSearch == 1) {
          hasMoresearch = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageIndexSearch > 1) {
          hasMoresearch = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProducts.addAll(iterable);
          pageIndexSearch++;
          return Statusrequest.success;
        }
      },
    );

    if (isLoadMore) isLoading = false;
    update(["searshText"]);
  }

  @override
  loadMoreSearch(lang) {
    searshText(isLoadMore: true);
  }

  @override
  chaingPruduct({required id, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAlibabView,
      arguments: {"product_id": id, "lang": lang, "title": title},
      preventDuplicates: false,
    );
  }

  chaing() {
    searshText();
  }

  List<alibaba_model.PriceList> get priceListFromModel =>
      productDitelsAliBabaModel
          ?.result
          ?.item
          ?.sku
          ?.def
          ?.priceModule
          ?.priceList ??
      [];

  String? get subject => productDitelsAliBabaModel?.result?.item?.title;
  String? get productLink => productDitelsAliBabaModel?.result?.item?.itemUrl;
  List<String> get imageList =>
      productDitelsAliBabaModel?.result?.item?.images ?? [];
  String? get sellerName =>
      productDitelsAliBabaModel?.result?.seller?.sellerId.toString();
  String? get videoUrlString =>
      productDitelsAliBabaModel?.result?.item?.video?.url;

  // Build UI schemas from model data
  void _buildUiSchemasFromModel() {
    if (productDitelsAliBabaModel?.result?.item?.sku?.props != null) {
      uiSkuProperties = productDitelsAliBabaModel!.result!.item!.sku!.props;
    }
    if (productDitelsAliBabaModel
            ?.result
            ?.item
            ?.sku
            ?.def
            ?.priceModule
            ?.priceList !=
        null) {
      priceList = productDitelsAliBabaModel!
          .result!
          .item!
          .sku!
          .def!
          .priceModule!
          .priceList;
    }
  }

  @override
  void initializeDefaultAttributes() {
    selectedAttributes.clear();
    if (uiSkuProperties.isNotEmpty) {
      for (var prop in uiSkuProperties) {
        if (prop.values.isNotEmpty) {
          selectedAttributes[prop.name!] = prop.values[0];
        }
      }
      updateCurrentSku();
    }
    // Set default quantity to minimum order quantity
    quantity = getMinQuantity();
    update(['selectedAttributes', 'quantity']);
  }

  @override
  void updateSelectedAttribute(
    String attributeName,
    alibaba_model.Value valueId,
  ) {
    selectedAttributes[attributeName] = valueId;
    updateCurrentSku();
    update(['selectedAttributes']);
  }

  @override
  void updateCurrentSku() {
    if (selectedAttributes.isEmpty ||
        productDitelsAliBabaModel?.result?.item?.sku?.base == null) {
      return;
    }

    // Build propMap string from selected attributes
    List<String> propMapParts = [];
    for (var entry in selectedAttributes.entries) {
      propMapParts.add('${entry.key}:${entry.value.id}');
    }
    String targetPropMap = propMapParts.join(';');

    // Find matching SKU
    for (var sku in productDitelsAliBabaModel!.result!.item!.sku!.base) {
      if (sku.propMap == targetPropMap) {
        currentSku = sku;
        break;
      }
    }

    // If no exact match, try to find partial match
    if (currentSku == null) {
      for (var sku in productDitelsAliBabaModel!.result!.item!.sku!.base) {
        bool matches = true;
        for (var entry in selectedAttributes.entries) {
          String expectedPart = '${entry.key}:${entry.value.id}';
          if (!sku.propMap!.contains(expectedPart)) {
            matches = false;
            break;
          }
        }
        if (matches) {
          currentSku = sku;
          break;
        }
      }
    }
  }

  @override
  double? getCurrentPrice() {
    if (priceList.isEmpty) return null;

    for (var priceItem in priceList) {
      final minQ = priceItem.minQuantity ?? 0;
      final maxQ = priceItem.maxQuantity ?? -1;

      if (quantity >= minQ && (maxQ == -1 || quantity <= maxQ)) {
        return priceItem.price;
      }
    }

    // If no specific price found, return the first available price
    return priceList.first.price;
  }

  @override
  alibaba_model.PriceList? getCurrentPriceList() {
    if (priceList.isEmpty) return null;

    for (var priceItem in priceList) {
      if (quantity >= priceItem.minQuantity! &&
          (priceItem.maxQuantity == -1 || quantity <= priceItem.maxQuantity!)) {
        return priceItem;
      }
    }

    return priceList.isNotEmpty ? priceList.first : null;
  }

  alibaba_model.PriceList? getCurrentquantity() {
    if (priceList.isEmpty) return null;

    for (var priceItem in priceList) {
      if (quantity >= priceItem.minQuantity! &&
          (priceItem.maxQuantity == -1 || quantity <= priceItem.maxQuantity!)) {
        return priceItem;
      }
    }

    return priceList.isNotEmpty ? priceList.first : null;
  }

  @override
  int getMinQuantity() {
    if (priceList.isEmpty) return 1;
    final mins = priceList.map((p) => p.minQuantity ?? 1);
    final minQty = mins.reduce((a, b) => math.min(a, b));
    return minQty < 1 ? 1 : minQty;
  }

  @override
  String getCurrentSkuId() {
    return currentSku?.skuId?.toString() ?? '';
  }

  @override
  void incrementQuantity({int? pressedCount}) {
    if (pressedCount == null) {
      quantity++;
    } else if (pressedCount >= getMinQuantity()) {
      quantity = pressedCount;
    }
    _updateButtonState();
    update(['quantity']);
  }

  @override
  void decrementQuantity() {
    int minQty = getMinQuantity();
    if (quantity > minQty) {
      quantity--;
    }
    _updateButtonState();
    update(['quantity']);
  }

  // Additional utility methods

  String getCurrentPriceFormatted() {
    final priceItem = getCurrentPriceList();
    if (priceItem == null) return 'N/A';

    final currencyService = Get.find<CurrencyService>();
    return currencyService.convertAndFormat(
      amount: priceItem.price ?? 0.0,
      from: 'USD',
    );
  }

  String getCurrentQuantityFormatted() {
    final priceItem = getCurrentPriceList();
    return priceItem?.quantityFormatted ?? 'N/A';
  }

  String getCurrencyCode() {
    return productDitelsAliBabaModel
            ?.result
            ?.item
            ?.sku
            ?.def
            ?.priceModule
            ?.currencyCode ??
        '\$';
  }

  List<alibaba_model.Prop> getAvailableProperties() {
    return uiSkuProperties;
  }

  List<alibaba_model.Value> getValuesForProperty(String propertyName) {
    for (var prop in uiSkuProperties) {
      if (prop.name == propertyName) {
        return prop.values;
      }
    }
    return [];
  }

  // String getSelectedAttributeValue(String propertyName) {
  //   return selectedAttributes[propertyName] ?? '';
  // }

  String getSelectedAttributeDisplayName(String propertyName) {
    final valueId = selectedAttributes[propertyName];
    if (valueId == null) return '';

    final values = getValuesForProperty(propertyName);
    for (var value in values) {
      if (value.id == valueId.id) {
        return value.name ?? '';
      }
    }
    return '';
  }

  bool isAttributeSelected(String propertyName, alibaba_model.Value valueId) {
    return selectedAttributes[propertyName]?.id == valueId.id;
  }

  double getTotalPrice() {
    final currentPrice = getCurrentPrice();
    return currentPrice != null ? currentPrice * quantity : 0.0;
  }

  String getTotalPriceFormatted() {
    final totalPrice = getTotalPrice();
    final currencyService = Get.find<CurrencyService>();
    return currencyService.convertAndFormat(amount: totalPrice, from: 'USD');
  }

  bool isProductAvailable() {
    return productDitelsAliBabaModel?.result?.item?.available ?? false;
  }

  @override
  String getProductId() => productId!.toString();

  @override
  String getSelectedAttributesJson() =>
      jsonEncode(selectedAttributesToMapForDb(selectedAttributes));

  void _updateButtonState() {
    if (isInCart && quantity != cartquantityDB) {
      cartButtonState = CartButtonState.updateInCart;
    } else if (isInCart && quantity == cartquantityDB) {
      cartButtonState = CartButtonState.added;
    } else {
      cartButtonState = CartButtonState.addToCart;
    }
  }

  void addToCart() async {
    final productid = productId?.toString() ?? '';
    final titleText = subject?.toString() ?? '';
    final imageUrl = imageList.isNotEmpty ? imageList[0].toString() : '';
    final stock = getCurrentPriceList()?.maxQuantity ?? 0;

    cartButtonState = CartButtonState.loadingAddButton;
    update(['quantity']);

    try {
      bool success = await addorrmoveController.add(
        productid,
        titleText,
        imgageAttribute ?? imageUrl,
        getCurrentPrice() ?? 0.0,
        'Alibaba',
        quantity,
        getSelectedAttributesJson(),
        stock,
        tier: jsonEncode(priceListToMap(priceListFromModel)),
        porductink: productLink ?? "",
      );
      if (success) {
        cartquantityDB = quantity;
        isInCart = true;
        cartButtonState = CartButtonState.added;
        update(['quantity']);
      }
    } catch (e) {
      log('addToCart error: \$e');
      cartButtonState = CartButtonState.addToCart;
      update(['quantity']);
    }
  }

  String getMinOrderQuantityFormatted() {
    return productDitelsAliBabaModel
            ?.result
            ?.item
            ?.sku
            ?.def
            ?.quantityModule
            ?.minOrder
            ?.quantityFormatted ??
        '1 piece';
  }

  String getUnitName() {
    if (quantity == 1) {
      return productDitelsAliBabaModel
              ?.result
              ?.item
              ?.sku
              ?.def
              ?.unitModule
              ?.single ??
          'piece';
    } else {
      return productDitelsAliBabaModel
              ?.result
              ?.item
              ?.sku
              ?.def
              ?.unitModule
              ?.multi ??
          'pieces';
    }
  }

  List<alibaba_model.ListElement> getProductProperties() {
    return productDitelsAliBabaModel?.result?.item?.properties?.list ?? [];
  }

  String? getCompanyName() {
    return productDitelsAliBabaModel?.result?.company?.companyName;
  }

  String? getCompanyType() {
    return productDitelsAliBabaModel?.result?.company?.companyType;
  }

  String? getCompanyContactName() {
    return productDitelsAliBabaModel?.result?.company?.companyContact?.name;
  }
}
