class DetailsSheinImageList {
  DetailsSheinImageList({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  factory DetailsSheinImageList.fromJson(Map<String, dynamic> json) {
    return DetailsSheinImageList(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      error: json["error"],
    );
  }
}

class Data {
  Data({
    // required this.goodsColorImage,
    // required this.fromSkuCode,
    // required this.parentIds,
    // required this.spu,
    // required this.soldOutStatus,
    // required this.productStockCheckLog,
    // required this.goodsId,
    // required this.goodsSn,
    // required this.productRelationId,
    required this.goodsImg,
    required this.detailImage,
    // required this.goodsName,
    // required this.goodsUrlName,
    // required this.catId,
    // required this.cateName,
    // required this.stock,
    // required this.storeCode,
    // required this.businessModel,
    // required this.mallCode,
    // required this.isOnSale,
    // required this.retailPrice,
    // required this.salePrice,
    // required this.discountPrice,
    // required this.isInversion,
    // required this.retailDiscountPrice,
    // required this.retailDiscountPercent,
    // required this.isNewCoupon,
    // required this.isSrpInversion,
    // required this.srpDiscount,
    // required this.srpDiscountPrice,
    // required this.unitDiscount,
    // required this.originalDiscount,
    // required this.promotionInfo,
    // required this.premiumFlagNew,
    // required this.productInfoLabels,
    // required this.quickship,
    // required this.couponPrices,
    // required this.videoUrl,
    // required this.relatedColor,
    // required this.relatedColorNew,
    // required this.isClearance,
    // required this.productMaterial,
    // required this.isShowPlusSize,
    // required this.actTagFromCcc,
    // required this.rankInfo,
    // required this.commentNumShow,
    // required this.commentRankAverage,
    // required this.commentNum,
    // required this.percentOverallFit,
    // required this.isSingleSku,
    // required this.ext,
    // required this.isShowAdditionalDiscount,
    // required this.usePositionInfo,
    // required this.dynamicExt,
    // required this.productUrl,
    // required this.isProductAvailable,
  });

  // final String? goodsColorImage;
  // final String? fromSkuCode;
  // final List<String> parentIds;
  // final String? spu;
  // final bool? soldOutStatus;
  // final String? productStockCheckLog;
  // final String? goodsId;
  // final String? goodsSn;
  // final String? productRelationId;
  final String? goodsImg;
  final List<String> detailImage;
  // final String? goodsName;
  // final String? goodsUrlName;
  // final String? catId;
  // final String? cateName;
  // final String? stock;
  // final String? storeCode;
  // final String? businessModel;
  // final String? mallCode;
  // final int? isOnSale;
  // final DiscountPrice? retailPrice;
  // final DiscountPrice? salePrice;
  // final DiscountPrice? discountPrice;
  // final String? isInversion;
  // final DiscountPrice? retailDiscountPrice;
  // final String? retailDiscountPercent;
  // final String? isNewCoupon;
  // final String? isSrpInversion;
  // final String? srpDiscount;
  // final DiscountPrice? srpDiscountPrice;
  // final String? unitDiscount;
  // final String? originalDiscount;
  // final List<PromotionInfo> promotionInfo;
  // final PremiumFlagNew? premiumFlagNew;
  // final DynamicExt? productInfoLabels;
  // final String? quickship;
  // final List<dynamic> couponPrices;
  // final String? videoUrl;
  // final List<dynamic> relatedColor;
  // final List<RelatedColorNew> relatedColorNew;
  // final String? isClearance;
  // final ProductMaterial? productMaterial;
  // final String? isShowPlusSize;
  // final ActTagFromCcc? actTagFromCcc;
  // final ActTagFromCcc? rankInfo;
  // final String? commentNumShow;
  // final String? commentRankAverage;
  // final int? commentNum;
  // final PercentOverallFit? percentOverallFit;
  // final String? isSingleSku;
  // final DynamicExt? ext;
  // final String? isShowAdditionalDiscount;
  // final String? usePositionInfo;
  // final DynamicExt? dynamicExt;
  // final String? productUrl;
  // final bool? isProductAvailable;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      // goodsColorImage: json["goodsColorImage"],
      // fromSkuCode: json["fromSkuCode"],
      // parentIds: json["parentIds"] == null
      //     ? []
      //     : List<String>.from(json["parentIds"]!.map((x) => x)),
      // spu: json["spu"],
      // soldOutStatus: json["soldOutStatus"],
      // productStockCheckLog: json["productStockCheckLog"],
      // goodsId: json["goods_id"],
      // goodsSn: json["goods_sn"],
      // productRelationId: json["productRelationID"],
      goodsImg: json["goods_img"],
      detailImage: json["detail_image"] == null
          ? []
          : List<String>.from(json["detail_image"]!.map((x) => x.toString())),
      // goodsName: json["goods_name"],
      // goodsUrlName: json["goods_url_name"],
      // catId: json["cat_id"]?.toString(),
      // cateName: json["cate_name"],
      // stock: json["stock"]?.toString(),
      // storeCode: json["store_code"],
      // businessModel: json["business_model"],
      // mallCode: json["mall_code"],
      // isOnSale: json["is_on_sale"],
      // retailPrice: (json["retailPrice"] is Map<String, dynamic>)
      //     ? DiscountPrice.fromJson(json["retailPrice"])
      //     : null,
      // salePrice: (json["salePrice"] is Map<String, dynamic>)
      //     ? DiscountPrice.fromJson(json["salePrice"])
      //     : null,
      // discountPrice: (json["discountPrice"] is Map<String, dynamic>)
      //     ? DiscountPrice.fromJson(json["discountPrice"])
      //     : null,
      // isInversion: json["isInversion"]?.toString(),
      // retailDiscountPrice: json["retailDiscountPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      // retailDiscountPercent: json["retailDiscountPercent"]?.toString(),
      // isNewCoupon: json["isNewCoupon"]?.toString(),
      // isSrpInversion: json["isSrpInversion"]?.toString(),
      // srpDiscount: json["srpDiscount"]?.toString(),
      // srpDiscountPrice: json["srpDiscountPrice"] == null
      //     ? null
      //     : DiscountPrice.fromJson(json["srpDiscountPrice"]),
      // unitDiscount: json["unit_discount"]?.toString(),
      // originalDiscount: json["original_discount"]?.toString(),
      // promotionInfo: json["promotionInfo"] == null
      //     ? []
      //     : List<PromotionInfo>.from(
      //         json["promotionInfo"]!.map((x) => PromotionInfo.fromJson(x)),
      //       ),
      // premiumFlagNew: (json["premiumFlagNew"] is Map<String, dynamic>)
      //     ? PremiumFlagNew.fromJson(json["premiumFlagNew"])
      //     : null,
      // productInfoLabels: (json["productInfoLabels"] is Map<String, dynamic>)
      //     ? DynamicExt.fromJson(json["productInfoLabels"])
      //     : null,
      // quickship: json["quickship"]?.toString(),
      // couponPrices: json["coupon_prices"] == null
      //     ? []
      //     : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      // videoUrl: json["video_url"],
      // relatedColor: json["relatedColor"] == null
      //     ? []
      //     : List<dynamic>.from(json["relatedColor"]!.map((x) => x)),
      // relatedColorNew: json["relatedColorNew"] == null
      //     ? []
      //     : List<RelatedColorNew>.from(
      //         json["relatedColorNew"]!.map((x) => RelatedColorNew.fromJson(x)),
      //       ),
      // isClearance: json["is_clearance"]?.toString(),
      // productMaterial: (json["productMaterial"] is Map<String, dynamic>)
      //     ? ProductMaterial.fromJson(json["productMaterial"])
      //     : null,
      // isShowPlusSize: json["is_show_plus_size"]?.toString(),
      // actTagFromCcc: (json["actTagFromCcc"] is Map<String, dynamic>)
      //     ? ActTagFromCcc.fromJson(json["actTagFromCcc"])
      //     : null,
      // rankInfo: (json["rankInfo"] is Map<String, dynamic>)
      //     ? ActTagFromCcc.fromJson(json["rankInfo"])
      //     : null,
      // commentNumShow: json["comment_num_show"]?.toString(),
      // commentRankAverage: json["comment_rank_average"]?.toString(),
      // commentNum: json["comment_num"],
      // percentOverallFit: (json["percent_overall_fit"] is Map<String, dynamic>)
      //     ? PercentOverallFit.fromJson(json["percent_overall_fit"])
      //     : null,
      // isSingleSku: json["is_single_sku"]?.toString(),
      // ext: (json["ext"] is Map<String, dynamic>)
      //     ? DynamicExt.fromJson(json["ext"])
      //     : null,
      // isShowAdditionalDiscount: json["isShowAdditionalDiscount"]?.toString(),
      // usePositionInfo: json["usePositionInfo"]?.toString(),
      // dynamicExt: (json["dynamic_ext"] is Map<String, dynamic>)
      //     ? DynamicExt.fromJson(json["dynamic_ext"])
      //     : null,
      // productUrl: json["productUrl"],
      // isProductAvailable: json["isProductAvailable"],
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

// class DiscountPrice {
//   DiscountPrice({
//     required this.amount,
//     required this.amountWithSymbol,
//     required this.usdAmount,
//     required this.usdAmountWithSymbol,
//     required this.priceShowStyle,
//   });

//   final String? amount;
//   final String? amountWithSymbol;
//   final String? usdAmount;
//   final String? usdAmountWithSymbol;
//   final String? priceShowStyle;

//   factory DiscountPrice.fromJson(Map<String, dynamic> json) {
//     return DiscountPrice(
//       amount: json["amount"],
//       amountWithSymbol: json["amountWithSymbol"],
//       usdAmount: json["usdAmount"],
//       usdAmountWithSymbol: json["usdAmountWithSymbol"],
//       priceShowStyle: json["priceShowStyle"],
//     );
//   }
// }

// class DynamicExt {
//   DynamicExt({required this.json});
//   final Map<String, dynamic> json;

//   factory DynamicExt.fromJson(Map<String, dynamic> json) {
//     return DynamicExt(json: json);
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

// class PremiumFlagNew {
//   PremiumFlagNew({
//     required this.brandId,
//     required this.productRecommendByGroup,
//     required this.secondSeriesId,
//     required this.brandSeriesType,
//     required this.brandBadgeName,
//     required this.brandLogoUrlLeft,
//     required this.brandCode,
//     required this.seriesBadgeName,
//     required this.seriesId,
//     required this.brandName,
//   });

//   final String? brandId;
//   final int? productRecommendByGroup;
//   final String? secondSeriesId;
//   final String? brandSeriesType;
//   final String? brandBadgeName;
//   final String? brandLogoUrlLeft;
//   final String? brandCode;
//   final String? seriesBadgeName;
//   final String? seriesId;
//   final String? brandName;

//   factory PremiumFlagNew.fromJson(Map<String, dynamic> json) {
//     return PremiumFlagNew(
//       brandId: json["brandId"],
//       productRecommendByGroup: json["productRecommendByGroup"],
//       secondSeriesId: json["secondSeriesId"],
//       brandSeriesType: json["brandSeriesType"],
//       brandBadgeName: json["brand_badge_name"],
//       brandLogoUrlLeft: json["brand_logo_url_left"],
//       brandCode: json["brand_code"],
//       seriesBadgeName: json["series_badge_name"],
//       seriesId: json["seriesId"],
//       brandName: json["brandName"],
//     );
//   }
// }

// class ProductMaterial {
//   ProductMaterial({
//     required this.pictureBelt,
//     required this.upperLeftPositionInfo,
//     required this.lowerRightPositionInfo,
//     required this.salesLabel,
//     required this.showAddButtonLabel,
//     required this.showAddButtonLabelStyle,
//     required this.trendLabel,
//     required this.v2ProductAttributeLabelList,
//     required this.goodsDetailExtraParams,
//     required this.fullPriceUi,
//   });

//   final PictureBelt? pictureBelt;
//   final UpperLeftPositionInfo? upperLeftPositionInfo;
//   final LowerRightPositionInfo? lowerRightPositionInfo;
//   final SalesLabel? salesLabel;
//   final String? showAddButtonLabel;
//   final String? showAddButtonLabelStyle;
//   final ProductMaterialTrendLabel? trendLabel;
//   final List<V2ProductAttributeLabelList> v2ProductAttributeLabelList;
//   final GoodsDetailExtraParams? goodsDetailExtraParams;
//   final FullPriceUi? fullPriceUi;

//   factory ProductMaterial.fromJson(Map<String, dynamic> json) {
//     return ProductMaterial(
//       pictureBelt: json["pictureBelt"] == null
//           ? null
//           : PictureBelt.fromJson(json["pictureBelt"]),
//       upperLeftPositionInfo: json["upperLeftPositionInfo"] == null
//           ? null
//           : UpperLeftPositionInfo.fromJson(json["upperLeftPositionInfo"]),
//       lowerRightPositionInfo: json["lowerRightPositionInfo"] == null
//           ? null
//           : LowerRightPositionInfo.fromJson(json["lowerRightPositionInfo"]),
//       salesLabel: json["salesLabel"] == null
//           ? null
//           : SalesLabel.fromJson(json["salesLabel"]),
//       showAddButtonLabel: json["showAddButtonLabel"],
//       showAddButtonLabelStyle: json["showAddButtonLabelStyle"],
//       trendLabel: json["trendLabel"] == null
//           ? null
//           : ProductMaterialTrendLabel.fromJson(json["trendLabel"]),
//       v2ProductAttributeLabelList: json["v2ProductAttributeLabelList"] == null
//           ? []
//           : List<V2ProductAttributeLabelList>.from(
//               json["v2ProductAttributeLabelList"]!.map(
//                 (x) => V2ProductAttributeLabelList.fromJson(x),
//               ),
//             ),
//       goodsDetailExtraParams: json["goodsDetailExtraParams"] == null
//           ? null
//           : GoodsDetailExtraParams.fromJson(json["goodsDetailExtraParams"]),
//       fullPriceUi: json["fullPriceUI"] == null
//           ? null
//           : FullPriceUi.fromJson(json["fullPriceUI"]),
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
//   final List<String> style;
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
//           : List<String>.from(json["style"]!.map((x) => x)),
//       firstSalePrice: json["firstSalePrice"],
//     );
//   }
// }

// class Bi {
//   Bi({required this.pri, required this.isFlashSale, required this.otherMarks});

//   final String? pri;
//   final String? isFlashSale;
//   final dynamic otherMarks;

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

//   final dynamic type;

//   factory LeadingIcon.fromJson(Map<String, dynamic> json) {
//     return LeadingIcon(type: json["type"]);
//   }
// }

// class GoodsDetailExtraParams {
//   GoodsDetailExtraParams({required this.buyboxTag});

//   final String? buyboxTag;

//   factory GoodsDetailExtraParams.fromJson(Map<String, dynamic> json) {
//     return GoodsDetailExtraParams(buyboxTag: json["buyboxTag"]);
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
//     required this.trendLabel,
//     required this.routingUrl,
//     required this.contentRoutingUrl,
//     required this.trendStoreTabAbtValue,
//     required this.appTraceInfo,
//     required this.showPosition,
//     required this.trendWordId,
//     required this.trendShopCode,
//     required this.trendType,
//     required this.fashionStoreName,
//     required this.fashionStoreLogo,
//     required this.carrierType,
//     required this.carrierTypeName,
//     required this.contentCarrierId,
//     required this.carrierSubTypeName,
//     required this.sceneId,
//   });

//   final TrendIpImg? trendIpImg;
//   final TrendIpImg? trendIpBigImg;
//   final String? trendIpLang;
//   final TrendLabelTrendLabel? trendLabel;
//   final String? routingUrl;
//   final String? contentRoutingUrl;
//   final String? trendStoreTabAbtValue;
//   final String? appTraceInfo;
//   final String? showPosition;
//   final String? trendWordId;
//   final String? trendShopCode;
//   final String? trendType;
//   final String? fashionStoreName;
//   final String? fashionStoreLogo;
//   final String? carrierType;
//   final String? carrierTypeName;
//   final String? contentCarrierId;
//   final String? carrierSubTypeName;
//   final String? sceneId;

//   factory ProductMaterialTrendLabel.fromJson(Map<String, dynamic> json) {
//     return ProductMaterialTrendLabel(
//       trendIpImg: json["trendIpImg"] == null
//           ? null
//           : TrendIpImg.fromJson(json["trendIpImg"]),
//       trendIpBigImg: json["trendIpBigImg"] == null
//           ? null
//           : TrendIpImg.fromJson(json["trendIpBigImg"]),
//       trendIpLang: json["trendIpLang"],
//       trendLabel: json["trendLabel"] == null
//           ? null
//           : TrendLabelTrendLabel.fromJson(json["trendLabel"]),
//       routingUrl: json["routingUrl"],
//       contentRoutingUrl: json["contentRoutingUrl"],
//       trendStoreTabAbtValue: json["trendStoreTabAbtValue"],
//       appTraceInfo: json["appTraceInfo"],
//       showPosition: json["showPosition"],
//       trendWordId: json["trendWordId"],
//       trendShopCode: json["trendShopCode"],
//       trendType: json["trendType"],
//       fashionStoreName: json["fashionStoreName"],
//       fashionStoreLogo: json["fashionStoreLogo"],
//       carrierType: json["carrierType"],
//       carrierTypeName: json["carrierTypeName"],
//       contentCarrierId: json["contentCarrierId"],
//       carrierSubTypeName: json["carrierSubTypeName"],
//       sceneId: json["sceneId"],
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

// class UpperLeftPositionInfo {
//   UpperLeftPositionInfo({required this.twoColumnStyle});

//   final UpperLeftPositionInfoTwoColumnStyle? twoColumnStyle;

//   factory UpperLeftPositionInfo.fromJson(Map<String, dynamic> json) {
//     return UpperLeftPositionInfo(
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
//     required this.appTraceInfo,
//   });

//   final String? contentType;
//   final String? tagId;
//   final String? appTraceInfo;

//   factory V2ProductAttributeLabelList.fromJson(Map<String, dynamic> json) {
//     return V2ProductAttributeLabelList(
//       contentType: json["contentType"],
//       tagId: json["tagId"],
//       appTraceInfo: json["appTraceInfo"],
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
//     required this.scId,
//     required this.endTimestamp,
//     required this.isFullShop,
//     required this.isDeletePromotion,
//     required this.isAddBuy,
//     required this.singleNum,
//     required this.singleRemainNum,
//     required this.saleNumScene,
//     required this.buyLimitType,
//     required this.languageKey,
//     required this.aggregateMemberResult,
//     required this.promotionActivityPriority,
//     required this.promotionLogoType,
//     required this.rules,
//     required this.subject,
//     required this.channelType,
//     required this.categoryInfo,
//     required this.poolList,
//     required this.maxDiscountConvertByAppCurrency,
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
//   final String? scId;
//   final String? endTimestamp;
//   final String? isFullShop;
//   final String? isDeletePromotion;
//   final String? isAddBuy;
//   final String? singleNum;
//   final String? singleRemainNum;
//   final String? saleNumScene;
//   final String? buyLimitType;
//   final String? languageKey;
//   final DynamicExt? aggregateMemberResult;
//   final int? promotionActivityPriority;
//   final String? promotionLogoType;
//   final List<Rule> rules;
//   final String? subject;
//   final String? channelType;
//   final List<dynamic> categoryInfo;
//   final List<dynamic> poolList;
//   final DiscountPrice? maxDiscountConvertByAppCurrency;

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
//       scId: json["scId"],
//       endTimestamp: json["endTimestamp"],
//       isFullShop: json["isFullShop"],
//       isDeletePromotion: json["isDeletePromotion"],
//       isAddBuy: json["isAddBuy"],
//       singleNum: json["singleNum"],
//       singleRemainNum: json["singleRemainNum"],
//       saleNumScene: json["saleNumScene"],
//       buyLimitType: json["buyLimitType"],
//       languageKey: json["language_key"],
//       aggregateMemberResult: json["aggregateMemberResult"] == null
//           ? null
//           : (json["aggregateMemberResult"] is Map<String, dynamic>)
//           ? DynamicExt.fromJson(json["aggregateMemberResult"])
//           : null,
//       promotionActivityPriority: json["promotionActivityPriority"],
//       promotionLogoType: json["promotion_logo_type"],
//       rules: json["rules"] == null
//           ? []
//           : List<Rule>.from(json["rules"]!.map((x) => Rule.fromJson(x))),
//       subject: json["subject"],
//       channelType: json["channelType"],
//       categoryInfo: json["categoryInfo"] == null
//           ? []
//           : List<dynamic>.from(json["categoryInfo"]!.map((x) => x)),
//       poolList: json["pool_list"] == null
//           ? []
//           : List<dynamic>.from(json["pool_list"]!.map((x) => x)),
//       maxDiscountConvertByAppCurrency:
//           json["max_discount_convert_by_app_currency"] == null
//           ? null
//           : (json["max_discount_convert_by_app_currency"]
//                 is Map<String, dynamic>)
//           ? DiscountPrice.fromJson(json["max_discount_convert_by_app_currency"])
//           : null,
//     );
//   }
// }

// class Rule {
//   Rule({
//     required this.type,
//     required this.value,
//     required this.discount,
//     required this.valueAmount,
//     required this.maxDiscount,
//     required this.maxDiscountAmount,
//     required this.deliveryId,
//   });

//   final int? type;
//   final int? value;
//   final Discount? discount;
//   final DiscountPrice? valueAmount;
//   final int? maxDiscount;
//   final DiscountPrice? maxDiscountAmount;
//   final dynamic deliveryId;

//   factory Rule.fromJson(Map<String, dynamic> json) {
//     return Rule(
//       type: (json["type"] as num?)?.toInt(),
//       value: (json["value"] as num?)?.toInt(),
//       discount: json["discount"] == null
//           ? null
//           : Discount.fromJson(json["discount"]),
//       valueAmount: json["value_amount"] == null
//           ? null
//           : DiscountPrice.fromJson(json["value_amount"]),
//       maxDiscount: (json["max_discount"] as num?)?.toInt(),
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
//   final int? value;
//   final int? enjoyGoodsNum;
//   final DiscountPrice? valueAmount;
//   final List<dynamic> giftCoupons;

//   factory Discount.fromJson(Map<String, dynamic> json) {
//     return Discount(
//       type: (json["type"] as num?)?.toInt(),
//       value: (json["value"] as num?)?.toInt(),
//       enjoyGoodsNum: (json["enjoy_goods_num"] as num?)?.toInt(),
//       valueAmount: json["value_amount"] == null
//           ? null
//           : DiscountPrice.fromJson(json["value_amount"]),
//       giftCoupons: json["gift_coupons"] == null
//           ? []
//           : List<dynamic>.from(json["gift_coupons"]!.map((x) => x)),
//     );
//   }
// }

// class RelatedColorNew {
//   RelatedColorNew({
//     required this.colorImage,
//     required this.goodsId,
//     required this.skcName,
//   });

//   final String? colorImage;
//   final String? goodsId;
//   final dynamic skcName;

//   factory RelatedColorNew.fromJson(Map<String, dynamic> json) {
//     return RelatedColorNew(
//       colorImage: json["colorImage"],
//       goodsId: json["goods_id"],
//       skcName: json["skc_name"],
//     );
//   }
// }
