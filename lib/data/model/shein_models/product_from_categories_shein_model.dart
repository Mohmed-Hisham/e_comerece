class ProductFromCategoriesSheinModel {
  ProductFromCategoriesSheinModel({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  factory ProductFromCategoriesSheinModel.fromJson(Map<String, dynamic> json) {
    return ProductFromCategoriesSheinModel(
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
    required this.detailImage,
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
    required this.discountPrice,
    required this.isInversion,
    required this.retailDiscountPrice,
    required this.retailDiscountPercent,
    required this.isNewCoupon,
    required this.isSrpInversion,
    required this.srpDiscount,
    required this.srpDiscountPrice,
    required this.unitDiscount,
    required this.originalDiscount,
    required this.premiumFlagNew,
    required this.productInfoLabels,
    required this.quickship,
    required this.couponPrices,
    required this.videoUrl,
    required this.relatedColorNew,
    required this.isClearance,
    required this.productMaterial,
    required this.isShowPlusSize,
    required this.actTagFromCcc,
    required this.rankInfo,
    required this.commentNumShow,
    required this.commentRankAverage,
    required this.commentNum,
    required this.percentOverallFit,
    required this.isSingleSku,
    required this.itemSource,
    required this.ext,
    required this.isShowAdditionalDiscount,
    required this.usePositionInfo,
    required this.productUrl,
    required this.promotionInfo,
    required this.localGoodsId,
    required this.singleItemPrice,
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
  final List<String> detailImage;
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
  final DiscountPrice? discountPrice;
  final String? isInversion;
  final DiscountPrice? retailDiscountPrice;
  final String? retailDiscountPercent;
  final String? isNewCoupon;
  final String? isSrpInversion;
  final String? srpDiscount;
  final DiscountPrice? srpDiscountPrice;
  final String? unitDiscount;
  final String? originalDiscount;
  final PremiumFlagNew? premiumFlagNew;
  final ProductInfoLabels? productInfoLabels;
  final String? quickship;
  final List<CouponPrice> couponPrices;
  final String? videoUrl;
  final List<RelatedColorNew> relatedColorNew;
  final String? isClearance;
  final ProductMaterial? productMaterial;
  final String? isShowPlusSize;
  final ActTagFromCcc? actTagFromCcc;
  final ActTagFromCcc? rankInfo;
  final String? commentNumShow;
  final String? commentRankAverage;
  final int? commentNum;
  final PercentOverallFit? percentOverallFit;
  final String? isSingleSku;
  final String? itemSource;
  final Ext? ext;
  final String? isShowAdditionalDiscount;
  final String? usePositionInfo;
  final String? productUrl;
  final List<PromotionInfo> promotionInfo;
  final String? localGoodsId;
  final DiscountPrice? singleItemPrice;
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
      detailImage: json["detail_image"] == null
          ? []
          : List<String>.from(json["detail_image"]!.map((x) => x)),
      goodsName: json["goods_name"],
      goodsUrlName: json["goods_url_name"],
      catId: json["cat_id"],
      cateName: json["cate_name"],
      stock: json["stock"],
      storeCode: json["store_code"],
      businessModel: json["business_model"],
      mallCode: json["mall_code"],
      isOnSale: json["is_on_sale"],
      retailPrice: json["retailPrice"] == null || json["retailPrice"] is List
          ? null
          : DiscountPrice.fromJson(json["retailPrice"]),
      salePrice: json["salePrice"] == null || json["salePrice"] is List
          ? null
          : DiscountPrice.fromJson(json["salePrice"]),
      discountPrice:
          json["discountPrice"] == null || json["discountPrice"] is List
          ? null
          : DiscountPrice.fromJson(json["discountPrice"]),
      isInversion: json["isInversion"],
      retailDiscountPrice:
          json["retailDiscountPrice"] == null ||
              json["retailDiscountPrice"] is List
          ? null
          : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      retailDiscountPercent: json["retailDiscountPercent"],
      isNewCoupon: json["isNewCoupon"],
      isSrpInversion: json["isSrpInversion"],
      srpDiscount: json["srpDiscount"],
      srpDiscountPrice:
          json["srpDiscountPrice"] == null || json["srpDiscountPrice"] is List
          ? null
          : DiscountPrice.fromJson(json["srpDiscountPrice"]),
      unitDiscount: json["unit_discount"],
      originalDiscount: json["original_discount"],
      premiumFlagNew:
          json["premiumFlagNew"] == null || json["premiumFlagNew"] is List
          ? null
          : PremiumFlagNew.fromJson(json["premiumFlagNew"]),
      productInfoLabels:
          json["productInfoLabels"] == null || json["productInfoLabels"] is List
          ? null
          : ProductInfoLabels.fromJson(json["productInfoLabels"]),
      quickship: json["quickship"],
      couponPrices:
          json["coupon_prices"] == null || json["coupon_prices"] is! List
          ? []
          : List<CouponPrice>.from(
              json["coupon_prices"]!.map((x) => CouponPrice.fromJson(x)),
            ),
      videoUrl: json["video_url"],
      relatedColorNew:
          json["relatedColorNew"] == null || json["relatedColorNew"] is! List
          ? []
          : List<RelatedColorNew>.from(
              json["relatedColorNew"]!.map((x) => RelatedColorNew.fromJson(x)),
            ),
      isClearance: json["is_clearance"],
      productMaterial:
          json["productMaterial"] == null || json["productMaterial"] is List
          ? null
          : ProductMaterial.fromJson(json["productMaterial"]),
      isShowPlusSize: json["is_show_plus_size"],
      actTagFromCcc:
          json["actTagFromCcc"] == null || json["actTagFromCcc"] is List
          ? null
          : ActTagFromCcc.fromJson(json["actTagFromCcc"]),
      rankInfo: json["rankInfo"] == null || json["rankInfo"] is List
          ? null
          : ActTagFromCcc.fromJson(json["rankInfo"]),
      commentNumShow: json["comment_num_show"],
      commentRankAverage: json["comment_rank_average"],
      commentNum: json["comment_num"],
      percentOverallFit:
          json["percent_overall_fit"] == null ||
              json["percent_overall_fit"] is List
          ? null
          : PercentOverallFit.fromJson(json["percent_overall_fit"]),
      isSingleSku: json["is_single_sku"],
      itemSource: json["item_source"],
      ext: json["ext"] == null ? null : Ext.fromJson(json["ext"]),
      isShowAdditionalDiscount: json["isShowAdditionalDiscount"],
      usePositionInfo: json["usePositionInfo"],
      productUrl: json["productUrl"],
      promotionInfo: json["promotionInfo"] == null
          ? []
          : List<PromotionInfo>.from(
              json["promotionInfo"]!.map((x) => PromotionInfo.fromJson(x)),
            ),
      localGoodsId: json["local_goods_id"],
      singleItemPrice: json["singleItemPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["singleItemPrice"]),
      unit: json["unit"],
    );
  }
}

class ActTagFromCcc {
  ActTagFromCcc({
    required this.productDetailStyle,
    required this.productDetailCartStyle,
    required this.overviewCarStyle,
    required this.oneColumnStyle,
    required this.twoColumnStyle,
    required this.preferenceTagStyle,
    required this.msg,
  });

  final List<dynamic> productDetailStyle;
  final List<dynamic> productDetailCartStyle;
  final List<dynamic> overviewCarStyle;
  final dynamic oneColumnStyle;
  final ActTagFromCccTwoColumnStyle? twoColumnStyle;
  final dynamic preferenceTagStyle;
  final dynamic msg;

  factory ActTagFromCcc.fromJson(Map<String, dynamic> json) {
    return ActTagFromCcc(
      productDetailStyle: json["productDetailStyle"] == null
          ? []
          : List<dynamic>.from(json["productDetailStyle"]!.map((x) => x)),
      productDetailCartStyle: json["productDetailCartStyle"] == null
          ? []
          : List<dynamic>.from(json["productDetailCartStyle"]!.map((x) => x)),
      overviewCarStyle: json["overviewCarStyle"] == null
          ? []
          : List<dynamic>.from(json["overviewCarStyle"]!.map((x) => x)),
      oneColumnStyle: json["oneColumnStyle"],
      twoColumnStyle: json["twoColumnStyle"] == null
          ? null
          : ActTagFromCccTwoColumnStyle.fromJson(json["twoColumnStyle"]),
      preferenceTagStyle: json["preferenceTagStyle"],
      msg: json["msg"],
    );
  }
}

class ActTagFromCccTwoColumnStyle {
  ActTagFromCccTwoColumnStyle({
    required this.tagType,
    required this.subscriptType,
    required this.actionDataTagShow,
    required this.tagName,
    required this.tagColor,
    required this.bgColor,
    required this.icon,
    required this.tagId,
    required this.appTraceInfo,
    required this.rankTypeText,
    required this.composeIdText,
    required this.routeUrl,
    required this.carrierSubType,
    required this.carrierId,
    required this.materialValueKey,
    required this.title,
    required this.score,
    required this.cateId,
    required this.boardGenerateType,
    required this.carrierTypeName,
    required this.carrierSubTypeName,
    required this.carrierType,
    required this.srcIdentifier,
    required this.infoFlow,
    required this.strategy,
  });

  final dynamic tagType;
  final dynamic subscriptType;
  final dynamic actionDataTagShow;
  final String? tagName;
  final String? tagColor;
  final String? bgColor;
  final String? icon;
  final dynamic tagId;
  final String? appTraceInfo;
  final String? rankTypeText;
  final String? composeIdText;
  final String? routeUrl;
  final String? carrierSubType;
  final String? carrierId;
  final String? materialValueKey;
  final String? title;
  final int? score;
  final String? cateId;
  final String? boardGenerateType;
  final String? carrierTypeName;
  final String? carrierSubTypeName;
  final String? carrierType;
  final dynamic srcIdentifier;
  final dynamic infoFlow;
  final String? strategy;

  factory ActTagFromCccTwoColumnStyle.fromJson(Map<String, dynamic> json) {
    return ActTagFromCccTwoColumnStyle(
      tagType: json["tagType"],
      subscriptType: json["subscriptType"],
      actionDataTagShow: json["actionDataTagShow"],
      tagName: json["tagName"],
      tagColor: json["tagColor"],
      bgColor: json["bgColor"],
      icon: json["icon"],
      tagId: json["tagId"],
      appTraceInfo: json["appTraceInfo"],
      rankTypeText: json["rankTypeText"],
      composeIdText: json["composeIdText"],
      routeUrl: json["routeUrl"],
      carrierSubType: json["carrierSubType"],
      carrierId: json["carrierId"],
      materialValueKey: json["materialValueKey"],
      title: json["title"],
      score: json["score"],
      cateId: json["cateId"],
      boardGenerateType: json["boardGenerateType"],
      carrierTypeName: json["carrierTypeName"],
      carrierSubTypeName: json["carrierSubTypeName"],
      carrierType: json["carrierType"],
      srcIdentifier: json["srcIdentifier"],
      infoFlow: json["infoFlow"],
      strategy: json["strategy"],
    );
  }
}

class CouponPrice {
  CouponPrice({
    required this.afterCouponPrice,
    required this.couponCode,
    required this.endTime,
    required this.discountValue,
    required this.totalDiscountValue,
    required this.discountPercent,
    required this.isVipPromotion,
    required this.rule,
    required this.satisfied,
    required this.needPrice,
    required this.calculateOrder,
    required this.typeId,
    required this.retailCouponDiscount,
    required this.retailCouponDiscountPrice,
    required this.srpCouponDiscount,
    required this.srpCouponDiscountPrice,
    required this.maxDiscount,
  });

  final DiscountPrice? afterCouponPrice;
  final String? couponCode;
  final String? endTime;
  final DiscountPrice? discountValue;
  final DiscountPrice? totalDiscountValue;
  final String? discountPercent;
  final int? isVipPromotion;
  final CouponPriceRule? rule;
  final int? satisfied;
  final DiscountPrice? needPrice;
  final int? calculateOrder;
  final String? typeId;
  final String? retailCouponDiscount;
  final DiscountPrice? retailCouponDiscountPrice;
  final String? srpCouponDiscount;
  final DiscountPrice? srpCouponDiscountPrice;
  final DiscountPrice? maxDiscount;

  factory CouponPrice.fromJson(Map<String, dynamic> json) {
    return CouponPrice(
      afterCouponPrice: json["after_coupon_price"] == null
          ? null
          : DiscountPrice.fromJson(json["after_coupon_price"]),
      couponCode: json["coupon_code"],
      endTime: json["end_time"],
      discountValue: json["discount_value"] == null
          ? null
          : DiscountPrice.fromJson(json["discount_value"]),
      totalDiscountValue: json["total_discount_value"] == null
          ? null
          : DiscountPrice.fromJson(json["total_discount_value"]),
      discountPercent: json["discount_percent"],
      isVipPromotion: json["is_vip_promotion"],
      rule: json["rule"] == null
          ? null
          : CouponPriceRule.fromJson(json["rule"]),
      satisfied: json["satisfied"],
      needPrice: json["need_price"] == null
          ? null
          : DiscountPrice.fromJson(json["need_price"]),
      calculateOrder: json["calculate_order"],
      typeId: json["type_id"],
      retailCouponDiscount: json["retail_coupon_discount"],
      retailCouponDiscountPrice: json["retail_coupon_discount_price"] == null
          ? null
          : DiscountPrice.fromJson(json["retail_coupon_discount_price"]),
      srpCouponDiscount: json["srp_coupon_discount"],
      srpCouponDiscountPrice: json["srp_coupon_discount_price"] == null
          ? null
          : DiscountPrice.fromJson(json["srp_coupon_discount_price"]),
      maxDiscount: json["max_discount"] == null
          ? null
          : DiscountPrice.fromJson(json["max_discount"]),
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

class CouponPriceRule {
  CouponPriceRule({
    required this.id,
    required this.min,
    required this.times,
    required this.value,
    required this.valueAmount,
  });

  final int? id;
  final DiscountPrice? min;
  final int? times;
  final String? value;
  final DiscountPrice? valueAmount;

  factory CouponPriceRule.fromJson(Map<String, dynamic> json) {
    return CouponPriceRule(
      id: json["id"],
      min: json["min"] == null ? null : DiscountPrice.fromJson(json["min"]),
      times: json["times"],
      value: json["value"],
      valueAmount: json["value_amount"] == null
          ? null
          : DiscountPrice.fromJson(json["value_amount"]),
    );
  }
}

class Ext {
  Ext({required this.recMark});

  final String? recMark;

  factory Ext.fromJson(Map<String, dynamic> json) {
    return Ext(recMark: json["rec_mark"]);
  }
}

class PercentOverallFit {
  PercentOverallFit({
    required this.trueSize,
    required this.large,
    required this.small,
  });

  final String? trueSize;
  final String? large;
  final String? small;

  factory PercentOverallFit.fromJson(Map<String, dynamic> json) {
    return PercentOverallFit(
      trueSize: json["true_size"],
      large: json["large"],
      small: json["small"],
    );
  }
}

class PremiumFlagNew {
  PremiumFlagNew({
    required this.brandId,
    required this.productRecommendByGroup,
    required this.secondSeriesId,
    required this.brandSeriesType,
    required this.brandBadgeName,
    required this.brandLogoUrlLeft,
    required this.brandCode,
    required this.seriesBadgeName,
    required this.seriesId,
    required this.brandName,
    required this.seriesLogoUrlLeft,
    required this.seriesLogoUrlRight,
  });

  final String? brandId;
  final int? productRecommendByGroup;
  final String? secondSeriesId;
  final String? brandSeriesType;
  final String? brandBadgeName;
  final String? brandLogoUrlLeft;
  final String? brandCode;
  final String? seriesBadgeName;
  final String? seriesId;
  final String? brandName;
  final String? seriesLogoUrlLeft;
  final String? seriesLogoUrlRight;

  factory PremiumFlagNew.fromJson(Map<String, dynamic> json) {
    return PremiumFlagNew(
      brandId: json["brandId"],
      productRecommendByGroup: json["productRecommendByGroup"],
      secondSeriesId: json["secondSeriesId"],
      brandSeriesType: json["brandSeriesType"],
      brandBadgeName: json["brand_badge_name"],
      brandLogoUrlLeft: json["brand_logo_url_left"],
      brandCode: json["brand_code"],
      seriesBadgeName: json["series_badge_name"],
      seriesId: json["seriesId"],
      brandName: json["brandName"],
      seriesLogoUrlLeft: json["series_logo_url_left"],
      seriesLogoUrlRight: json["series_logo_url_right"],
    );
  }
}

class ProductInfoLabels {
  ProductInfoLabels({required this.quickShipLabel});

  final QuickShipLabel? quickShipLabel;

  factory ProductInfoLabels.fromJson(Map<String, dynamic> json) {
    return ProductInfoLabels(
      quickShipLabel: json["quickShipLabel"] == null
          ? null
          : QuickShipLabel.fromJson(json["quickShipLabel"]),
    );
  }
}

class QuickShipLabel {
  QuickShipLabel({
    required this.tagValNameLang,
    required this.tagTextColor,
    required this.tagBgColor,
    required this.tagType,
  });

  final String? tagValNameLang;
  final String? tagTextColor;
  final String? tagBgColor;
  final String? tagType;

  factory QuickShipLabel.fromJson(Map<String, dynamic> json) {
    return QuickShipLabel(
      tagValNameLang: json["tag_val_name_lang"],
      tagTextColor: json["tag_text_color"],
      tagBgColor: json["tag_bg_color"],
      tagType: json["tagType"],
    );
  }
}

class ProductMaterial {
  ProductMaterial({
    required this.pictureBelt,
    required this.upperRightPositionInfo,
    required this.lowerRightPositionInfo,
    required this.salesLabel,
    required this.showAddButtonLabel,
    required this.showAddButtonLabelStyle,
    required this.trendLabel,
    required this.v2ProductAttributeLabelList,
    required this.fullPriceUi,
    required this.upperLeftPositionInfo,
  });

  final PictureBelt? pictureBelt;
  final UpperTPositionInfo? upperRightPositionInfo;
  final LowerRightPositionInfo? lowerRightPositionInfo;
  final SalesLabel? salesLabel;
  final String? showAddButtonLabel;
  final String? showAddButtonLabelStyle;
  final ProductMaterialTrendLabel? trendLabel;
  final List<V2ProductAttributeLabelList> v2ProductAttributeLabelList;
  final FullPriceUi? fullPriceUi;
  final UpperTPositionInfo? upperLeftPositionInfo;

  factory ProductMaterial.fromJson(Map<String, dynamic> json) {
    return ProductMaterial(
      pictureBelt: json["pictureBelt"] == null || json["pictureBelt"] is List
          ? null
          : PictureBelt.fromJson(json["pictureBelt"]),
      upperRightPositionInfo:
          json["upperRightPositionInfo"] == null ||
              json["upperRightPositionInfo"] is List
          ? null
          : UpperTPositionInfo.fromJson(json["upperRightPositionInfo"]),
      lowerRightPositionInfo:
          json["lowerRightPositionInfo"] == null ||
              json["lowerRightPositionInfo"] is List
          ? null
          : LowerRightPositionInfo.fromJson(json["lowerRightPositionInfo"]),
      salesLabel: json["salesLabel"] == null || json["salesLabel"] is List
          ? null
          : SalesLabel.fromJson(json["salesLabel"]),
      showAddButtonLabel: json["showAddButtonLabel"],
      showAddButtonLabelStyle: json["showAddButtonLabelStyle"],
      trendLabel: json["trendLabel"] == null || json["trendLabel"] is List
          ? null
          : ProductMaterialTrendLabel.fromJson(json["trendLabel"]),
      v2ProductAttributeLabelList:
          json["v2ProductAttributeLabelList"] == null ||
              json["v2ProductAttributeLabelList"] is! List
          ? []
          : List<V2ProductAttributeLabelList>.from(
              json["v2ProductAttributeLabelList"]!.map(
                (x) => V2ProductAttributeLabelList.fromJson(x),
              ),
            ),
      fullPriceUi: json["fullPriceUI"] == null || json["fullPriceUI"] is List
          ? null
          : FullPriceUi.fromJson(json["fullPriceUI"]),
      upperLeftPositionInfo:
          json["upperLeftPositionInfo"] == null ||
              json["upperLeftPositionInfo"] is List
          ? null
          : UpperTPositionInfo.fromJson(json["upperLeftPositionInfo"]),
    );
  }
}

class FullPriceUi {
  FullPriceUi({
    required this.price,
    required this.priceShowStyle,
    required this.discountPercent,
    required this.discountPrice,
    required this.description,
    required this.color,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.bi,
    required this.endTime,
    required this.s3Price,
    required this.retailPrice,
    required this.recommendedRetailPrice,
    required this.couponPrice,
    required this.suggestedSalePrice,
    required this.retailPriceDescription,
    required this.style,
    required this.firstSalePrice,
  });

  final String? price;
  final String? priceShowStyle;
  final String? discountPercent;
  final String? discountPrice;
  final dynamic description;
  final String? color;
  final LeadingIcon? leadingIcon;
  final dynamic trailingIcon;
  final Bi? bi;
  final dynamic endTime;
  final dynamic s3Price;
  final dynamic retailPrice;
  final dynamic recommendedRetailPrice;
  final dynamic couponPrice;
  final dynamic suggestedSalePrice;
  final dynamic retailPriceDescription;
  final List<dynamic> style;
  final dynamic firstSalePrice;

  factory FullPriceUi.fromJson(Map<String, dynamic> json) {
    return FullPriceUi(
      price: json["price"],
      priceShowStyle: json["priceShowStyle"],
      discountPercent: json["discountPercent"],
      discountPrice: json["discountPrice"],
      description: json["description"],
      color: json["color"],
      leadingIcon: json["leadingIcon"] == null || json["leadingIcon"] is List
          ? null
          : LeadingIcon.fromJson(json["leadingIcon"]),
      trailingIcon: json["trailingIcon"],
      bi: json["bi"] == null || json["bi"] is List
          ? null
          : Bi.fromJson(json["bi"]),
      endTime: json["endTime"],
      s3Price: json["s3Price"],
      retailPrice: json["retailPrice"],
      recommendedRetailPrice: json["recommendedRetailPrice"],
      couponPrice: json["couponPrice"],
      suggestedSalePrice: json["suggestedSalePrice"],
      retailPriceDescription: json["retailPriceDescription"],
      style: json["style"] == null
          ? []
          : List<dynamic>.from(json["style"]!.map((x) => x)),
      firstSalePrice: json["firstSalePrice"],
    );
  }
}

class Bi {
  Bi({required this.pri, required this.isFlashSale, required this.otherMarks});

  final String? pri;
  final String? isFlashSale;
  final dynamic otherMarks;

  factory Bi.fromJson(Map<String, dynamic> json) {
    return Bi(
      pri: json["pri"],
      isFlashSale: json["isFlashSale"],
      otherMarks: json["otherMarks"],
    );
  }
}

class LeadingIcon {
  LeadingIcon({required this.type});

  final String? type;

  factory LeadingIcon.fromJson(Map<String, dynamic> json) {
    return LeadingIcon(type: json["type"]);
  }
}

class LowerRightPositionInfo {
  LowerRightPositionInfo({required this.twoColumnStyle});

  final LowerRightPositionInfoTwoColumnStyle? twoColumnStyle;

  factory LowerRightPositionInfo.fromJson(Map<String, dynamic> json) {
    return LowerRightPositionInfo(
      twoColumnStyle:
          json["twoColumnStyle"] == null || json["twoColumnStyle"] is List
          ? null
          : LowerRightPositionInfoTwoColumnStyle.fromJson(
              json["twoColumnStyle"],
            ),
    );
  }
}

class LowerRightPositionInfoTwoColumnStyle {
  LowerRightPositionInfoTwoColumnStyle({
    required this.contentType,
    required this.appTraceInfo,
  });

  final String? contentType;
  final String? appTraceInfo;

  factory LowerRightPositionInfoTwoColumnStyle.fromJson(
    Map<String, dynamic> json,
  ) {
    return LowerRightPositionInfoTwoColumnStyle(
      contentType: json["contentType"],
      appTraceInfo: json["appTraceInfo"],
    );
  }
}

class PictureBelt {
  PictureBelt({required this.oneColumnStyle, required this.twoColumnStyle});

  final dynamic oneColumnStyle;
  final dynamic twoColumnStyle;

  factory PictureBelt.fromJson(Map<String, dynamic> json) {
    return PictureBelt(
      oneColumnStyle: json["oneColumnStyle"],
      twoColumnStyle: json["twoColumnStyle"],
    );
  }
}

class SalesLabel {
  SalesLabel({
    required this.labelType,
    required this.contentType,
    required this.salesMultiLang,
    required this.labelLang,
    required this.icon,
    required this.fontColor,
    required this.backgroundColor,
    required this.saleNumShow,
    required this.appTraceInfo,
  });

  final dynamic labelType;
  final String? contentType;
  final dynamic salesMultiLang;
  final String? labelLang;
  final String? icon;
  final String? fontColor;
  final String? backgroundColor;
  final dynamic saleNumShow;
  final String? appTraceInfo;

  factory SalesLabel.fromJson(Map<String, dynamic> json) {
    return SalesLabel(
      labelType: json["labelType"],
      contentType: json["contentType"],
      salesMultiLang: json["salesMultiLang"],
      labelLang: json["labelLang"],
      icon: json["icon"],
      fontColor: json["fontColor"],
      backgroundColor: json["backgroundColor"],
      saleNumShow: json["saleNumShow"],
      appTraceInfo: json["appTraceInfo"],
    );
  }
}

class ProductMaterialTrendLabel {
  ProductMaterialTrendLabel({
    required this.trendWordCategory,
    required this.trendIpImg,
    required this.trendIpBigImg,
    required this.trendIpLang,
    required this.trendLabel,
    required this.routingUrl,
    required this.contentRoutingUrl,
    required this.appTraceInfo,
    required this.showPosition,
    required this.displayDesc,
    required this.trendWordId,
    required this.trendShopCode,
    required this.productSelectId,
    required this.productSelectUrlId,
    required this.trendType,
    required this.carrierType,
    required this.carrierTypeName,
    required this.contentCarrierId,
    required this.carrierSubTypeName,
    required this.sceneId,
    required this.carrierSubType,
    required this.trendStoreTabAbtValue,
    required this.fashionStoreName,
    required this.fashionStoreLogo,
  });

  final TrendWordCategory? trendWordCategory;
  final TrendIpImg? trendIpImg;
  final TrendIpImg? trendIpBigImg;
  final String? trendIpLang;
  final TrendLabelTrendLabel? trendLabel;
  final String? routingUrl;
  final String? contentRoutingUrl;
  final String? appTraceInfo;
  final String? showPosition;
  final String? displayDesc;
  final String? trendWordId;
  final String? trendShopCode;
  final String? productSelectId;
  final String? productSelectUrlId;
  final String? trendType;
  final String? carrierType;
  final String? carrierTypeName;
  final String? contentCarrierId;
  final String? carrierSubTypeName;
  final String? sceneId;
  final String? carrierSubType;
  final String? trendStoreTabAbtValue;
  final String? fashionStoreName;
  final String? fashionStoreLogo;

  factory ProductMaterialTrendLabel.fromJson(Map<String, dynamic> json) {
    return ProductMaterialTrendLabel(
      trendWordCategory:
          json["trendWordCategory"] == null || json["trendWordCategory"] is List
          ? null
          : TrendWordCategory.fromJson(json["trendWordCategory"]),
      trendIpImg: json["trendIpImg"] == null || json["trendIpImg"] is List
          ? null
          : TrendIpImg.fromJson(json["trendIpImg"]),
      trendIpBigImg:
          json["trendIpBigImg"] == null || json["trendIpBigImg"] is List
          ? null
          : TrendIpImg.fromJson(json["trendIpBigImg"]),
      trendIpLang: json["trendIpLang"],
      trendLabel: json["trendLabel"] == null || json["trendLabel"] is List
          ? null
          : TrendLabelTrendLabel.fromJson(json["trendLabel"]),
      routingUrl: json["routingUrl"],
      contentRoutingUrl: json["contentRoutingUrl"],
      appTraceInfo: json["appTraceInfo"],
      showPosition: json["showPosition"],
      displayDesc: json["displayDesc"],
      trendWordId: json["trendWordId"],
      trendShopCode: json["trendShopCode"],
      productSelectId: json["productSelectId"],
      productSelectUrlId: json["productSelectUrlId"],
      trendType: json["trendType"],
      carrierType: json["carrierType"],
      carrierTypeName: json["carrierTypeName"],
      contentCarrierId: json["contentCarrierId"],
      carrierSubTypeName: json["carrierSubTypeName"],
      sceneId: json["sceneId"],
      carrierSubType: json["carrierSubType"],
      trendStoreTabAbtValue: json["trendStoreTabAbtValue"],
      fashionStoreName: json["fashionStoreName"],
      fashionStoreLogo: json["fashionStoreLogo"],
    );
  }
}

class TrendIpImg {
  TrendIpImg({required this.imgUrl, required this.width, required this.height});

  final String? imgUrl;
  final String? width;
  final String? height;

  factory TrendIpImg.fromJson(Map<String, dynamic> json) {
    return TrendIpImg(
      imgUrl: json["imgUrl"],
      width: json["width"],
      height: json["height"],
    );
  }
}

class TrendLabelTrendLabel {
  TrendLabelTrendLabel({
    required this.labelName,
    required this.bgColor,
    required this.fontColor,
    required this.icon,
    required this.iconType,
  });

  final String? labelName;
  final String? bgColor;
  final String? fontColor;
  final String? icon;
  final String? iconType;

  factory TrendLabelTrendLabel.fromJson(Map<String, dynamic> json) {
    return TrendLabelTrendLabel(
      labelName: json["labelName"],
      bgColor: json["bgColor"],
      fontColor: json["fontColor"],
      icon: json["icon"],
      iconType: json["iconType"],
    );
  }
}

class TrendWordCategory {
  TrendWordCategory({required this.labelLang, required this.appTraceInfo});

  final String? labelLang;
  final String? appTraceInfo;

  factory TrendWordCategory.fromJson(Map<String, dynamic> json) {
    return TrendWordCategory(
      labelLang: json["labelLang"],
      appTraceInfo: json["appTraceInfo"],
    );
  }
}

class UpperTPositionInfo {
  UpperTPositionInfo({required this.twoColumnStyle});

  final UpperLeftPositionInfoTwoColumnStyle? twoColumnStyle;

  factory UpperTPositionInfo.fromJson(Map<String, dynamic> json) {
    return UpperTPositionInfo(
      twoColumnStyle:
          json["twoColumnStyle"] == null || json["twoColumnStyle"] is List
          ? null
          : UpperLeftPositionInfoTwoColumnStyle.fromJson(
              json["twoColumnStyle"],
            ),
    );
  }
}

class UpperLeftPositionInfoTwoColumnStyle {
  UpperLeftPositionInfoTwoColumnStyle({
    required this.contentType,
    required this.displayType,
    required this.image,
    required this.appTraceInfo,
  });

  final String? contentType;
  final String? displayType;
  final String? image;
  final String? appTraceInfo;

  factory UpperLeftPositionInfoTwoColumnStyle.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpperLeftPositionInfoTwoColumnStyle(
      contentType: json["contentType"],
      displayType: json["displayType"],
      image: json["image"],
      appTraceInfo: json["appTraceInfo"],
    );
  }
}

class V2ProductAttributeLabelList {
  V2ProductAttributeLabelList({
    required this.contentType,
    required this.tagId,
    required this.labelLang,
    required this.fontColor,
    required this.backgroundColor,
    required this.appTraceInfo,
    required this.icon,
  });

  final String? contentType;
  final String? tagId;
  final String? labelLang;
  final String? fontColor;
  final String? backgroundColor;
  final String? appTraceInfo;
  final String? icon;

  factory V2ProductAttributeLabelList.fromJson(Map<String, dynamic> json) {
    return V2ProductAttributeLabelList(
      contentType: json["contentType"],
      tagId: json["tagId"],
      labelLang: json["labelLang"],
      fontColor: json["fontColor"],
      backgroundColor: json["backgroundColor"],
      appTraceInfo: json["appTraceInfo"],
      icon: json["icon"],
    );
  }
}

class PromotionInfo {
  PromotionInfo({
    required this.typeId,
    required this.dsaEndTime,
    required this.startTimestamp,
    required this.id,
    required this.mallCode,
    required this.mallCodeList,
    required this.promotionInfoCategoryInfo,
    required this.everyBodyPriceType,
    required this.endTime,
    required this.isReturn,
    required this.endTimestamp,
    required this.isFullShop,
    required this.isDeletePromotion,
    required this.isAddBuy,
    required this.singleNum,
    required this.singleRemainNum,
    required this.saleNumScene,
    required this.buyLimitType,
    required this.languageKey,
    required this.aggregateMemberResult,
    required this.promotionActivityPriority,
    required this.promotionLogoType,
    required this.rules,
    required this.subject,
    required this.channelType,
    required this.categoryInfo,
    required this.poolList,
    required this.maxDiscountConvertByAppCurrency,
    required this.ruleType,
    required this.buyLimit,
    required this.scId,
    required this.isShowSaleDiscount,
    required this.isCountdown,
    required this.vcId,
    required this.discountValue,
    required this.isOver,
    required this.tips,
  });

  final String? typeId;
  final String? dsaEndTime;
  final String? startTimestamp;
  final String? id;
  final String? mallCode;
  final List<String> mallCodeList;
  final List<dynamic> promotionInfoCategoryInfo;
  final String? everyBodyPriceType;
  final DateTime? endTime;
  final String? isReturn;
  final String? endTimestamp;
  final String? isFullShop;
  final String? isDeletePromotion;
  final String? isAddBuy;
  final String? singleNum;
  final String? singleRemainNum;
  final String? saleNumScene;
  final String? buyLimitType;
  final String? languageKey;
  final AggregateMemberResult? aggregateMemberResult;
  final int? promotionActivityPriority;
  final String? promotionLogoType;
  final List<RuleElement> rules;
  final String? subject;
  final String? channelType;
  final List<dynamic> categoryInfo;
  final List<dynamic> poolList;
  final DiscountPrice? maxDiscountConvertByAppCurrency;
  final String? ruleType;
  final String? buyLimit;
  final String? scId;
  final String? isShowSaleDiscount;
  final String? isCountdown;
  final String? vcId;
  final String? discountValue;
  final String? isOver;
  final Tips? tips;

  factory PromotionInfo.fromJson(Map<String, dynamic> json) {
    return PromotionInfo(
      typeId: json["typeId"],
      dsaEndTime: json["dsaEndTime"],
      startTimestamp: json["startTimestamp"],
      id: json["id"],
      mallCode: json["mall_code"],
      mallCodeList: json["mall_code_list"] == null
          ? []
          : List<String>.from(json["mall_code_list"]!.map((x) => x)),
      promotionInfoCategoryInfo: json["category_info"] == null
          ? []
          : List<dynamic>.from(json["category_info"]!.map((x) => x)),
      everyBodyPriceType: json["every_body_price_type"],
      endTime: DateTime.tryParse(json["endTime"] ?? ""),
      isReturn: json["isReturn"],
      endTimestamp: json["endTimestamp"],
      isFullShop: json["isFullShop"],
      isDeletePromotion: json["isDeletePromotion"],
      isAddBuy: json["isAddBuy"],
      singleNum: json["singleNum"],
      singleRemainNum: json["singleRemainNum"],
      saleNumScene: json["saleNumScene"],
      buyLimitType: json["buyLimitType"],
      languageKey: json["language_key"],
      aggregateMemberResult:
          json["aggregateMemberResult"] == null ||
              json["aggregateMemberResult"] is List
          ? null
          : AggregateMemberResult.fromJson(json["aggregateMemberResult"]),
      promotionActivityPriority: json["promotionActivityPriority"],
      promotionLogoType: json["promotion_logo_type"],
      rules: json["rules"] == null
          ? []
          : List<RuleElement>.from(
              json["rules"]!.map((x) => RuleElement.fromJson(x)),
            ),
      subject: json["subject"],
      channelType: json["channelType"],
      categoryInfo: json["categoryInfo"] == null
          ? []
          : List<dynamic>.from(json["categoryInfo"]!.map((x) => x)),
      poolList: json["pool_list"] == null
          ? []
          : List<dynamic>.from(json["pool_list"]!.map((x) => x)),
      maxDiscountConvertByAppCurrency:
          json["max_discount_convert_by_app_currency"] == null
          ? null
          : DiscountPrice.fromJson(
              json["max_discount_convert_by_app_currency"],
            ),
      ruleType: json["ruleType"],
      buyLimit: json["buyLimit"],
      scId: json["scId"],
      isShowSaleDiscount: json["isShowSaleDiscount"],
      isCountdown: json["isCountdown"],
      vcId: json["vcId"],
      discountValue: json["discountValue"],
      isOver: json["isOver"],
      tips: json["tips"] == null || json["tips"] is List
          ? null
          : Tips.fromJson(json["tips"]),
    );
  }
}

class AggregateMemberResult {
  AggregateMemberResult({required this.json});
  final Map<String, dynamic> json;

  factory AggregateMemberResult.fromJson(Map<String, dynamic> json) {
    return AggregateMemberResult(json: json);
  }
}

class RuleElement {
  RuleElement({
    required this.type,
    required this.value,
    required this.discount,
    required this.valueAmount,
    required this.maxDiscount,
    required this.maxDiscountAmount,
    required this.deliveryId,
  });

  final int? type;
  final int? value;
  final Discount? discount;
  final DiscountPrice? valueAmount;
  final int? maxDiscount;
  final DiscountPrice? maxDiscountAmount;
  final dynamic deliveryId;

  factory RuleElement.fromJson(Map<String, dynamic> json) {
    return RuleElement(
      type: json["type"],
      value: json["value"],
      discount: json["discount"] == null || json["discount"] is List
          ? null
          : Discount.fromJson(json["discount"]),
      valueAmount: json["value_amount"] == null || json["value_amount"] is List
          ? null
          : DiscountPrice.fromJson(json["value_amount"]),
      maxDiscount: json["max_discount"],
      maxDiscountAmount:
          json["max_discount_amount"] == null ||
              json["max_discount_amount"] is List
          ? null
          : DiscountPrice.fromJson(json["max_discount_amount"]),
      deliveryId: json["delivery_id"],
    );
  }
}

class Discount {
  Discount({
    required this.type,
    required this.value,
    required this.enjoyGoodsNum,
    required this.valueAmount,
    required this.giftCoupons,
  });

  final int? type;
  final double? value;
  final int? enjoyGoodsNum;
  final DiscountPrice? valueAmount;
  final List<dynamic> giftCoupons;

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      type: (json["type"] is int)
          ? json["type"]
          : (json["type"] as num?)?.toInt(),
      value: (json["value"] as num?)?.toDouble(),
      enjoyGoodsNum: (json["enjoy_goods_num"] is int)
          ? json["enjoy_goods_num"]
          : (json["enjoy_goods_num"] as num?)?.toInt(),
      valueAmount: json["value_amount"] == null || json["value_amount"] is List
          ? null
          : DiscountPrice.fromJson(json["value_amount"]),
      giftCoupons: json["gift_coupons"] == null
          ? []
          : List<dynamic>.from(json["gift_coupons"].map((x) => x)),
    );
  }
}

class Tips {
  Tips({required this.text});

  final String? text;

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(text: json["text"]);
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
