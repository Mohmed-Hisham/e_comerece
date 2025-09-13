// ignore_for_file: unused_import
import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/product_details_data.dart';
import 'package:e_comerece/data/datasource/remote/cart/cartviwe_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/itemdetelis_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsData productDetailsData = ProductDetailsData(Get.find());
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );
  CartviweData cartData = CartviweData(Get.find());

  Statusrequest statusrequest = Statusrequest.loading;
  ItemDetailsModel? itemDetailsModel;
  int? productId;
  String? lang;
  final PageController pageController = PageController(viewportFraction: 0.7);

  Map<String, String> selectedAttributes = {};
  SkuPriceList? currentSku;
  int quantity = 0;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();
  Map<String, int> cartQuantities = {};

  List<CartModel> cartItems = [];
  List<SkuPriceList> priceList = [];
  List<ProductSKUPropertyList> uiSkuProperties = [];

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'];
    lang = Get.arguments['lang'];
    fetchProductDetails();
    fetchCart();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  void fetchProductDetails() async {
    statusrequest = Statusrequest.loading;
    update();
    print("productId=>$productId");
    print("lang=>$lang");

    var response = await productDetailsData.getData(productId!, lang!);
    print("response=>$response");
    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      if (response['result']['status']['code'] == 200 &&
          response['result']['item'] != null) {
        itemDetailsModel = ItemDetailsModel.fromJson(
          response as Map<String, dynamic>,
        );
        _buildUiSchemasFromModel();
        _initializeDefaultAttributes();
        final videoUrl = videoUrlString;
        if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
          await _initializeVideoPlayer();
        }

        statusrequest = Statusrequest.success;
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }

    update();
  }

  void _initializeDefaultAttributes() {
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
      _updateCurrentSku();
    }
  }

  void updateSelectedAttribute(String attributeId, String valueId) {
    selectedAttributes[attributeId] = valueId;
    _updateCurrentSku();

    update();
  }

  void incrementQuantity() {
    if (currentSku != null && quantity < currentSku!.skuVal!.availQuantity!) {
      quantity++;
    }
    update(['quantity']);
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
    update(['quantity']);
  }

  void _updateCurrentSku() {
    if (priceList.isEmpty) return;

    currentSku = priceList.firstWhere((sku) {
      final skuIds = sku.skuPropIds?.split(',').toSet();
      final selectedIdsSet = selectedAttributes.values.toSet();

      return skuIds != null &&
          selectedIdsSet.length == skuIds.length &&
          selectedIdsSet.containsAll(skuIds);
    }, orElse: () => priceList.first);
  }

  Future<void> _initializeVideoPlayer() async {
    final videoUrl = videoUrlString;

    if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await videoPlayerController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: true,
      );
    }
  }

  Future<void> getquiqtity(String attributes) async {
    try {
      final newQty = await addorrmoveController.cartquintty(
        productId!,
        attributes,
      );
      if (newQty != quantity) {
        quantity = newQty;
        update(['quantity']);
      }
    } catch (e) {
      print('getquiqtity error: $e');
    }
  }

  Future<void> fetchCart() async {
    String userId = myServices.sharedPreferences.getString("user_id") ?? "0";
    if (userId == "0") return;

    var response = await cartData.getData(userId);

    if (response is Map &&
        response['status'] == 'success' &&
        response['data'] != null) {
      List cartlist = response['data'];
      // print("cartlist=>$cartlist");
      cartQuantities.clear();
      for (var item in cartlist) {
        String productId = item['productId'].toString();
        int qu = int.tryParse(item['cart_quantity']?.toString() ?? '0') ?? 0;

        cartQuantities[productId] = qu;
      }
    }
    update(['quantity']);
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
  final Amount? skuAmount; // original
  final Amount? skuActivityAmount; // promo/current
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

extension ProductDetailsUi on ProductDetailsController {
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
      (itemDetailsModel?.result?.item?.video is String)
      ? itemDetailsModel?.result?.item?.video as String
      : null;
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
