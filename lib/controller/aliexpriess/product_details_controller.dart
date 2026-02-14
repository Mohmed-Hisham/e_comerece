import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/mixins/cart_info_mixin.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/model/aliexpriess_model/itemdetelis_model.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo_impl.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

abstract class ProductDetailsController extends GetxController
    with CartInfoMixin {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  // Future<void> getquiqtity(String attributes);
  Future<void> searshText();

  void initializeDefaultAttributes();
  void updateSelectedAttribute(String attributeId, String valueId);
  void incrementQuantity();
  void decrementQuantity();
  void updateCurrentSku();
  void indexchange(int index);
  void loadMoreSearch(String lang);
  void chaingPruduct({
    required int id,
    required String title,
    required String lang,
  });
}

class ProductDetailsControllerImple extends ProductDetailsController
    with CartInfoMixin {
  AlexpressRepoImpl alexpressRepoImpl = AlexpressRepoImpl(
    apiService: Get.find(),
  );

  @override
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );

  Statusrequest statusrequest = Statusrequest.loading;
  Statusrequest statusrequestquantity = Statusrequest.loading;
  ItemDetailsModel? itemDetailsModel;
  int? productId;
  String? lang;
  String? title;
  bool inCart = false;

  Map<String, String> selectedAttributes = {};
  SkuPriceList? currentSku;
  @override
  int quantity = 1;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();
  Map<String, int> cartQuantities = {};

  List<CartModel> cartItems = [];
  List<SkuPriceList> priceList = [];
  List<ProductSKUPropertyList> uiSkuProperties = [];

  int currentIndex = 0;
  String? imgageAttribute;

  bool isLoading = false;
  bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.loading;
  List<ResultListHotprosuct> searchProducts = [];
  int loadSearchOne = 0;
  @override
  bool isInfoLoading = true;
  @override
  bool isFavorite = false;
  @override
  bool isInCart = false;
  @override
  int cartquantityDB = 0;
  @override
  CartButtonState cartButtonState = CartButtonState.addToCart;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'] as int?;
    lang = Get.arguments['lang'] as String?;
    title = Get.arguments['title'] as String?;
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
  fetchProductDetails() async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await alexpressRepoImpl.fetchProductDetails(
      enOrAr(),
      productId!,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequest = Statusrequest.failuer;
    }

    if (r is ItemDetailsModel) {
      itemDetailsModel = r;
      _buildUiSchemasFromModel();
      initializeDefaultAttributes();
      statusrequest = Statusrequest.success;
    }

    update();
    if (videoUrlString != null &&
        videoUrlString!.isNotEmpty &&
        videoUrlString != "0") {
      await initializeVideoPlayer();
    }
    update(['selectedAttributes']);
  }

  @override
  initializeDefaultAttributes() {
    if (uiSkuProperties.isNotEmpty) {
      for (var attribute in uiSkuProperties) {
        if (attribute.skuPropertyValues != null &&
            attribute.skuPropertyValues!.isNotEmpty) {
          selectedAttributes[attribute.skuPropertyId!] = attribute
              .skuPropertyValues!
              .first
              .propertyValueId!
              .toString();
        }
      }
      updateCurrentSku();
      getCartItemInfo();
    }
  }

  @override
  updateSelectedAttribute(attributeId, valueId) {
    selectedAttributes[attributeId] = valueId;
    updateCurrentSku();
    getCartItemInfo();

    update(['selectedAttributes']);
  }

  @override
  incrementQuantity() {
    if (currentSku != null && quantity < currentSku!.skuVal!.availQuantity!) {
      quantity++;
    }
    _updateButtonState();
    update(['quantity']);
  }

  @override
  decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
    _updateButtonState();
    update(['quantity']);
  }

  void _updateButtonState() {
    if (isInCart && quantity != cartquantityDB) {
      cartButtonState = CartButtonState.updateInCart;
    } else if (isInCart && quantity == cartquantityDB) {
      cartButtonState = CartButtonState.added;
    } else {
      cartButtonState = CartButtonState.addToCart;
    }
  }

  void addTOCart() async {
    final productid = productId?.toString() ?? '';
    final title = subject?.toString() ?? '';
    final imageUrl = imageList.isNotEmpty ? imageList[0].toString() : '';
    final stock = currentSku?.skuVal?.availQuantity ?? 0;
    cartButtonState = CartButtonState.loadingAddButton;
    update(['quantity']);

    try {
      bool success = await addorrmoveController.add(
        productid,
        title,
        imgageAttribute ?? imageUrl,
        getRawUsdPrice(),
        "aliexpress",
        quantity,
        jsonEncode(buildDisplayAttributes(selectedAttributes, uiSkuProperties)),
        stock,
        tier: "",
        porductink: productLink ?? "",
      );
      if (success) {
        cartquantityDB = quantity;
        isInCart = true;
        cartButtonState = CartButtonState.added;
        update(['quantity']);
      }
    } on Exception catch (e) {
      log('addTOCart error: $e');
    }
  }

  // Implementing methods required by CartInfoMixin
  @override
  String getProductId() => productId!.toString();

  @override
  String getSelectedAttributesJson() =>
      jsonEncode(buildDisplayAttributes(selectedAttributes, uiSkuProperties));

  @override
  updateCurrentSku() {
    if (priceList.isEmpty) return;

    currentSku = priceList.firstWhere((sku) {
      final skuIds = sku.skuPropIds?.split(',').toSet();
      final selectedIdsSet = selectedAttributes.values.toSet();

      return skuIds != null &&
          selectedIdsSet.length == skuIds.length &&
          selectedIdsSet.containsAll(skuIds);
    }, orElse: () => priceList.first);
  }

  @override
  initializeVideoPlayer() async {
    final videoUrl = videoUrlString;

    if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('https:$videoUrl'),
      );

      await videoPlayerController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: true,
      );
    }
  }

  @override
  indexchange(index) {
    currentIndex = index;
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
    update();

    final response = await alexpressRepoImpl.searchProducts(
      enOrAr(),
      pageIndexSearch,
      title ?? "",
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      if (!isLoadMore) {
        statusrequestsearch = Statusrequest.failuer;
      }
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    if (r is HotProductModel) {
      var newProducts = r.result?.resultListHotprosuct;
      if (newProducts == null || newProducts.isEmpty) {
        hasMoresearch = false;
        if (!isLoadMore) statusrequestsearch = Statusrequest.noData;
      } else {
        searchProducts.addAll(newProducts);
        pageIndexSearch++;
        if (!isLoadMore) statusrequestsearch = Statusrequest.success;
      }
    }
    isLoading = false;
    update();
  }

  @override
  loadMoreSearch(lang) {
    searshText(isLoadMore: true);
  }

  @override
  chaingPruduct({required id, required title, required lang}) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": id, "lang": lang, "title": title},
      preventDuplicates: false,
    );
    // fetchProductDetails(prodId: id);
    // searshText(titleReload: titleReload);
  }

  chaing() {
    searshText();
  }

  double getRawUsdPrice() {
    final price =
        currentSku?.skuVal?.skuActivityAmount?.formatedAmount ??
        currentSku?.skuVal?.skuAmount?.formatedAmount ??
        itemDetailsModel?.result?.item?.sku?.def?.promotionPrice ??
        itemDetailsModel?.result?.item?.sku?.def?.price;

    if (price == null) return 0.0;
    return extractPrice(price);
  }
}

// ================= UI TYPES/HELPERS FROM ItemDetailsModel =================

class SkuPriceList {
  final String? skuPropIds;
  final SkuVal? skuVal;
  SkuPriceList({this.skuPropIds, this.skuVal});
}

class SkuVal {
  final int? availQuantity;
  final Amount? skuAmount;
  final Amount? skuActivityAmount;
  SkuVal({this.availQuantity, this.skuAmount, this.skuActivityAmount});
}

class Amount {
  final String? formatedAmount;
  final double? value;
  Amount({this.formatedAmount, this.value});
}

class ProductSKUPropertyList {
  final String? skuPropertyId;
  final String? skuPropertyName;
  final List<SkuPropertyValue>? skuPropertyValues;
  ProductSKUPropertyList({
    this.skuPropertyId,
    this.skuPropertyName,
    this.skuPropertyValues,
  });
}

class SkuPropertyValue {
  final int? propertyValueId;
  final String? propertyValueDisplayName;
  final String? skuPropertyImagePath;
  SkuPropertyValue({
    this.propertyValueId,
    this.propertyValueDisplayName,
    this.skuPropertyImagePath,
  });
}

class SpecItem {
  final String? name;
  final String? value;
  SpecItem({this.name, this.value});
}

extension ProductDetailsUi on ProductDetailsControllerImple {
  void _buildUiSchemasFromModel() {
    final result = itemDetailsModel?.result;
    final item = result?.item;
    final settings = result?.settings;
    final sku = item?.sku;

    // Build attributes
    uiSkuProperties =
        sku?.props
            .map(
              (p) => ProductSKUPropertyList(
                skuPropertyId: p.pid?.toString(),
                skuPropertyName: p.name,
                skuPropertyValues: p.values
                    .map(
                      (v) => SkuPropertyValue(
                        propertyValueId: v.vid,
                        propertyValueDisplayName: v.name,
                        skuPropertyImagePath: v.image,
                      ),
                    )
                    .toList(),
              ),
            )
            .toList() ??
        [];

    // Build prices
    String currencyPrefix = settings?.currency != null
        ? '${settings?.currency} '
        : '';

    priceList =
        sku?.base.map((b) {
          final ids = (b.propMap ?? '')
              .split(RegExp('[;,]'))
              .where((e) => e.trim().isNotEmpty)
              .map((e) => e.split(':'))
              .where((parts) => parts.length == 2)
              .map((parts) => parts[1])
              .join(',');

          double? parsePrice(String? s) {
            if (s == null) return null;
            return double.tryParse(s.replaceAll(RegExp('[^0-9.]'), ''));
          }

          Amount? toAmount(String? raw) {
            if (raw == null) return null;
            final value = parsePrice(raw);
            return Amount(
              formatedAmount: raw.contains(RegExp('[A-Za-z]'))
                  ? raw
                  : '$currencyPrefix$raw',
              value: value,
            );
          }

          return SkuPriceList(
            skuPropIds: ids,
            skuVal: SkuVal(
              availQuantity: b.quantity,
              skuAmount: toAmount(b.price),
              skuActivityAmount: toAmount(b.promotionPrice ?? b.price),
            ),
          );
        }).toList() ??
        [];
  }

  // UI getters
  String? get subject => itemDetailsModel?.result?.item?.title;
  String? get productLink => itemDetailsModel?.result?.item?.itemUrl;
  List<String> get imageList => itemDetailsModel?.result?.item?.images ?? [];
  String? get sellerName => itemDetailsModel?.result?.seller?.storeTitle;
  String? get videoUrlString =>
      itemDetailsModel?.result?.item?.video?.url ?? "0";
  String? get packageWeight =>
      itemDetailsModel?.result?.delivery?.packageDetail?.weight;
  int? get packageLength =>
      itemDetailsModel?.result?.delivery?.packageDetail?.length;
  int? get packageWidth =>
      itemDetailsModel?.result?.delivery?.packageDetail?.width;
  int? get packageHeight =>
      itemDetailsModel?.result?.delivery?.packageDetail?.height;
  String? get reviewsCount => itemDetailsModel?.result?.reviews?.count;
  String? get averageStar => itemDetailsModel?.result?.reviews?.averageStar;
  List<SpecItem> get specifications =>
      itemDetailsModel?.result?.item?.properties?.list
          .map((e) => SpecItem(name: e.name, value: e.value))
          .toList() ??
      [];
}
