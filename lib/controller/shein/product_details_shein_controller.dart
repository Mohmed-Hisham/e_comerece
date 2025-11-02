import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/get_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/api_cash/insert_cash_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/product_by_categories_data.dart';
import 'package:e_comerece/data/datasource/remote/shein/product_ditels_shein_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_image_list.dart'
    as shein_image_list;
import 'package:e_comerece/data/model/shein_models/details_shein_size.dart'
    as shein_size;
import 'package:e_comerece/data/model/shein_models/product_ditels_shein_model.dart'
    as shein_model;
import 'package:e_comerece/data/model/shein_models/product_from_categories_shein_model.dart'
    as product_from_categories_shein_model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
// import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart'
//     as searsh;

abstract class ProductDetailsSheinController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  Future<void> getquiqtity(String attributes);
  Future<void> searshText();
  Future<void> searshProduct({isLoadMore = false});
  // Selection and quantity
  void initializeDefaultAttributes();
  void updateSelectedVariant(shein_model.Variant variant);
  void incrementQuantity();
  void decrementQuantity();
  double? getCurrentPrice();
  String getCurrentPriceFormatted();
  String getCurrentQuantityFormatted();
  int getMinQuantity();
  void indexchange(int index);
  void loadMoreSearch();
  void chaingPruduct({required String id, required String titleReload});
  void resetStateForNewProduct();

  // Simple getters for UI
  String? get subject;
  List<String> get imageList;
  String? get sellerName;
  String? get videoUrlString;
  bool isProductAvailable();
  String getUnitName();
}

class ProductDetailsSheinControllerImple extends ProductDetailsSheinController {
  final ProductDitelsSheinData productDitelsSheinData = ProductDitelsSheinData(
    Get.find(),
  );
  ProductByCategoriesData productByCategoriesData = ProductByCategoriesData(
    Get.find(),
  );

  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );
  CartviweData cartData = CartviweData(Get.find());
  InsertCashData insertCashData = InsertCashData(Get.find());
  GetCashData getCashData = GetCashData(Get.find());

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
  shein_model.Variant? currentVariant;
  int quantity = 1;
  int cartquantityDB = 0;
  bool isInCart = false;
  bool isFavorite = false;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();

  Map<String, int> cartQuantities = {};
  List<CartModel> cartItems = [];

  int currentIndex = 0;

  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  List<String> imageListFromApi = [];
  List<shein_size.SecondSaleAttribute> sizeAttributes = [];
  Map<int, String> selectedAttributeValue = {};

  bool isOneSearch = true;
  String label = '';

  @override
  void onInit() {
    super.onInit();
    goodssn = Get.arguments['goods_sn'];
    goodsid = Get.arguments['goods_id'];
    title = Get.arguments['title'];
    categoryid = Get.arguments['category_id'];
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
    try {
      // Shein product details API expects goods_sn; we will use title or id to fetch
      // Here assume backend accepts goods_sn via title if provided; otherwise use id as string
      // final goodsSn =
      //     Get.parameters['goods_sn'] ?? (title ?? productId?.toString() ?? '');
      var response = await productDitelsSheinData.getProductDitels(
        goodssn ?? '',
      );
      statusrequest = handlingData(response);

      if (Statusrequest.success == statusrequest) {
        if (response is Map && (response['success'] == true)) {
          productDitelsSheinModel = shein_model.ProductDitelsSheinDart.fromJson(
            Map<String, dynamic>.from(response),
          );
          initializeDefaultAttributes();
          await fetchImageListFromApi();
          await fetchSizeProductDetails();
          statusrequest = Statusrequest.success;
        } else {
          statusrequest = Statusrequest.failuer;
        }
      }
    } catch (e, st) {
      log('fetchProductDetails Shein error: $e\n$st');
      statusrequest = Statusrequest.failuer;
    }

    update();
  }

  fetchImageListFromApi() async {
    statusrequestImagesList = Statusrequest.loading;
    update(['imagesList']);
    try {
      var response = await productDitelsSheinData.getProductDitelsImageList(
        goodssn!,
      );
      statusrequestImagesList = handlingData(response);

      if (Statusrequest.success == statusrequestImagesList) {
        if (response is Map<String, dynamic> && (response['success'] == true)) {
          final imageList = shein_image_list.DetailsSheinImageList.fromJson(
            Map<String, dynamic>.from(response),
          );
          imageListFromApi = imageList.data?.detailImage ?? [];
          // goodsSnimage = imageList.data?.goodsImg;
          imageListFromApi.insert(0, imageList.data?.goodsImg ?? '');
          // initializeDefaultAttributes();
          statusrequestImagesList = Statusrequest.success;
        } else {
          statusrequestImagesList = Statusrequest.failuer;
        }
      }
    } catch (e, st) {
      log('fetchProductDetails Shein error: $e\n$st');
      statusrequestImagesList = Statusrequest.failuer;
    }

    update(['imagesList']);
  }

  fetchSizeProductDetails() async {
    statusrequestSize = Statusrequest.loading;
    update();
    try {
      var response = await productDitelsSheinData.getProductDitelsSize(
        goodsid: goodsid!,
      );
      statusrequestSize = handlingData(response);

      if (Statusrequest.success == statusrequestSize) {
        if (response is Map<String, dynamic> && (response['success'] == true)) {
          final sizeList = shein_size.DetailsSheinSize.fromJson(
            Map<String, dynamic>.from(response),
          );

          sizeAttributes = sizeList.data?.secondSaleAttributes ?? [];
          initDefaultSelections();

          statusrequestSize = Statusrequest.success;
        } else {
          statusrequestSize = Statusrequest.failuer;
        }
      }
    } catch (e, st) {
      log('size Shein error: $e\n$st');
      statusrequestSize = Statusrequest.failuer;
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

  @override
  getquiqtity(attributes) async {
    try {
      final Map<String, dynamic> newQty = await addorrmoveController
          .cartquintty(goodssn!.toString(), attributes);
      isFavorite = newQty['in_favorite'] == true;
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
      log('getquiqtity error: $e');
    }
  }

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

  // ===== Helpers & Getters =====
  shein_model.Products? get _product => productDitelsSheinModel?.data?.products;

  @override
  String? get subject => _product?.goodsName;

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
    // Prefer salePrice.amount if present else retailPrice.amount
    final priceStr =
        currentVariant?.salePrice?.amount ??
        _product?.salePrice?.amount ??
        currentVariant?.retailPrice?.amount ??
        _product?.retailPrice?.amount;
    if (priceStr == null) return null;
    final parsed = double.tryParse(priceStr);
    return parsed;
  }

  @override
  String getCurrentPriceFormatted() {
    final formatted =
        currentVariant?.salePrice?.amountWithSymbol ??
        _product?.salePrice?.amountWithSymbol ??
        currentVariant?.retailPrice?.amountWithSymbol ??
        _product?.retailPrice?.amountWithSymbol;
    return formatted ?? 'N/A';
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

  @override
  bool isProductAvailable() {
    // Consider stock info across malls; if any mall stock > 0 -> available
    final malls = _product?.mallList ?? currentVariant?.mallList ?? [];
    for (final mall in malls) {
      if (mall.stock != null && mall.stock! > 0) return true;
    }
    return false;
  }

  @override
  String getUnitName() {
    return quantity == 1 ? 'piece' : 'pieces';
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
  List<product_from_categories_shein_model.Product> searchProducts = [];

  @override
  searshProduct({isLoadMore = false}) async {
    cashkey(String q, int p) => 'productcdetails:shein:$q:page=$p';

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

    try {
      final cacheResponse = await getCashData.getCash(
        query: cashkey(title!, pageindex),
        platform: "shein",
      );

      if (cacheResponse["status"] == "success") {
        log("get from alibaba cache server=====================");
        final response = cacheResponse["data"];
        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = product_from_categories_shein_model
                .ProductFromCategoriesSheinModel.fromJson(response);
            final List<product_from_categories_shein_model.Product> iterable =
                model.data?.products ?? [];

            if (iterable.isEmpty && pageindex == 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else {
              searchProducts.addAll(iterable);
              pageindex++;
            }
          }
        }
      } else {
        final response = await productByCategoriesData.getproductbycategories(
          categoryId: categoryid!,
          pageindex: pageindex.toString(),
        );

        statusrequestsearch = handlingData(response);
        if (statusrequestsearch == Statusrequest.success) {
          if (response['success'] == true) {
            final model = product_from_categories_shein_model
                .ProductFromCategoriesSheinModel.fromJson(response);
            final List<product_from_categories_shein_model.Product> iterable =
                model.data?.products ?? [];

            if (iterable.isEmpty && pageindex == 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noData;
            } else if (iterable.isEmpty && pageindex > 1) {
              hasMoresearch = false;
              statusrequestsearch = Statusrequest.noDataPageindex;
              custSnackBarNoMore();
            } else {
              searchProducts.addAll(iterable);
              insertCashData.insertCash(
                query: cashkey(title!, pageindex),
                platform: "shein",
                data: response,
                ttlHours: "24",
              );
              pageindex++;
            }
          }
        }
      }
    } catch (e, st) {
      log('FETCH ERROR: $e\n$st');
      hasMoresearch = false;
      statusrequestsearch = Statusrequest.failuer;
    } finally {
      if (isLoadMore) isLoadingSearch = false;
      update(['searchProducts']);
      log("statusrequestsearch $statusrequestsearch");
    }
  }

  @override
  loadMoreSearch() {
    searshProduct(isLoadMore: true);
  }
}
