import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/selected_attributes_tomap_fordb.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/product_ditels_alibaba_data.dart';
import 'package:e_comerece/data/datasource/remote/alibaba/search_name_alibaba_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart'
    as alibaba_model;
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

abstract class ProductDetailsAlibabaController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  Future<void> getquiqtity(String attributes);
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
  void chaingPruduct({required int id, required String titleReload});
  void resetStateForNewProduct();
}

class ProductDetailsAlibabaControllerImple
    extends ProductDetailsAlibabaController {
  final ProductDitelsAlibabaData productDitelsAlibabaData =
      ProductDitelsAlibabaData(Get.find());
  SearchNameAlibabaData searchNameAlibabaData = SearchNameAlibabaData(
    Get.find(),
  );

  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );
  CartviweData cartData = CartviweData(Get.find());

  Statusrequest statusrequest = Statusrequest.loading;
  alibaba_model.ProductDitelsAliBabaModel? productDitelsAliBabaModel;
  int? productId;
  String? lang;
  String? title;
  final PageController pageController = PageController(viewportFraction: 0.7);
  // final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  Map<String, alibaba_model.Value> selectedAttributes = {};
  alibaba_model.Base? currentSku;
  int quantity = 1;
  int cartquantityDB = 0;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();
  Map<String, int> cartQuantities = {};

  List<CartModel> cartItems = [];
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

  bool isInCart = false;
  bool isFavorite = false;

  changisfavorite() {
    isFavorite = !isFavorite;
    // update();
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'];
    lang = Get.arguments['lang'];
    title = Get.arguments['title'];
    fetchProductDetails();
    // Future.delayed(const Duration(seconds: 1), () {
    //   searshText();
    // });
    // fetchCart();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  @override
  fetchProductDetails({int? prodId}) async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await productDitelsAlibabaData.getData(
      prodId ?? productId!,
      lang!,
    );
    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      if (handle200(response)) {
        productDitelsAliBabaModel =
            alibaba_model.ProductDitelsAliBabaModel.fromJson(
              response as Map<String, dynamic>,
            );
        _buildUiSchemasFromModel();
        initializeDefaultAttributes();

        statusrequest = Statusrequest.success;
        getquiqtity(
          jsonEncode(selectedAttributesToMapForDb(selectedAttributes)),
        );
      } else if (handle5008(response)) {
        print('--------------------------------------handle5008');
        statusrequest = Statusrequest.failuerTryAgain;
      } else {
        statusrequest = Statusrequest.failuer;
      }
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
        errorBuilder: (context, error) => Center(child: Text('Error: $error')),
      );
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.code} - ${e.message} - ${e.details}');
    } catch (e, st) {
      debugPrint('Video init failed: $e\n$st');
    }
  }

  @override
  getquiqtity(attributes) async {
    try {
      final Map<String, dynamic> newQty = await addorrmoveController
          .cartquintty(productId!, attributes);
      log("newQty=>$newQty");
      isFavorite = newQty['in_favorite'];
      if (newQty['quantity'] != 0) {
        quantity = newQty['quantity'];
        cartquantityDB = newQty['quantity'];
        update(['quantity']);
        isInCart = true;
      } else {
        quantity = getMinQuantity();
        cartquantityDB = 0;
        isInCart = false;
        update(['quantity']);
      }
    } catch (e) {
      print('getquiqtity error: $e');
    }
  }

  @override
  indexchange(index) {
    currentIndex = index;
    // carouselController.animateToPage(index);
    update(["index"]);
  }

  @override
  searshText({bool isLoadMore = false, String? titleReload}) async {
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

    try {
      var response = await searchNameAlibabaData.getproductsSearch(
        lang: lang!,
        q: titleReload ?? title!,
        pageindex: pageIndexSearch,
      );

      statusrequestsearch = handlingData(response);
      if (statusrequestsearch == Statusrequest.success) {
        if (handle200(response)) {
          final model = ProductAliBabaHomeModel.fromJson(response);
          final List<ResultList> iterable = model.result!.resultList;

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
          // chaing();
          custSnackBarNoMore();
        } else {
          hasMoresearch = false;
          statusrequestsearch = Statusrequest.failuer;
        }
      }
    } catch (e) {
      hasMoresearch = false;
      statusrequestsearch = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoading = false;
      update(["searshText"]);
    }
  }

  @override
  loadMoreSearch(lang) {
    searshText(isLoadMore: true);
  }

  @override
  chaingPruduct({required id, required titleReload}) {
    resetStateForNewProduct();

    productId = id;
    title = titleReload;

    fetchProductDetails(prodId: id);
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
      propMapParts.add('${entry.key}:${entry.value}');
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
      update(['quantity']);
    } else if (pressedCount >= getMinQuantity()) {
      quantity = pressedCount;
      update(['quantity']);
    }
  }

  @override
  void decrementQuantity() {
    int minQty = getMinQuantity();
    if (quantity > minQty) {
      quantity--;
      update(['quantity']);
    }
  }

  // Additional utility methods

  String getCurrentPriceFormatted() {
    final priceItem = getCurrentPriceList();
    return priceItem?.priceFormatted ?? 'N/A';
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
      if (value.id == valueId) {
        return value.name ?? '';
      }
    }
    return '';
  }

  bool isAttributeSelected(String propertyName, alibaba_model.Value valueId) {
    return selectedAttributes[propertyName] == valueId;
  }

  double getTotalPrice() {
    final currentPrice = getCurrentPrice();
    return currentPrice != null ? currentPrice * quantity : 0.0;
  }

  String getTotalPriceFormatted() {
    final totalPrice = getTotalPrice();
    final currency = getCurrencyCode();
    return '$currency${totalPrice.toStringAsFixed(2)}';
  }

  bool isProductAvailable() {
    return productDitelsAliBabaModel?.result?.item?.available ?? false;
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

    productDitelsAliBabaModel = null;
    selectedAttributes.clear();
    currentSku = null;
    quantity = 1;
    priceList.clear();
    uiSkuProperties.clear();
    imgageAttribute = null;
    currentIndex = 0;

    statusrequest = Statusrequest.loading;
    isLoading = false;
    hasMoresearch = true;
    pageIndexSearch = 0;
    statusrequestsearch = Statusrequest.loading;
    searchProducts.clear();
    loadSearchOne = 0;

    cartQuantities.clear();

    try {
      if (pageController.hasClients) {
        pageController.jumpToPage(0);
      }
    } catch (_) {}

    update();
  }
}
