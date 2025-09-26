import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/product_details_data.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/searchtext_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/aliexpriess_model/itemdetelis_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searshtextmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

/// Normalize arbitrary `response` to a Map<String, dynamic> that your
/// `fromJson` can accept.
///
/// Rules:
/// - If response is already Map<String, dynamic> -> return as is.
/// - If response is List:
///   - if empty -> return {} (empty map)
///   - if first element is Map -> return that first Map (with a log)
///   - otherwise -> return {'data': list}
/// - If response is String -> try jsonDecode and recurse
/// - Otherwise -> return {'value': response.toString()}
// Map<String, dynamic> normalizeToMap(dynamic response) {
//   try {
//     // 1) already a Map -> cast safe
//     if (response is Map<String, dynamic>) {
//       return response;
//     }

//     // 2) response is List -> try to pick sensible map
//     if (response is List) {
//       if (response.isEmpty) {
//         print('normalizeToMap: response is empty List -> returning empty Map');
//         return <String, dynamic>{};
//       }

//       final first = response.first;
//       if (first is Map<String, dynamic>) {
//         print(
//           'normalizeToMap: response is List but first item is Map -> using first Map (possible data loss)',
//         );
//         return Map<String, dynamic>.from(first);
//       }

//       // list of primitives -> wrap under "data"
//       print(
//         'normalizeToMap: response is List of non-maps -> wrapping into {data: list}',
//       );
//       return <String, dynamic>{'data': response};
//     }

//     // 3) response is String -> try parse json and recurse
//     if (response is String) {
//       final trimmed = response.trim();
//       if (trimmed.isEmpty) return <String, dynamic>{};
//       try {
//         final decoded = jsonDecode(trimmed);
//         return normalizeToMap(decoded);
//       } catch (e) {
//         // not JSON -> store raw string
//         print(
//           'normalizeToMap: response is String but not JSON -> returning as {value: string}',
//         );
//         return <String, dynamic>{'value': trimmed};
//       }
//     }

//     // 4) other types (int, double, bool, etc.) -> stringify
//     return <String, dynamic>{'value': response?.toString()};
//   } catch (e, st) {
//     print('normalizeToMap ERROR: $e\n$st');
//     return <String, dynamic>{};
//   }
// }

abstract class ProductDetailsController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  Future<void> getquiqtity(String attributes);
  Future<void> searshText();

  void initializeDefaultAttributes();
  void updateSelectedAttribute(String attributeId, String valueId);
  void incrementQuantity();
  void decrementQuantity();
  void updateCurrentSku();
  void indexchange(int index);
  void loadMoreSearch(String lang);
  void chaingPruduct({required int id, required String titleReload});
}

class ProductDetailsControllerImple extends ProductDetailsController {
  final ProductDetailsData productDetailsData = ProductDetailsData(Get.find());
  SearchtextData searchtextData = SearchtextData(Get.find());

  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );
  CartviweData cartData = CartviweData(Get.find());

  Statusrequest statusrequest = Statusrequest.loading;
  ItemDetailsModel? itemDetailsModel;
  int? productId;
  String? lang;
  String? title;
  final PageController pageController = PageController(viewportFraction: 0.7);

  Map<String, String> selectedAttributes = {};
  SkuPriceList? currentSku;
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
  List<ResultListSearshTextModel> searchProducts = [];
  int loadSearchOne = 0;

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
    var response = await productDetailsData.getData(
      prodId ?? productId!,
      lang!,
    );
    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      if (handle200(response)) {
        itemDetailsModel = ItemDetailsModel.fromJson(response);
        _buildUiSchemasFromModel();
        initializeDefaultAttributes();

        if (videoUrlString != null &&
            videoUrlString!.isNotEmpty &&
            videoUrlString != "0") {
          print("videoUrl==============>$videoUrlString");
          await initializeVideoPlayer();
        } else {
          print("$videoUrlString");
          print('no video');
        }

        statusrequest = Statusrequest.success;
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update(['selectedAttributes']);

    update();
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
    }
  }

  @override
  updateSelectedAttribute(attributeId, valueId) {
    selectedAttributes[attributeId] = valueId;
    updateCurrentSku();

    update(['selectedAttributes']);
  }

  @override
  incrementQuantity() {
    if (currentSku != null && quantity < currentSku!.skuVal!.availQuantity!) {
      quantity++;
    }
    update(['quantity']);
  }

  @override
  decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
    update(['quantity']);
  }

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
  getquiqtity(attributes) async {
    try {
      final Map<String, dynamic> newQty = await addorrmoveController
          .cartquintty(productId!, attributes);
      if (newQty == 0) {
        quantity = 1;
      } else {
        quantity = newQty['quantity'];
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
    print('-----------------------------------');
    print("titleReload=>$titleReload");
    print("isLoadMore=>$isLoadMore");
    print("title=>$title");
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

    try {
      var response = await searchtextData.getData(
        lang: lang!,
        keyWord: titleReload ?? title!,
        pageindex: pageIndexSearch,
      );

      statusrequestsearch = handlingData(response);
      if (statusrequestsearch == Statusrequest.success) {
        if (handle200(response)) {
          final model = SearshTextModel.fromJson(response);
          final List<ResultListSearshTextModel> iterable =
              model.resultSearshTextModel!.resultListSearshTextModel!;

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
      update();
    }
  }

  @override
  loadMoreSearch(lang) {
    searshText(isLoadMore: true);
  }

  @override
  chaingPruduct({required id, required titleReload}) {
    fetchProductDetails(prodId: id);
    // searshText(titleReload: titleReload);
  }

  chaing() {
    searshText();
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
                  : '${currencyPrefix}${raw}',
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
