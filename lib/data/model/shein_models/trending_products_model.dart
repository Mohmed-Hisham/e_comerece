class TrendingProductsModel {
  TrendingProductsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  factory TrendingProductsModel.fromJson(Map<String, dynamic> json) {
    return TrendingProductsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      error: json["error"],
    );
  }
}

class Data {
  Data({required this.products});

  final List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x)),
            ),
    );
  }
}

class Product {
  Product({
    required this.goodsColorImage,
    required this.fromSkuCode,
    required this.newProductPriceStyleShow,
    required this.newProductPriceStyleSymbol,
    required this.parentIds,
    required this.reorder,
    required this.spu,
    required this.soldOutStatus,
    required this.productStockCheckLog,
    required this.goodsId,
    required this.goodsSn,
    required this.productRelationId,
    required this.goodsImg,
    required this.goodsName,
    required this.goodsUrlName,
    required this.catId,
    required this.cateName,
    required this.stock,
    required this.storeCode,
    required this.businessModel,
    required this.mallCode,
    required this.isOnSale,
    required this.retailPrice,
    required this.salePrice,
    required this.isInversion,
    required this.retailDiscountPercent,
    required this.isNewCoupon,
    required this.isSrpInversion,
    required this.srpDiscount,
    required this.unitDiscount,
    required this.originalDiscount,
    required this.premiumFlagNew,
    required this.quickship,
    required this.couponPrices,
    required this.videoUrl,
    required this.relatedColorNew,
    required this.isClearance,
    required this.isShowPlusSize,
    required this.commentNumShow,
    required this.commentRankAverage,
    required this.commentNum,
    required this.isSingleSku,
    required this.itemSource,
    required this.isShowAdditionalDiscount,
    required this.usePositionInfo,
    required this.productUrl,
    required this.detailImage,
    required this.localGoodsId,
    required this.unit,
  });

  final String? goodsColorImage;
  final String? fromSkuCode;
  final String? newProductPriceStyleShow;
  final String? newProductPriceStyleSymbol;
  final List<String> parentIds;
  final String? reorder;
  final String? spu;
  final bool? soldOutStatus;
  final String? productStockCheckLog;
  final String? goodsId;
  final String? goodsSn;
  final String? productRelationId;
  final String? goodsImg;
  final String? goodsName;
  final String? goodsUrlName;
  final String? catId;
  final String? cateName;
  final String? stock;
  final String? storeCode;
  final String? businessModel;
  final String? mallCode;
  final int? isOnSale;
  final DiscountPrice? retailPrice;
  final DiscountPrice? salePrice;
  final String? isInversion;
  final String? retailDiscountPercent;
  final String? isNewCoupon;
  final String? isSrpInversion;
  final String? srpDiscount;
  final String? unitDiscount;
  final String? originalDiscount;
  final PremiumFlagNew? premiumFlagNew;
  final String? quickship;
  final List<dynamic> couponPrices;
  final String? videoUrl;
  final List<RelatedColorNew> relatedColorNew;
  final String? isClearance;
  final String? isShowPlusSize;
  final String? commentNumShow;
  final String? commentRankAverage;
  final int? commentNum;
  final String? isSingleSku;
  final String? itemSource;
  final String? isShowAdditionalDiscount;
  final String? usePositionInfo;
  final String? productUrl;
  final List<String> detailImage;
  final String? localGoodsId;
  final String? unit;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      goodsColorImage: json["goodsColorImage"],
      fromSkuCode: json["fromSkuCode"],
      newProductPriceStyleShow: json["newProductPriceStyleShow"],
      newProductPriceStyleSymbol: json["newProductPriceStyleSymbol"],
      parentIds: json["parentIds"] == null
          ? []
          : List<String>.from(json["parentIds"]!.map((x) => x)),
      reorder: json["reorder"],
      spu: json["spu"],
      soldOutStatus: json["soldOutStatus"],
      productStockCheckLog: json["productStockCheckLog"],
      goodsId: json["goods_id"],
      goodsSn: json["goods_sn"],
      productRelationId: json["productRelationID"],
      goodsImg: json["goods_img"],
      goodsName: json["goods_name"],
      goodsUrlName: json["goods_url_name"],
      catId: json["cat_id"],
      cateName: json["cate_name"],
      stock: json["stock"],
      storeCode: json["store_code"],
      businessModel: json["business_model"],
      mallCode: json["mall_code"],
      isOnSale: json["is_on_sale"],
      retailPrice: json["retailPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailPrice"]),
      salePrice: json["salePrice"] == null
          ? null
          : DiscountPrice.fromJson(json["salePrice"]),
      isInversion: json["isInversion"],
      retailDiscountPercent: json["retailDiscountPercent"],
      isNewCoupon: json["isNewCoupon"],
      isSrpInversion: json["isSrpInversion"],
      srpDiscount: json["srpDiscount"],

      unitDiscount: json["unit_discount"],
      originalDiscount: json["original_discount"],

      premiumFlagNew: json["premiumFlagNew"] == null
          ? null
          : PremiumFlagNew.fromJson(json["premiumFlagNew"]),

      quickship: json["quickship"],
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      videoUrl: json["video_url"],
      relatedColorNew: json["relatedColorNew"] == null
          ? []
          : List<RelatedColorNew>.from(
              json["relatedColorNew"]!.map((x) => RelatedColorNew.fromJson(x)),
            ),
      isClearance: json["is_clearance"],
      isShowPlusSize: json["is_show_plus_size"],
      commentNumShow: json["comment_num_show"],
      commentRankAverage: json["comment_rank_average"],
      commentNum: json["comment_num"],
      isSingleSku: json["is_single_sku"],
      itemSource: json["item_source"],
      isShowAdditionalDiscount: json["isShowAdditionalDiscount"],
      usePositionInfo: json["usePositionInfo"],
      productUrl: json["productUrl"],
      detailImage: json["detail_image"] == null
          ? []
          : List<String>.from(json["detail_image"]!.map((x) => x)),
      localGoodsId: json["local_goods_id"],

      unit: json["unit"],
    );
  }
}

class DiscountPrice {
  DiscountPrice({
    required this.amount,
    required this.amountWithSymbol,
    required this.usdAmount,
    required this.usdAmountWithSymbol,
    required this.priceShowStyle,
  });

  final String? amount;
  final String? amountWithSymbol;
  final String? usdAmount;
  final String? usdAmountWithSymbol;
  final String? priceShowStyle;

  factory DiscountPrice.fromJson(Map<String, dynamic> json) {
    return DiscountPrice(
      amount: json["amount"],
      amountWithSymbol: json["amountWithSymbol"],
      usdAmount: json["usdAmount"],
      usdAmountWithSymbol: json["usdAmountWithSymbol"],
      priceShowStyle: json["priceShowStyle"],
    );
  }
}

class PremiumFlagNew {
  PremiumFlagNew({
    required this.brandSeriesType,
    required this.brandId,
    required this.brandBadgeName,
    required this.brandCode,
    required this.brandName,
    required this.productRecommendByGroup,
    required this.secondSeriesId,
    required this.brandLogoUrlLeft,
    required this.seriesBadgeName,
    required this.seriesId,
    required this.seriesLogoUrlLeft,
    required this.seriesLogoUrlRight,
    required this.brandLogoUrlRight,
  });

  final String? brandSeriesType;
  final String? brandId;
  final String? brandBadgeName;
  final String? brandCode;
  final String? brandName;
  final int? productRecommendByGroup;
  final String? secondSeriesId;
  final String? brandLogoUrlLeft;
  final String? seriesBadgeName;
  final String? seriesId;
  final String? seriesLogoUrlLeft;
  final String? seriesLogoUrlRight;
  final String? brandLogoUrlRight;

  factory PremiumFlagNew.fromJson(Map<String, dynamic> json) {
    return PremiumFlagNew(
      brandSeriesType: json["brandSeriesType"],
      brandId: json["brandId"],
      brandBadgeName: json["brand_badge_name"],
      brandCode: json["brand_code"],
      brandName: json["brandName"],
      productRecommendByGroup: json["productRecommendByGroup"],
      secondSeriesId: json["secondSeriesId"],
      brandLogoUrlLeft: json["brand_logo_url_left"],
      seriesBadgeName: json["series_badge_name"],
      seriesId: json["seriesId"],
      seriesLogoUrlLeft: json["series_logo_url_left"],
      seriesLogoUrlRight: json["series_logo_url_right"],
      brandLogoUrlRight: json["brand_logo_url_right"],
    );
  }
}

class RelatedColorNew {
  RelatedColorNew({
    required this.colorImage,
    required this.goodsId,
    required this.skcName,
  });

  final String? colorImage;
  final dynamic goodsId;
  final String? skcName;

  factory RelatedColorNew.fromJson(Map<String, dynamic> json) {
    return RelatedColorNew(
      colorImage: json["colorImage"],
      goodsId: json["goods_id"],
      skcName: json["skc_name"],
    );
  }
}

double? parseDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is num) return v.toDouble(); // covers other num variants
  if (v is String) {
    final parsed = double.tryParse(v);
    return parsed;
  }
  return null;
}
