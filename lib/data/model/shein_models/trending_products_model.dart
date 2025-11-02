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
    // required this.productSalesLabel,
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
    // required this.discountPrice,
    required this.isInversion,
    // required this.retailDiscountPrice,
    required this.retailDiscountPercent,
    required this.isNewCoupon,
    required this.isSrpInversion,
    required this.srpDiscount,
    // required this.srpDiscountPrice,
    required this.unitDiscount,
    required this.originalDiscount,
    // required this.promotionInfo,
    required this.premiumFlagNew,
    // required this.productInfoLabels,
    required this.quickship,
    required this.couponPrices,
    // required this.spuImages,
    required this.videoUrl,
    required this.relatedColorNew,
    required this.isClearance,
    // required this.productMaterial,
    required this.isShowPlusSize,
    // required this.actTagFromCcc,
    // required this.rankInfo,
    required this.commentNumShow,
    required this.commentRankAverage,
    required this.commentNum,
    // required this.percentOverallFit,
    required this.isSingleSku,
    required this.itemSource,
    // required this.ext,
    required this.isShowAdditionalDiscount,
    required this.usePositionInfo,
    required this.productUrl,
    required this.detailImage,
    required this.localGoodsId,
    // required this.singleItemPrice,
    required this.unit,
  });

  final String? goodsColorImage;
  final String? fromSkuCode;
  final String? newProductPriceStyleShow;
  final String? newProductPriceStyleSymbol;
  final List<String> parentIds;
  final String? reorder;
  // final ProductSalesLabel? productSalesLabel;
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
  // final DiscountPrice? discountPrice;
  final String? isInversion;
  // final DiscountPrice? retailDiscountPrice;
  final String? retailDiscountPercent;
  final String? isNewCoupon;
  final String? isSrpInversion;
  final String? srpDiscount;
  // final DiscountPrice? srpDiscountPrice;
  final String? unitDiscount;
  final String? originalDiscount;
  // final List<PromotionInfo> promotionInfo;
  final PremiumFlagNew? premiumFlagNew;
  // final ProductInfoLabels? productInfoLabels;
  final String? quickship;
  final List<dynamic> couponPrices;
  // final SpuImages? spuImages;
  final String? videoUrl;
  final List<RelatedColorNew> relatedColorNew;
  final String? isClearance;
  // final ProductMaterial? productMaterial;
  final String? isShowPlusSize;
  // final ActTagFromCcc? actTagFromCcc;
  // final ActTagFromCcc? rankInfo;
  final String? commentNumShow;
  final String? commentRankAverage;
  final int? commentNum;
  // final PercentOverallFit? percentOverallFit;
  final String? isSingleSku;
  final String? itemSource;
  // final Ext? ext;
  final String? isShowAdditionalDiscount;
  final String? usePositionInfo;
  final String? productUrl;
  final List<String> detailImage;
  final String? localGoodsId;
  // final DiscountPrice? singleItemPrice;
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
      // productSalesLabel: json["productSalesLabel"] == null
      //     ? null
      //     : ProductSalesLabel.fromJson(json["productSalesLabel"]),
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
      // discountPrice: json["discountPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["discountPrice"]),
      isInversion: json["isInversion"],
      // retailDiscountPrice: json["retailDiscountPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      retailDiscountPercent: json["retailDiscountPercent"],
      isNewCoupon: json["isNewCoupon"],
      isSrpInversion: json["isSrpInversion"],
      srpDiscount: json["srpDiscount"],
      // srpDiscountPrice: json["srpDiscountPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["srpDiscountPrice"]),
      unitDiscount: json["unit_discount"],
      originalDiscount: json["original_discount"],

      // promotionInfo: (() {
      //   final raw = json["promotionInfo"];
      //   if (raw == null) return <PromotionInfo>[];

      //   // نجمع كل الـ maps في قائمة واحدة بغض النظر عن العمق الأولي
      //   final List<Map<String, dynamic>> maps = [];

      //   if (raw is Map<String, dynamic>) {
      //     maps.add(raw);
      //   } else if (raw is List) {
      //     for (final item in raw) {
      //       if (item is Map<String, dynamic>) {
      //         maps.add(item);
      //       } else if (item is List) {
      //         for (final inner in item) {
      //           if (inner is Map<String, dynamic>) maps.add(inner);
      //         }
      //       }
      //       // لو العنصر نوعه String او غيره -> نتجاهله
      //     }
      //   }

      //   return maps.map((m) => PromotionInfo.fromJson(m)).toList();
      // })(),
      premiumFlagNew: json["premiumFlagNew"] == null
          ? null
          : PremiumFlagNew.fromJson(json["premiumFlagNew"]),

      // productInfoLabels: json["productInfoLabels"] == null
      //     ? null
      //     : (json["productInfoLabels"] is List
      //           ? null // أو خليه [] حسب تصميمك
      //           : ProductInfoLabels.fromJson(json["productInfoLabels"])),
      quickship: json["quickship"],
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      // spuImages: json["spu_images"] == null
      //     ? null
      //     : SpuImages.fromJson(json["spu_images"]),
      videoUrl: json["video_url"],
      relatedColorNew: json["relatedColorNew"] == null
          ? []
          : List<RelatedColorNew>.from(
              json["relatedColorNew"]!.map((x) => RelatedColorNew.fromJson(x)),
            ),
      isClearance: json["is_clearance"],
      // productMaterial: json["productMaterial"] == null
      //     ? null
      //     : ProductMaterial.fromJson(json["productMaterial"]),
      isShowPlusSize: json["is_show_plus_size"],
      // actTagFromCcc: json["actTagFromCcc"] == null
      //     ? null
      //     : ActTagFromCcc.fromJson(json["actTagFromCcc"]),
      // rankInfo: json["rankInfo"] == null
      //     ? null
      //     : ActTagFromCcc.fromJson(json["rankInfo"]),
      commentNumShow: json["comment_num_show"],
      commentRankAverage: json["comment_rank_average"],
      commentNum: json["comment_num"],
      // percentOverallFit: json["percent_overall_fit"] == null
      //     ? null
      //     : PercentOverallFit.fromJson(json["percent_overall_fit"]),
      isSingleSku: json["is_single_sku"],
      itemSource: json["item_source"],
      // ext: json["ext"] == null ? null : Ext.fromJson(json["ext"]),
      isShowAdditionalDiscount: json["isShowAdditionalDiscount"],
      usePositionInfo: json["usePositionInfo"],
      productUrl: json["productUrl"],
      detailImage: json["detail_image"] == null
          ? []
          : List<String>.from(json["detail_image"]!.map((x) => x)),
      localGoodsId: json["local_goods_id"],
      // singleItemPrice: json["singleItemPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["singleItemPrice"]),
      unit: json["unit"],
    );
  }
}

// class ActTagFromCcc {
//   ActTagFromCcc({
//     required this.productDetailStyle,
//     required this.productDetailCartStyle,
//     required this.overviewCarStyle,
//     required this.oneColumnStyle,
//     required this.twoColumnStyle,
//     required this.preferenceTagStyle,
//     required this.msg,
//   });

//   final List<dynamic> productDetailStyle;
//   final List<dynamic> productDetailCartStyle;
//   final List<dynamic> overviewCarStyle;
//   final dynamic oneColumnStyle;
//   final ActTagFromCccTwoColumnStyle? twoColumnStyle;
//   final dynamic preferenceTagStyle;
//   final dynamic msg;

//   factory ActTagFromCcc.fromJson(Map<String, dynamic> json) {
//     return ActTagFromCcc(
//       productDetailStyle: json["productDetailStyle"] == null
//           ? []
//           : List<dynamic>.from(json["productDetailStyle"]!.map((x) => x)),
//       productDetailCartStyle: json["productDetailCartStyle"] == null
//           ? []
//           : List<dynamic>.from(json["productDetailCartStyle"]!.map((x) => x)),
//       overviewCarStyle: json["overviewCarStyle"] == null
//           ? []
//           : List<dynamic>.from(json["overviewCarStyle"]!.map((x) => x)),
//       oneColumnStyle: json["oneColumnStyle"],
//       twoColumnStyle: json["twoColumnStyle"] == null
//           ? null
//           : ActTagFromCccTwoColumnStyle.fromJson(json["twoColumnStyle"]),
//       preferenceTagStyle: json["preferenceTagStyle"],
//       msg: json["msg"],
//     );
//   }
// }

// class ActTagFromCccTwoColumnStyle {
//   ActTagFromCccTwoColumnStyle({
//     required this.tagType,
//     required this.subscriptType,
//     required this.actionDataTagShow,
//     required this.tagName,
//     required this.tagColor,
//     required this.bgColor,
//     required this.icon,
//     required this.tagId,
//     required this.appTraceInfo,
//     required this.rankTypeText,
//     required this.composeIdText,
//     required this.routeUrl,
//     required this.carrierSubType,
//     required this.carrierId,
//     required this.materialValueKey,
//     required this.title,
//     required this.score,
//     required this.cateId,
//     required this.boardGenerateType,
//     required this.carrierTypeName,
//     required this.carrierSubTypeName,
//     required this.carrierType,
//     required this.srcIdentifier,
//     required this.infoFlow,
//     required this.strategy,
//   });

//   final dynamic tagType;
//   final dynamic subscriptType;
//   final dynamic actionDataTagShow;
//   final String? tagName;
//   final String? tagColor;
//   final String? bgColor;
//   final String? icon;
//   final dynamic tagId;
//   final String? appTraceInfo;
//   final String? rankTypeText;
//   final String? composeIdText;
//   final String? routeUrl;
//   final String? carrierSubType;
//   final String? carrierId;
//   final String? materialValueKey;
//   final String? title;
//   final int? score;
//   final String? cateId;
//   final String? boardGenerateType;
//   final String? carrierTypeName;
//   final String? carrierSubTypeName;
//   final String? carrierType;
//   final dynamic srcIdentifier;
//   final dynamic infoFlow;
//   final String? strategy;

//   factory ActTagFromCccTwoColumnStyle.fromJson(Map<String, dynamic> json) {
//     return ActTagFromCccTwoColumnStyle(
//       tagType: json["tagType"],
//       subscriptType: json["subscriptType"],
//       actionDataTagShow: json["actionDataTagShow"],
//       tagName: json["tagName"],
//       tagColor: json["tagColor"],
//       bgColor: json["bgColor"],
//       icon: json["icon"],
//       tagId: json["tagId"],
//       appTraceInfo: json["appTraceInfo"],
//       rankTypeText: json["rankTypeText"],
//       composeIdText: json["composeIdText"],
//       routeUrl: json["routeUrl"],
//       carrierSubType: json["carrierSubType"],
//       carrierId: json["carrierId"],
//       materialValueKey: json["materialValueKey"],
//       title: json["title"],
//       score: json["score"],
//       cateId: json["cateId"],
//       boardGenerateType: json["boardGenerateType"],
//       carrierTypeName: json["carrierTypeName"],
//       carrierSubTypeName: json["carrierSubTypeName"],
//       carrierType: json["carrierType"],
//       srcIdentifier: json["srcIdentifier"],
//       infoFlow: json["infoFlow"],
//       strategy: json["strategy"],
//     );
//   }
// }

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

// class Ext {
//   Ext({required this.recMark});

//   final String? recMark;

//   factory Ext.fromJson(Map<String, dynamic> json) {
//     return Ext(recMark: json["rec_mark"]);
//   }
// }

// class PercentOverallFit {
//   PercentOverallFit({
//     required this.trueSize,
//     required this.large,
//     required this.small,
//   });

//   final String? trueSize;
//   final String? large;
//   final String? small;

//   factory PercentOverallFit.fromJson(Map<String, dynamic> json) {
//     return PercentOverallFit(
//       trueSize: json["true_size"],
//       large: json["large"],
//       small: json["small"],
//     );
//   }
// }

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

// class ProductInfoLabels {
//   ProductInfoLabels({required this.quickShipLabel});

//   final QuickShipLabel? quickShipLabel;

//   factory ProductInfoLabels.fromJson(Map<String, dynamic> json) {
//     return ProductInfoLabels(
//       quickShipLabel: json["quickShipLabel"] == null
//           ? null
//           : QuickShipLabel.fromJson(json["quickShipLabel"]),
//     );
//   }
// }

// class QuickShipLabel {
//   QuickShipLabel({
//     required this.tagValNameLang,
//     required this.tagTextColor,
//     required this.tagBgColor,
//     required this.tagType,
//   });

//   final String? tagValNameLang;
//   final String? tagTextColor;
//   final String? tagBgColor;
//   final String? tagType;

//   factory QuickShipLabel.fromJson(Map<String, dynamic> json) {
//     return QuickShipLabel(
//       tagValNameLang: json["tag_val_name_lang"],
//       tagTextColor: json["tag_text_color"],
//       tagBgColor: json["tag_bg_color"],
//       tagType: json["tagType"],
//     );
//   }
// }

// class ProductMaterial {
//   ProductMaterial({
//     // required this.pictureBelt,
//     // required this.lowerRightPositionInfo,
//     // required this.salesLabel,
//     required this.showAddButtonLabel,
//     required this.showAddButtonLabelStyle,
//     // required this.trendLabel,
//     // required this.v2ProductAttributeLabelList,
//     // required this.fullPriceUi,
//     // required this.upperRightPositionInfo,
//     // required this.priceCountdownInfo,
//     // required this.upperLeftPositionInfo,
//   });

//   // final PictureBelt? pictureBelt;
//   // final LowerRightPositionInfo? lowerRightPositionInfo;
//   // final SalesLabel? salesLabel;
//   final String? showAddButtonLabel;
//   final String? showAddButtonLabelStyle;
//   // final ProductMaterialTrendLabel? trendLabel;
//   // final List<V2ProductAttributeLabelList> v2ProductAttributeLabelList;
//   // final FullPriceUi? fullPriceUi;
//   // final UpperTPositionInfo? upperRightPositionInfo;
//   // final PriceCountdownInfo? priceCountdownInfo;
//   // final UpperTPositionInfo? upperLeftPositionInfo;

//   factory ProductMaterial.fromJson(Map<String, dynamic> json) {
//     return ProductMaterial(
//       // pictureBelt: json["pictureBelt"] == null
//       //     ? null
//       //     : PictureBelt.fromJson(json["pictureBelt"]),
//       // lowerRightPositionInfo: json["lowerRightPositionInfo"] == null
//       //     ? null
//       //     : LowerRightPositionInfo.fromJson(json["lowerRightPositionInfo"]),
//       // salesLabel: json["salesLabel"] == null
//       //     ? null
//       //     : SalesLabel.fromJson(json["salesLabel"]),
//       showAddButtonLabel: json["showAddButtonLabel"],
//       showAddButtonLabelStyle: json["showAddButtonLabelStyle"],
//       // trendLabel: json["trendLabel"] == null
//       //     ? null
//       //     : ProductMaterialTrendLabel.fromJson(json["trendLabel"]),
//       // v2ProductAttributeLabelList: json["v2ProductAttributeLabelList"] == null
//       //     ? []
//       //     : List<V2ProductAttributeLabelList>.from(
//       //         json["v2ProductAttributeLabelList"]!.map(
//       //           (x) => V2ProductAttributeLabelList.fromJson(x),
//       //         ),
//       //       ),
//       // fullPriceUi: json["fullPriceUI"] == null
//       //     ? null
//       //     : FullPriceUi.fromJson(json["fullPriceUI"]),
//       // upperRightPositionInfo: json["upperRightPositionInfo"] == null
//       //     ? null
//       //     : UpperTPositionInfo.fromJson(json["upperRightPositionInfo"]),
//       // priceCountdownInfo: json["priceCountdownInfo"] == null
//       //     ? null
//       //     : PriceCountdownInfo.fromJson(json["priceCountdownInfo"]),
//       // upperLeftPositionInfo: json["upperLeftPositionInfo"] == null
//       //     ? null
//       //     : UpperTPositionInfo.fromJson(json["upperLeftPositionInfo"]),
//     );
//   }
// }

// class FullPriceUi {
//   FullPriceUi({
//     required this.price,
//     required this.priceShowStyle,
//     required this.discountPercent,
//     required this.discountPrice,
//     required this.description,
//     required this.color,
//     required this.leadingIcon,
//     required this.trailingIcon,
//     required this.bi,
//     required this.endTime,
//     required this.s3Price,
//     required this.retailPrice,
//     required this.recommendedRetailPrice,
//     required this.couponPrice,
//     required this.suggestedSalePrice,
//     required this.retailPriceDescription,
//     required this.style,
//     required this.firstSalePrice,
//   });

//   final String? price;
//   final String? priceShowStyle;
//   final String? discountPercent;
//   final String? discountPrice;
//   final dynamic description;
//   final String? color;
//   final LeadingIcon? leadingIcon;
//   final dynamic trailingIcon;
//   final Bi? bi;
//   final dynamic endTime;
//   final dynamic s3Price;
//   final dynamic retailPrice;
//   final dynamic recommendedRetailPrice;
//   final dynamic couponPrice;
//   final dynamic suggestedSalePrice;
//   final dynamic retailPriceDescription;
//   final List<dynamic> style;
//   final dynamic firstSalePrice;

//   factory FullPriceUi.fromJson(Map<String, dynamic> json) {
//     return FullPriceUi(
//       price: json["price"],
//       priceShowStyle: json["priceShowStyle"],
//       discountPercent: json["discountPercent"],
//       discountPrice: json["discountPrice"],
//       description: json["description"],
//       color: json["color"],
//       leadingIcon: json["leadingIcon"] == null
//           ? null
//           : LeadingIcon.fromJson(json["leadingIcon"]),
//       trailingIcon: json["trailingIcon"],
//       bi: json["bi"] == null ? null : Bi.fromJson(json["bi"]),
//       endTime: json["endTime"],
//       s3Price: json["s3Price"],
//       retailPrice: json["retailPrice"],
//       recommendedRetailPrice: json["recommendedRetailPrice"],
//       couponPrice: json["couponPrice"],
//       suggestedSalePrice: json["suggestedSalePrice"],
//       retailPriceDescription: json["retailPriceDescription"],
//       style: json["style"] == null
//           ? []
//           : List<dynamic>.from(json["style"]!.map((x) => x)),
//       firstSalePrice: json["firstSalePrice"],
//     );
//   }
// }

// class Bi {
//   Bi({required this.pri, required this.isFlashSale, required this.otherMarks});

//   final String? pri;
//   final String? isFlashSale;
//   final String? otherMarks;

//   factory Bi.fromJson(Map<String, dynamic> json) {
//     return Bi(
//       pri: json["pri"],
//       isFlashSale: json["isFlashSale"],
//       otherMarks: json["otherMarks"],
//     );
//   }
// }

// class LeadingIcon {
//   LeadingIcon({required this.type});

//   final String? type;

//   factory LeadingIcon.fromJson(Map<String, dynamic> json) {
//     return LeadingIcon(type: json["type"]);
//   }
// }

// class LowerRightPositionInfo {
//   LowerRightPositionInfo({required this.twoColumnStyle});

//   final LowerRightPositionInfoTwoColumnStyle? twoColumnStyle;

//   factory LowerRightPositionInfo.fromJson(Map<String, dynamic> json) {
//     return LowerRightPositionInfo(
//       twoColumnStyle: json["twoColumnStyle"] == null
//           ? null
//           : LowerRightPositionInfoTwoColumnStyle.fromJson(
//               json["twoColumnStyle"],
//             ),
//     );
//   }
// }

// class LowerRightPositionInfoTwoColumnStyle {
//   LowerRightPositionInfoTwoColumnStyle({
//     required this.contentType,
//     required this.appTraceInfo,
//   });

//   final String? contentType;
//   final String? appTraceInfo;

//   factory LowerRightPositionInfoTwoColumnStyle.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return LowerRightPositionInfoTwoColumnStyle(
//       contentType: json["contentType"],
//       appTraceInfo: json["appTraceInfo"],
//     );
//   }
// }

// class PictureBelt {
//   PictureBelt({required this.oneColumnStyle, required this.twoColumnStyle});

//   final dynamic oneColumnStyle;
//   final dynamic twoColumnStyle;

//   factory PictureBelt.fromJson(Map<String, dynamic> json) {
//     return PictureBelt(
//       oneColumnStyle: json["oneColumnStyle"],
//       twoColumnStyle: json["twoColumnStyle"],
//     );
//   }
// }

// class PriceCountdownInfo {
//   PriceCountdownInfo({
//     required this.endTime,
//     required this.style,
//     required this.appTraceInfo,
//   });

//   final String? endTime;
//   final String? style;
//   final String? appTraceInfo;

//   factory PriceCountdownInfo.fromJson(Map<String, dynamic> json) {
//     return PriceCountdownInfo(
//       endTime: json["endTime"],
//       style: json["style"],
//       appTraceInfo: json["appTraceInfo"],
//     );
//   }
// }

// class SalesLabel {
//   SalesLabel({
//     required this.labelType,
//     required this.contentType,
//     required this.salesMultiLang,
//     required this.labelLang,
//     required this.icon,
//     required this.fontColor,
//     required this.backgroundColor,
//     required this.saleNumShow,
//     required this.appTraceInfo,
//   });

//   final dynamic labelType;
//   final String? contentType;
//   final dynamic salesMultiLang;
//   final String? labelLang;
//   final String? icon;
//   final String? fontColor;
//   final String? backgroundColor;
//   final dynamic saleNumShow;
//   final String? appTraceInfo;

//   factory SalesLabel.fromJson(Map<String, dynamic> json) {
//     return SalesLabel(
//       labelType: json["labelType"],
//       contentType: json["contentType"],
//       salesMultiLang: json["salesMultiLang"],
//       labelLang: json["labelLang"],
//       icon: json["icon"],
//       fontColor: json["fontColor"],
//       backgroundColor: json["backgroundColor"],
//       saleNumShow: json["saleNumShow"],
//       appTraceInfo: json["appTraceInfo"],
//     );
//   }
// }

// class ProductMaterialTrendLabel {
//   ProductMaterialTrendLabel({
//     required this.trendIpImg,
//     required this.trendIpBigImg,
//     required this.trendIpLang,
//     // required this.trendLabel,
//     required this.routingUrl,
//     required this.contentRoutingUrl,
//     required this.appTraceInfo,
//     required this.showPosition,
//     required this.displayDesc,
//     required this.trendWordId,
//     required this.trendShopCode,
//     required this.productSelectId,
//     required this.productSelectUrlId,
//     required this.trendType,
//     required this.carrierType,
//     required this.carrierTypeName,
//     required this.contentCarrierId,
//     required this.carrierSubTypeName,
//     required this.sceneId,
//     required this.carrierSubType,
//     required this.trendStoreTabAbtValue,
//     required this.fashionStoreName,
//     required this.fashionStoreLogo,
//     // required this.trendWordCategory,
//   });

//   final TrendIpImg? trendIpImg;
//   final TrendIpImg? trendIpBigImg;
//   final String? trendIpLang;
//   // final TrendLabelTrendLabel? trendLabel;
//   final String? routingUrl;
//   final String? contentRoutingUrl;
//   final String? appTraceInfo;
//   final String? showPosition;
//   final String? displayDesc;
//   final String? trendWordId;
//   final String? trendShopCode;
//   final String? productSelectId;
//   final String? productSelectUrlId;
//   final String? trendType;
//   final String? carrierType;
//   final String? carrierTypeName;
//   final String? contentCarrierId;
//   final String? carrierSubTypeName;
//   final String? sceneId;
//   final String? carrierSubType;
//   final String? trendStoreTabAbtValue;
//   final String? fashionStoreName;
//   final String? fashionStoreLogo;
//   // final TrendWordCategory? trendWordCategory;

//   factory ProductMaterialTrendLabel.fromJson(Map<String, dynamic> json) {
//     return ProductMaterialTrendLabel(
//       trendIpImg: json["trendIpImg"] == null
//           ? null
//           : TrendIpImg.fromJson(json["trendIpImg"]),
//       trendIpBigImg: json["trendIpBigImg"] == null
//           ? null
//           : TrendIpImg.fromJson(json["trendIpBigImg"]),
//       trendIpLang: json["trendIpLang"],
//       // trendLabel: json["trendLabel"] == null
//       //     ? null
//       //     : TrendLabelTrendLabel.fromJson(json["trendLabel"]),
//       routingUrl: json["routingUrl"],
//       contentRoutingUrl: json["contentRoutingUrl"],
//       appTraceInfo: json["appTraceInfo"],
//       showPosition: json["showPosition"],
//       displayDesc: json["displayDesc"],
//       trendWordId: json["trendWordId"],
//       trendShopCode: json["trendShopCode"],
//       productSelectId: json["productSelectId"],
//       productSelectUrlId: json["productSelectUrlId"],
//       trendType: json["trendType"],
//       carrierType: json["carrierType"],
//       carrierTypeName: json["carrierTypeName"],
//       contentCarrierId: json["contentCarrierId"],
//       carrierSubTypeName: json["carrierSubTypeName"],
//       sceneId: json["sceneId"],
//       carrierSubType: json["carrierSubType"],
//       trendStoreTabAbtValue: json["trendStoreTabAbtValue"],
//       fashionStoreName: json["fashionStoreName"],
//       fashionStoreLogo: json["fashionStoreLogo"],
//       // trendWordCategory: json["trendWordCategory"] == null
//       //     ? null
//       //     : TrendWordCategory.fromJson(json["trendWordCategory"]),
//     );
//   }
// }

// class TrendIpImg {
//   TrendIpImg({required this.imgUrl, required this.width, required this.height});

//   final String? imgUrl;
//   final String? width;
//   final String? height;

//   factory TrendIpImg.fromJson(Map<String, dynamic> json) {
//     return TrendIpImg(
//       imgUrl: json["imgUrl"],
//       width: json["width"],
//       height: json["height"],
//     );
//   }
// }

// class TrendLabelTrendLabel {
//   TrendLabelTrendLabel({
//     required this.labelName,
//     required this.bgColor,
//     required this.fontColor,
//     required this.icon,
//     required this.iconType,
//   });

//   final String? labelName;
//   final String? bgColor;
//   final String? fontColor;
//   final String? icon;
//   final String? iconType;

//   factory TrendLabelTrendLabel.fromJson(Map<String, dynamic> json) {
//     return TrendLabelTrendLabel(
//       labelName: json["labelName"],
//       bgColor: json["bgColor"],
//       fontColor: json["fontColor"],
//       icon: json["icon"],
//       iconType: json["iconType"],
//     );
//   }
// }

// class TrendWordCategory {
//   TrendWordCategory({required this.labelLang, required this.appTraceInfo});

//   final String? labelLang;
//   final String? appTraceInfo;

//   factory TrendWordCategory.fromJson(Map<String, dynamic> json) {
//     return TrendWordCategory(
//       labelLang: json["labelLang"],
//       appTraceInfo: json["appTraceInfo"],
//     );
//   }
// }

// class UpperTPositionInfo {
//   UpperTPositionInfo({required this.twoColumnStyle});

//   final UpperLeftPositionInfoTwoColumnStyle? twoColumnStyle;

//   factory UpperTPositionInfo.fromJson(Map<String, dynamic> json) {
//     return UpperTPositionInfo(
//       twoColumnStyle: json["twoColumnStyle"] == null
//           ? null
//           : UpperLeftPositionInfoTwoColumnStyle.fromJson(
//               json["twoColumnStyle"],
//             ),
//     );
//   }
// }

// class UpperLeftPositionInfoTwoColumnStyle {
//   UpperLeftPositionInfoTwoColumnStyle({
//     required this.contentType,
//     required this.displayType,
//     required this.image,
//     required this.appTraceInfo,
//   });

//   final String? contentType;
//   final String? displayType;
//   final String? image;
//   final String? appTraceInfo;

//   factory UpperLeftPositionInfoTwoColumnStyle.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return UpperLeftPositionInfoTwoColumnStyle(
//       contentType: json["contentType"],
//       displayType: json["displayType"],
//       image: json["image"],
//       appTraceInfo: json["appTraceInfo"],
//     );
//   }
// }

// class V2ProductAttributeLabelList {
//   V2ProductAttributeLabelList({
//     required this.contentType,
//     required this.tagId,
//     required this.labelLang,
//     required this.fontColor,
//     required this.backgroundColor,
//     required this.appTraceInfo,
//     required this.icon,
//   });

//   final String? contentType;
//   final String? tagId;
//   final String? labelLang;
//   final String? fontColor;
//   final String? backgroundColor;
//   final String? appTraceInfo;
//   final String? icon;

//   factory V2ProductAttributeLabelList.fromJson(Map<String, dynamic> json) {
//     return V2ProductAttributeLabelList(
//       contentType: json["contentType"],
//       tagId: json["tagId"],
//       labelLang: json["labelLang"],
//       fontColor: json["fontColor"],
//       backgroundColor: json["backgroundColor"],
//       appTraceInfo: json["appTraceInfo"],
//       icon: json["icon"],
//     );
//   }
// }

// class ProductSalesLabel {
//   ProductSalesLabel({
//     required this.uniqueTagId,
//     required this.labelType,
//     required this.labelTitle,
//     required this.labelTitleColor,
//     required this.labelBgImgColor,
//     required this.titleIcon,
//   });

//   final String? uniqueTagId;
//   final String? labelType;
//   final String? labelTitle;
//   final String? labelTitleColor;
//   final String? labelBgImgColor;
//   final String? titleIcon;

//   factory ProductSalesLabel.fromJson(Map<String, dynamic> json) {
//     return ProductSalesLabel(
//       uniqueTagId: json["uniqueTagId"],
//       labelType: json["labelType"],
//       labelTitle: json["labelTitle"],
//       labelTitleColor: json["labelTitleColor"],
//       labelBgImgColor: json["labelBgImgColor"],
//       titleIcon: json["titleIcon"],
//     );
//   }
// }

// class PromotionInfo {
//   PromotionInfo({
//     required this.typeId,
//     required this.dsaEndTime,
//     required this.startTimestamp,
//     required this.id,
//     required this.mallCode,
//     required this.mallCodeList,
//     required this.promotionInfoCategoryInfo,
//     required this.everyBodyPriceType,
//     required this.endTime,
//     required this.isReturn,
//     required this.endTimestamp,
//     required this.isFullShop,
//     required this.isDeletePromotion,
//     required this.isAddBuy,
//     required this.singleNum,
//     required this.singleRemainNum,
//     required this.saleNumScene,
//     required this.buyLimitType,
//     required this.languageKey,
//     // required this.aggregateMemberResult,
//     required this.promotionActivityPriority,
//     required this.promotionLogoType,
//     // required this.rules,
//     required this.subject,
//     required this.channelType,
//     required this.categoryInfo,
//     required this.maxDiscountConvertByAppCurrency,
//     required this.flashType,
//     required this.buyLimit,
//     required this.scId,
//     required this.endTimeTimeStamp,
//     required this.isCountdown,
//     required this.discountValue,
//     required this.orderNum,
//     required this.member,
//     required this.soldNum,
//     required this.isOver,
//     required this.singleLimitType,
//     required this.isSize,
//     required this.page,
//     // required this.tips,
//     required this.ruleType,
//     required this.isShowSaleDiscount,
//     required this.vcId,
//   });

//   final String? typeId;
//   final String? dsaEndTime;
//   final String? startTimestamp;
//   final String? id;
//   final String? mallCode;
//   final List<String> mallCodeList;
//   final List<dynamic> promotionInfoCategoryInfo;
//   final String? everyBodyPriceType;
//   final DateTime? endTime;
//   final String? isReturn;
//   final String? endTimestamp;
//   final String? isFullShop;
//   final String? isDeletePromotion;
//   final String? isAddBuy;
//   final String? singleNum;
//   final String? singleRemainNum;
//   final String? saleNumScene;
//   final String? buyLimitType;
//   final String? languageKey;
//   // final AggregateMemberResult? aggregateMemberResult;
//   final int? promotionActivityPriority;
//   final String? promotionLogoType;
//   // final List<Rule> rules;
//   final String? subject;
//   final String? channelType;
//   final List<dynamic> categoryInfo;
//   final DiscountPrice? maxDiscountConvertByAppCurrency;
//   final String? flashType;
//   final String? buyLimit;
//   final String? scId;
//   final String? endTimeTimeStamp;
//   final String? isCountdown;
//   final String? discountValue;
//   final String? orderNum;
//   final String? member;
//   final String? soldNum;
//   final String? isOver;
//   final String? singleLimitType;
//   final String? isSize;
//   final String? page;
//   // final Tips? tips;
//   final String? ruleType;
//   final String? isShowSaleDiscount;
//   final String? vcId;

//   factory PromotionInfo.fromJson(Map<String, dynamic> json) {
//     return PromotionInfo(
//       typeId: json["typeId"],
//       dsaEndTime: json["dsaEndTime"],
//       startTimestamp: json["startTimestamp"],
//       id: json["id"],
//       mallCode: json["mall_code"],
//       mallCodeList: json["mall_code_list"] == null
//           ? []
//           : List<String>.from(json["mall_code_list"]!.map((x) => x)),
//       promotionInfoCategoryInfo: json["category_info"] == null
//           ? []
//           : List<dynamic>.from(json["category_info"]!.map((x) => x)),
//       everyBodyPriceType: json["every_body_price_type"],
//       endTime: DateTime.tryParse(json["endTime"] ?? ""),
//       isReturn: json["isReturn"],
//       endTimestamp: json["endTimestamp"],
//       isFullShop: json["isFullShop"],
//       isDeletePromotion: json["isDeletePromotion"],
//       isAddBuy: json["isAddBuy"],
//       singleNum: json["singleNum"],
//       singleRemainNum: json["singleRemainNum"],
//       saleNumScene: json["saleNumScene"],
//       buyLimitType: json["buyLimitType"],
//       languageKey: json["language_key"],
//       // aggregateMemberResult: json["aggregateMemberResult"] == null
//       //     ? null
//       //     : AggregateMemberResult.fromJson(json["aggregateMemberResult"]),
//       promotionActivityPriority: json["promotionActivityPriority"],
//       promotionLogoType: json["promotion_logo_type"],
//       // rules: json["rules"] == null
//       //     ? []
//       //     : List<Rule>.from(json["rules"]!.map((x) => Rule.fromJson(x))),
//       subject: json["subject"],
//       channelType: json["channelType"],
//       categoryInfo: json["categoryInfo"] == null
//           ? []
//           : List<dynamic>.from(json["categoryInfo"]!.map((x) => x)),
//       maxDiscountConvertByAppCurrency:
//           json["max_discount_convert_by_app_currency"] == null
//           ? null
//           : DiscountPrice.fromJson(
//               json["max_discount_convert_by_app_currency"],
//             ),
//       flashType: json["flash_type"],
//       buyLimit: json["buyLimit"],
//       scId: json["scId"],
//       endTimeTimeStamp: json["endTimeTimeStamp"],
//       isCountdown: json["isCountdown"],
//       discountValue: json["discountValue"],
//       orderNum: json["orderNum"],
//       member: json["member"],
//       soldNum: json["soldNum"],
//       isOver: json["isOver"],
//       singleLimitType: json["singleLimitType"],
//       isSize: json["isSize"],
//       page: json["page"],
//       // tips: json["tips"] == null ? null : Tips.fromJson(json["tips"]),
//       ruleType: json["ruleType"],
//       isShowSaleDiscount: json["isShowSaleDiscount"],
//       vcId: json["vcId"],
//     );
//   }
// }

// class AggregateMemberResult {
//   AggregateMemberResult({required this.json});
//   final Map<String, dynamic> json;

//   factory AggregateMemberResult.fromJson(Map<String, dynamic> json) {
//     return AggregateMemberResult(json: json);
//   }
// }

// class Rule {
//   Rule({
//     required this.type,
//     required this.value,
//     // required this.discount,
//     required this.valueAmount,
//     required this.maxDiscount,
//     required this.maxDiscountAmount,
//     required this.deliveryId,
//   });

//   final int? type;
//   final int? value;
//   // final Discount? discount;
//   final DiscountPrice? valueAmount;
//   final int? maxDiscount;
//   final DiscountPrice? maxDiscountAmount;
//   final dynamic deliveryId;

//   factory Rule.fromJson(Map<String, dynamic> json) {
//     return Rule(
//       type: json["type"],
//       value: json["value"],
//       // discount: json["discount"] == null
//       //     ? null
//       //     : Discount.fromJson(json["discount"]),
//       valueAmount: json["value_amount"] == null
//           ? null
//           : DiscountPrice.fromJson(json["value_amount"]),
//       maxDiscount: json["max_discount"],
//       maxDiscountAmount: json["max_discount_amount"] == null
//           ? null
//           : DiscountPrice.fromJson(json["max_discount_amount"]),
//       deliveryId: json["delivery_id"],
//     );
//   }
// }

// class Discount {
//   Discount({
//     required this.type,
//     required this.value,
//     required this.enjoyGoodsNum,
//     required this.valueAmount,
//     required this.giftCoupons,
//   });

//   final int? type;
//   final double? value;
//   final int? enjoyGoodsNum;
//   final DiscountPrice? valueAmount;
//   final List<dynamic> giftCoupons;

//   factory Discount.fromJson(Map<String, dynamic> json) {
//     return Discount(
//       type: json["type"],
//       value: parseDouble(json["value"]),
//       enjoyGoodsNum: json["enjoy_goods_num"],
//       valueAmount: json["value_amount"] == null
//           ? null
//           : DiscountPrice.fromJson(json["value_amount"]),
//       giftCoupons: json["gift_coupons"] == null
//           ? []
//           : List<dynamic>.from(json["gift_coupons"]!.map((x) => x)),
//     );
//   }
// }

// class Tips {
//   Tips({required this.text});

//   final String? text;

//   factory Tips.fromJson(Map<String, dynamic> json) {
//     return Tips(text: json["text"]);
//   }
// }

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

// class SpuImages {
//   SpuImages({required this.spuImages, required this.trackInfo});

//   final List<String> spuImages;
//   final String? trackInfo;

//   factory SpuImages.fromJson(Map<String, dynamic> json) {
//     return SpuImages(
//       spuImages: json["spu_images"] == null
//           ? []
//           : List<String>.from(json["spu_images"]!.map((x) => x)),
//       trackInfo: json["track_info"],
//     );
//   }
// }

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
