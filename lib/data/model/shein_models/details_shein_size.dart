class DetailsSheinSize {
  DetailsSheinSize({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  factory DetailsSheinSize.fromJson(Map<String, dynamic> json) {
    return DetailsSheinSize(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      error: json["error"],
    );
  }
}

class Data {
  Data({
    required this.brand,
    required this.sizeTemplate,
    required this.stock,
    required this.isMultiPartProduct,
    required this.multiPartInfo,
    required this.mainSaleAttrShowMode,
    required this.productDetails,
    required this.mainSaleAttribute,
    required this.secondSaleAttributes,
    required this.comment,
    required this.promotionInfo,
    required this.promotion,
    required this.productRelationId,
    required this.retailPrice,
    required this.salePrice,
    required this.isPriceConfigured,
    required this.appPromotion,
    required this.rewardPoints,
    required this.doublePoints,
    required this.beautyCategory,
    required this.needAttrRelation,
    required this.goodsId,
    required this.catId,
    required this.goodsSn,
    required this.goodsUrlName,
    required this.supplierId,
    required this.goodsName,
    required this.originalImg,
    required this.isStockEnough,
    required this.goodsThumb,
    required this.goodsImg,
    required this.goodsDesc,
    required this.supplierTopCategoryId,
    required this.parentId,
    required this.parentIds,
    required this.isOnSale,
    required this.isVirtualStock,
    required this.isInit,
    required this.isPreSale,
    required this.isPreSaleEnd,
    required this.isSubscription,
    required this.colorImage,
    required this.storeCode,
    required this.businessModel,
    required this.goodsImgWebp,
    required this.originalImgWebp,
    required this.unitDiscount,
    required this.specialPriceOld,
    required this.isClearance,
    required this.limitCount,
    required this.flashGoods,
    required this.colorType,
    required this.mallInfo,
    required this.mallPrices,
    required this.mallStock,
    required this.customizationFlag,
    required this.microplasticsFlag,
    required this.instructionUrl,
    required this.productUrl,
  });

  final String? brand;
  final List<dynamic> sizeTemplate;
  final String? stock;
  final int? isMultiPartProduct;
  final List<dynamic> multiPartInfo;
  final int? mainSaleAttrShowMode;
  final List<MainSaleAttribute> productDetails;
  final List<MainSaleAttribute> mainSaleAttribute;
  final List<SecondSaleAttribute> secondSaleAttributes;
  final Comment? comment;
  final List<PromotionInfo> promotionInfo;
  final dynamic promotion;
  final String? productRelationId;
  final Price? retailPrice;
  final Price? salePrice;
  final dynamic isPriceConfigured;
  final dynamic appPromotion;
  final int? rewardPoints;
  final int? doublePoints;
  final bool? beautyCategory;
  final bool? needAttrRelation;
  final String? goodsId;
  final String? catId;
  final String? goodsSn;
  final String? goodsUrlName;
  final dynamic supplierId;
  final String? goodsName;
  final String? originalImg;
  final String? isStockEnough;
  final String? goodsThumb;
  final String? goodsImg;
  final String? goodsDesc;
  final String? supplierTopCategoryId;
  final String? parentId;
  final List<int> parentIds;
  final String? isOnSale;
  final String? isVirtualStock;
  final String? isInit;
  final String? isPreSale;
  final String? isPreSaleEnd;
  final String? isSubscription;
  final String? colorImage;
  final int? storeCode;
  final int? businessModel;
  final String? goodsImgWebp;
  final String? originalImgWebp;
  final String? unitDiscount;
  final dynamic specialPriceOld;
  final dynamic isClearance;
  final dynamic limitCount;
  final dynamic flashGoods;
  final String? colorType;
  final List<MallInfo> mallInfo;
  final List<MallPrice> mallPrices;
  final List<MallStock> mallStock;
  final int? customizationFlag;
  final int? microplasticsFlag;
  final dynamic instructionUrl;
  final String? productUrl;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      brand: json["brand"],
      sizeTemplate: json["sizeTemplate"] == null
          ? []
          : json["sizeTemplate"] is List
          ? List<dynamic>.from(json["sizeTemplate"])
          : json["sizeTemplate"] is Map
          ? List<dynamic>.from(json["sizeTemplate"].values)
          : [],
      stock: json["stock"],
      isMultiPartProduct: json["isMultiPartProduct"],
      multiPartInfo: json["multiPartInfo"] == null
          ? []
          : List<dynamic>.from(json["multiPartInfo"]!.map((x) => x)),
      mainSaleAttrShowMode: json["mainSaleAttrShowMode"],
      productDetails: json["productDetails"] == null
          ? []
          : List<MainSaleAttribute>.from(
              json["productDetails"]!.map((x) => MainSaleAttribute.fromJson(x)),
            ),
      mainSaleAttribute: json["mainSaleAttribute"] == null
          ? []
          : List<MainSaleAttribute>.from(
              json["mainSaleAttribute"]!.map(
                (x) => MainSaleAttribute.fromJson(x),
              ),
            ),
      secondSaleAttributes: json["secondSaleAttributes"] == null
          ? []
          : List<SecondSaleAttribute>.from(
              json["secondSaleAttributes"]!.map(
                (x) => SecondSaleAttribute.fromJson(x),
              ),
            ),
      comment: json["comment"] == null
          ? null
          : Comment.fromJson(json["comment"]),
      promotionInfo: json["promotionInfo"] == null
          ? []
          : List<PromotionInfo>.from(
              json["promotionInfo"]!.map((x) => PromotionInfo.fromJson(x)),
            ),
      promotion: json["promotion"],
      productRelationId: json["productRelationID"],
      retailPrice: json["retailPrice"] == null
          ? null
          : Price.fromJson(json["retailPrice"]),
      salePrice: json["salePrice"] == null
          ? null
          : Price.fromJson(json["salePrice"]),
      isPriceConfigured: json["isPriceConfigured"],
      appPromotion: json["appPromotion"],
      rewardPoints: json["rewardPoints"],
      doublePoints: json["doublePoints"],
      beautyCategory: json["beautyCategory"],
      needAttrRelation: json["needAttrRelation"],
      goodsId: json["goods_id"],
      catId: json["cat_id"],
      goodsSn: json["goods_sn"],
      goodsUrlName: json["goods_url_name"],
      supplierId: json["supplier_id"],
      goodsName: json["goods_name"],
      originalImg: json["original_img"],
      isStockEnough: json["is_stock_enough"],
      goodsThumb: json["goods_thumb"],
      goodsImg: json["goods_img"],
      goodsDesc: json["goods_desc"],
      supplierTopCategoryId: json["supplier_top_category_id"],
      parentId: json["parent_id"],
      parentIds: json["parent_ids"] == null
          ? []
          : List<int>.from(json["parent_ids"]!.map((x) => x)),
      isOnSale: json["is_on_sale"],
      isVirtualStock: json["is_virtual_stock"],
      isInit: json["is_init"],
      isPreSale: json["is_pre_sale"],
      isPreSaleEnd: json["is_pre_sale_end"],
      isSubscription: json["is_subscription"],
      colorImage: json["color_image"],
      storeCode: json["store_code"],
      businessModel: json["business_model"],
      goodsImgWebp: json["goods_img_webp"],
      originalImgWebp: json["original_img_webp"],
      unitDiscount: json["unit_discount"],
      specialPriceOld: json["special_price_old"],
      isClearance: json["is_clearance"],
      limitCount: json["limit_count"],
      flashGoods: json["flash_goods"],
      colorType: json["color_type"],
      mallInfo: json["mall_info"] == null
          ? []
          : List<MallInfo>.from(
              json["mall_info"]!.map((x) => MallInfo.fromJson(x)),
            ),
      mallPrices: json["mall_prices"] == null
          ? []
          : List<MallPrice>.from(
              json["mall_prices"]!.map((x) => MallPrice.fromJson(x)),
            ),
      mallStock: json["mall_stock"] == null
          ? []
          : List<MallStock>.from(
              json["mall_stock"]!.map((x) => MallStock.fromJson(x)),
            ),
      customizationFlag: json["customization_flag"],
      microplasticsFlag: json["microplastics_flag"],
      instructionUrl: json["instruction_url"],
      productUrl: json["product_url"],
    );
  }
}

class Comment {
  Comment({required this.commentNum, required this.commentRank});

  final String? commentNum;
  final String? commentRank;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentNum: json["comment_num"],
      commentRank: json["comment_rank"],
    );
  }
}

class MainSaleAttribute {
  MainSaleAttribute({
    required this.attrId,
    required this.attrValueId,
    required this.attrName,
    required this.attrNameEn,
    required this.valueSort,
    required this.attrSelect,
    required this.attrSort,
    required this.leftShow,
    required this.attrValue,
    required this.attrValueEn,
    required this.attrDesc,
    required this.attrImage,
  });

  final int? attrId;
  final String? attrValueId;
  final String? attrName;
  final String? attrNameEn;
  final int? valueSort;
  final int? attrSelect;
  final int? attrSort;
  final int? leftShow;
  final String? attrValue;
  final String? attrValueEn;
  final String? attrDesc;
  final String? attrImage;

  factory MainSaleAttribute.fromJson(Map<String, dynamic> json) {
    return MainSaleAttribute(
      attrId: json["attr_id"],
      attrValueId: json["attr_value_id"],
      attrName: json["attr_name"],
      attrNameEn: json["attr_name_en"],
      valueSort: json["value_sort"],
      attrSelect: json["attr_select"],
      attrSort: json["attr_sort"],
      leftShow: json["left_show"],
      attrValue: json["attr_value"],
      attrValueEn: json["attr_value_en"],
      attrDesc: json["attr_desc"],
      attrImage: json["attr_image"],
    );
  }
}

class MallInfo {
  MallInfo({
    required this.mallCode,
    required this.mallName,
    required this.mallSort,
  });

  final String? mallCode;
  final String? mallName;
  final int? mallSort;

  factory MallInfo.fromJson(Map<String, dynamic> json) {
    return MallInfo(
      mallCode: json["mall_code"],
      mallName: json["mall_name"],
      mallSort: json["mall_sort"],
    );
  }
}

class MallPrice {
  MallPrice({
    required this.srpPrice,
    required this.srpDiscount,
    required this.showSrpDiscount,
    required this.mallCode,
    required this.retailPrice,
    required this.retailDiscountPrice,
    required this.retailOriginalDiscountPrice,
    required this.retailVipDiscountPrice,
    required this.retailDiscountValue,
    required this.retailDiscountPercent,
    required this.retailOriginalDiscount,
    required this.salePrice,
    required this.suggestedSalePrice,
    required this.isInversion,
    required this.isNewCoupon,
    required this.discountPrice,
    required this.voucherDiscountPrice,
    required this.unitDiscount,
    required this.promotionStatus,
    required this.promotionLogoType,
    required this.originalDiscount,
    required this.originalDiscountPrice,
    required this.prevDiscountValue,
    required this.couponPrices,
    required this.rewardPoints,
    required this.doublePoints,
  });

  final dynamic srpPrice;
  final int? srpDiscount;
  final int? showSrpDiscount;
  final String? mallCode;
  final Price? retailPrice;
  final Price? retailDiscountPrice;
  final Price? retailOriginalDiscountPrice;
  final dynamic retailVipDiscountPrice;
  final dynamic retailDiscountValue;
  final int? retailDiscountPercent;
  final int? retailOriginalDiscount;
  final Price? salePrice;
  final dynamic suggestedSalePrice;
  final int? isInversion;
  final int? isNewCoupon;
  final Price? discountPrice;
  final dynamic voucherDiscountPrice;
  final int? unitDiscount;
  final dynamic promotionStatus;
  final int? promotionLogoType;
  final String? originalDiscount;
  final Price? originalDiscountPrice;
  final dynamic prevDiscountValue;
  final List<dynamic> couponPrices;
  final int? rewardPoints;
  final int? doublePoints;

  factory MallPrice.fromJson(Map<String, dynamic> json) {
    return MallPrice(
      srpPrice: json["srpPrice"],
      srpDiscount: json["srpDiscount"],
      showSrpDiscount: json["showSrpDiscount"],
      mallCode: json["mall_code"],
      retailPrice: json["retailPrice"] == null
          ? null
          : Price.fromJson(json["retailPrice"]),
      retailDiscountPrice: json["retailDiscountPrice"] == null
          ? null
          : Price.fromJson(json["retailDiscountPrice"]),
      retailOriginalDiscountPrice: json["retailOriginalDiscountPrice"] == null
          ? null
          : Price.fromJson(json["retailOriginalDiscountPrice"]),
      retailVipDiscountPrice: json["retailVipDiscountPrice"],
      retailDiscountValue: json["retailDiscountValue"],
      retailDiscountPercent: json["retailDiscountPercent"],
      retailOriginalDiscount: json["retailOriginalDiscount"],
      salePrice: json["salePrice"] == null
          ? null
          : Price.fromJson(json["salePrice"]),
      suggestedSalePrice: json["suggestedSalePrice"],
      isInversion: json["isInversion"],
      isNewCoupon: json["isNewCoupon"],
      discountPrice: json["discountPrice"] == null
          ? null
          : Price.fromJson(json["discountPrice"]),
      voucherDiscountPrice: json["voucherDiscountPrice"],
      unitDiscount: json["unit_discount"],
      promotionStatus: json["promotion_status"],
      promotionLogoType: json["promotion_logo_type"],
      originalDiscount: json["original_discount"],
      originalDiscountPrice: json["original_discount_price"] == null
          ? null
          : Price.fromJson(json["original_discount_price"]),
      prevDiscountValue: json["prev_discount_value"],
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      rewardPoints: json["rewardPoints"],
      doublePoints: json["doublePoints"],
    );
  }
}

class Price {
  Price({
    required this.amount,
    required this.amountWithSymbol,
    required this.usdAmount,
    required this.usdAmountWithSymbol,
    required this.amountSimpleText,
  });

  final String? amount;
  final String? amountWithSymbol;
  final String? usdAmount;
  final String? usdAmountWithSymbol;
  final String? amountSimpleText;

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json["amount"],
      amountWithSymbol: json["amountWithSymbol"],
      usdAmount: json["usdAmount"],
      usdAmountWithSymbol: json["usdAmountWithSymbol"],
      amountSimpleText: json["amountSimpleText"],
    );
  }
}

class MallStock {
  MallStock({
    required this.stock,
    required this.skcQuickShip,
    required this.mallCode,
  });

  final int? stock;
  final bool? skcQuickShip;
  final String? mallCode;

  factory MallStock.fromJson(Map<String, dynamic> json) {
    return MallStock(
      stock: json["stock"],
      skcQuickShip: json["skcQuickShip"],
      mallCode: json["mall_code"],
    );
  }
}

class PromotionInfo {
  PromotionInfo({
    required this.id,
    required this.typeId,
    required this.endTime,
    required this.isReturn,
    required this.memberRule,
    required this.memberSiteUid,
    required this.singleNum,
    required this.endTimestamp,
    required this.promotionLogoType,
    required this.categoryInfo,
    required this.mallCode,
  });

  final String? id;
  final String? typeId;
  final DateTime? endTime;
  final String? isReturn;
  final List<dynamic> memberRule;
  final List<dynamic> memberSiteUid;
  final String? singleNum;
  final String? endTimestamp;
  final int? promotionLogoType;
  final List<dynamic> categoryInfo;
  final String? mallCode;

  factory PromotionInfo.fromJson(Map<String, dynamic> json) {
    return PromotionInfo(
      id: json["id"],
      typeId: json["typeId"],
      endTime: DateTime.tryParse(json["endTime"] ?? ""),
      isReturn: json["isReturn"],
      memberRule: json["memberRule"] == null
          ? []
          : List<dynamic>.from(json["memberRule"]!.map((x) => x)),
      memberSiteUid: json["memberSiteUid"] == null
          ? []
          : List<dynamic>.from(json["memberSiteUid"]!.map((x) => x)),
      singleNum: json["singleNum"],
      endTimestamp: json["endTimestamp"],
      promotionLogoType: json["promotionLogoType"],
      categoryInfo: json["categoryInfo"] == null
          ? []
          : List<dynamic>.from(json["categoryInfo"]!.map((x) => x)),
      mallCode: json["mall_code"],
    );
  }
}

class SecondSaleAttribute {
  SecondSaleAttribute({
    required this.attrId,
    required this.attrName,
    required this.attrNameEn,
    required this.attrSort,
    required this.attrSelect,
    required this.leftShow,
    required this.attrValueList,
  });

  final int? attrId;
  final String? attrName;
  final String? attrNameEn;
  final int? attrSort;
  final int? attrSelect;
  final int? leftShow;
  final List<AttrValueList> attrValueList;

  factory SecondSaleAttribute.fromJson(Map<String, dynamic> json) {
    return SecondSaleAttribute(
      attrId: json["attr_id"],
      attrName: json["attr_name"],
      attrNameEn: json["attr_name_en"],
      attrSort: json["attr_sort"],
      attrSelect: json["attr_select"],
      leftShow: json["left_show"],
      attrValueList: json["attr_value_list"] == null
          ? []
          : List<AttrValueList>.from(
              json["attr_value_list"]!.map((x) => AttrValueList.fromJson(x)),
            ),
    );
  }
}

class AttrValueList {
  AttrValueList({
    required this.attrValueId,
    required this.attrValue,
    required this.attrValueEn,
    required this.attrDesc,
    required this.attrImage,
  });

  final String? attrValueId;
  final String? attrValue;
  final String? attrValueEn;
  final dynamic attrDesc;
  final dynamic attrImage;

  factory AttrValueList.fromJson(Map<String, dynamic> json) {
    return AttrValueList(
      attrValueId: json["attr_value_id"],
      attrValue: json["attr_value"],
      attrValueEn: json["attr_value_en"],
      attrDesc: json["attr_desc"],
      attrImage: json["attr_image"],
    );
  }
}
