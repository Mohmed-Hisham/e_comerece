class ProductDitelsSheinDart {
  ProductDitelsSheinDart({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  factory ProductDitelsSheinDart.fromJson(Map<String, dynamic> json) {
    return ProductDitelsSheinDart(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      error: json["error"],
    );
  }
}

class Data {
  Data({required this.products});

  final Products? products;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: json["products"] == null
          ? null
          : Products.fromJson(json["products"]),
    );
  }
}

class Products {
  Products({
    required this.goodsId,
    required this.catId,
    required this.goodsSn,
    required this.goodsUrlName,
    required this.supplierId,
    required this.goodsName,
    required this.originalImg,
    required this.brand,
    required this.sizeTemplate,
    required this.isInit,
    required this.isVirtualStock,
    required this.productDetails,
    required this.promotionInfo,
    required this.promotion,
    required this.parentId,
    required this.colorImage,
    required this.productRelationId,
    required this.retailPrice,
    required this.businessModel,
    required this.storeCode,
    required this.salePrice,
    required this.unitDiscount,
    required this.isClearance,
    required this.limitCount,
    required this.flashGoods,
    required this.isPriceConfigured,
    required this.rewardPoints,
    required this.doublePoints,
    required this.comment,
    required this.isSubscription,
    required this.isPreSale,
    required this.isPreSaleEnd,
    required this.isStockEnough,
    required this.goodsThumb,
    required this.goodsImg,
    required this.goodsImgWebp,
    required this.originalImgWebp,
    required this.variants,
    required this.mallCode,
    required this.srpPrice,
    required this.srpDiscount,
    required this.showSrpDiscount,
    required this.retailDiscountPrice,
    required this.retailOriginalDiscountPrice,
    required this.retailVipDiscountPrice,
    required this.retailDiscountValue,
    required this.retailDiscountPercent,
    required this.retailOriginalDiscount,
    required this.isNewCoupon,
    required this.discountPrice,
    required this.voucherDiscountPrice,
    required this.promotionStatus,
    required this.promotionLogoType,
    required this.originalDiscount,
    required this.originalDiscountPrice,
    required this.prevDiscountValue,
    required this.couponPrices,
    required this.unitDiscountString,
    required this.mallPrice,
    required this.mallList,
    required this.mallSource,
    required this.priceSku,
    required this.productUrl,
  });

  final String? goodsId;
  final String? catId;
  final String? goodsSn;
  final String? goodsUrlName;
  final dynamic supplierId;
  final String? goodsName;
  final String? originalImg;
  final String? brand;
  final List<dynamic> sizeTemplate;
  final String? isInit;
  final String? isVirtualStock;
  final dynamic productDetails;
  final List<dynamic> promotionInfo;
  final dynamic promotion;
  final String? parentId;
  final String? colorImage;
  final String? productRelationId;
  final DiscountPrice? retailPrice;
  final int? businessModel;
  final int? storeCode;
  final DiscountPrice? salePrice;
  final int? unitDiscount;
  final dynamic isClearance;
  final dynamic limitCount;
  final dynamic flashGoods;
  final dynamic isPriceConfigured;
  final int? rewardPoints;
  final int? doublePoints;
  final Comment? comment;
  final String? isSubscription;
  final String? isPreSale;
  final String? isPreSaleEnd;
  final String? isStockEnough;
  final String? goodsThumb;
  final String? goodsImg;
  final String? goodsImgWebp;
  final String? originalImgWebp;
  final List<Variant> variants;
  final String? mallCode;
  final dynamic srpPrice;
  final int? srpDiscount;
  final int? showSrpDiscount;
  final DiscountPrice? retailDiscountPrice;
  final DiscountPrice? retailOriginalDiscountPrice;
  final dynamic retailVipDiscountPrice;
  final dynamic retailDiscountValue;
  final int? retailDiscountPercent;
  final int? retailOriginalDiscount;
  final int? isNewCoupon;
  final DiscountPrice? discountPrice;
  final dynamic voucherDiscountPrice;
  final dynamic promotionStatus;
  final dynamic promotionLogoType;
  final String? originalDiscount;
  final DiscountPrice? originalDiscountPrice;
  final dynamic prevDiscountValue;
  final List<dynamic> couponPrices;
  final String? unitDiscountString;
  final List<MallPrice> mallPrice;
  final List<MallList> mallList;
  final String? mallSource;
  final String? priceSku;
  final String? productUrl;

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      goodsId: json["goods_id"],
      catId: json["cat_id"],
      goodsSn: json["goods_sn"],
      goodsUrlName: json["goods_url_name"],
      supplierId: json["supplier_id"],
      goodsName: json["goods_name"],
      originalImg: json["original_img"],
      brand: json["brand"],
      sizeTemplate: json["sizeTemplate"] == null
          ? []
          : List<dynamic>.from(json["sizeTemplate"]!.map((x) => x)),
      isInit: json["is_init"],
      isVirtualStock: json["is_virtual_stock"],
      productDetails: json["productDetails"],
      promotionInfo: json["promotionInfo"] == null
          ? []
          : List<dynamic>.from(json["promotionInfo"]!.map((x) => x)),
      promotion: json["promotion"],
      parentId: json["parent_id"],
      colorImage: json["color_image"],
      productRelationId: json["productRelationID"],
      retailPrice: json["retailPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailPrice"]),
      businessModel: json["business_model"],
      storeCode: json["store_code"],
      salePrice: json["salePrice"] == null
          ? null
          : DiscountPrice.fromJson(json["salePrice"]),
      unitDiscount: json["unit_discount"],
      isClearance: json["is_clearance"],
      limitCount: json["limit_count"],
      flashGoods: json["flash_goods"],
      isPriceConfigured: json["isPriceConfigured"],
      rewardPoints: json["rewardPoints"],
      doublePoints: json["doublePoints"],
      comment: json["comment"] == null
          ? null
          : Comment.fromJson(json["comment"]),
      isSubscription: json["is_subscription"],
      isPreSale: json["is_pre_sale"],
      isPreSaleEnd: json["is_pre_sale_end"],
      isStockEnough: json["is_stock_enough"],
      goodsThumb: json["goods_thumb"],
      goodsImg: json["goods_img"],
      goodsImgWebp: json["goods_img_webp"],
      originalImgWebp: json["original_img_webp"],
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x)),
            ),
      mallCode: json["mall_code"],
      srpPrice: json["srpPrice"],
      srpDiscount: json["srpDiscount"],
      showSrpDiscount: json["showSrpDiscount"],
      retailDiscountPrice: json["retailDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      retailOriginalDiscountPrice: json["retailOriginalDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailOriginalDiscountPrice"]),
      retailVipDiscountPrice: json["retailVipDiscountPrice"],
      retailDiscountValue: json["retailDiscountValue"],
      retailDiscountPercent: json["retailDiscountPercent"],
      retailOriginalDiscount: json["retailOriginalDiscount"],
      isNewCoupon: json["isNewCoupon"],
      discountPrice: json["discountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["discountPrice"]),
      voucherDiscountPrice: json["voucherDiscountPrice"],
      promotionStatus: json["promotion_status"],
      promotionLogoType: json["promotion_logo_type"],
      originalDiscount: json["original_discount"],
      originalDiscountPrice: json["original_discount_price"] == null
          ? null
          : DiscountPrice.fromJson(json["original_discount_price"]),
      prevDiscountValue: json["prev_discount_value"],
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      unitDiscountString: json["unitDiscountString"],
      mallPrice: json["mall_price"] == null
          ? []
          : List<MallPrice>.from(
              json["mall_price"]!.map((x) => MallPrice.fromJson(x)),
            ),
      mallList: json["mallList"] == null
          ? []
          : List<MallList>.from(
              json["mallList"]!.map((x) => MallList.fromJson(x)),
            ),
      mallSource: json["mallSource"],
      priceSku: json["priceSku"],
      productUrl: json["productUrl"],
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

class DiscountPrice {
  DiscountPrice({
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

  factory DiscountPrice.fromJson(Map<String, dynamic> json) {
    return DiscountPrice(
      amount: json["amount"],
      amountWithSymbol: json["amountWithSymbol"],
      usdAmount: json["usdAmount"],
      usdAmountWithSymbol: json["usdAmountWithSymbol"],
      amountSimpleText: json["amountSimpleText"],
    );
  }
}

class MallList {
  MallList({
    required this.mallCode,
    required this.stock,
    required this.mallCodeSort,
  });

  final String? mallCode;
  final int? stock;
  final int? mallCodeSort;

  factory MallList.fromJson(Map<String, dynamic> json) {
    return MallList(
      mallCode: json["mall_code"],
      stock: json["stock"],
      mallCodeSort: json["mall_code_sort"],
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
    required this.unitDiscountString,
  });

  final dynamic srpPrice;
  final int? srpDiscount;
  final int? showSrpDiscount;
  final String? mallCode;
  final DiscountPrice? retailPrice;
  final DiscountPrice? retailDiscountPrice;
  final DiscountPrice? retailOriginalDiscountPrice;
  final DiscountPrice? retailVipDiscountPrice;
  final String? retailDiscountValue;
  final int? retailDiscountPercent;
  final int? retailOriginalDiscount;
  final DiscountPrice? salePrice;
  final dynamic suggestedSalePrice;
  final int? isInversion;
  final int? isNewCoupon;
  final DiscountPrice? discountPrice;
  final dynamic voucherDiscountPrice;
  final int? unitDiscount;
  final dynamic promotionStatus;
  final dynamic promotionLogoType;
  final String? originalDiscount;
  final DiscountPrice? originalDiscountPrice;
  final DiscountPrice? prevDiscountValue;
  final List<dynamic> couponPrices;
  final String? unitDiscountString;

  factory MallPrice.fromJson(Map<String, dynamic> json) {
    return MallPrice(
      srpPrice: json["srpPrice"],
      srpDiscount: json["srpDiscount"],
      showSrpDiscount: json["showSrpDiscount"],
      mallCode: json["mall_code"],
      retailPrice: json["retailPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailPrice"]),
      retailDiscountPrice: json["retailDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      retailOriginalDiscountPrice: json["retailOriginalDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailOriginalDiscountPrice"]),
      retailVipDiscountPrice: json["retailVipDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailVipDiscountPrice"]),
      retailDiscountValue: json["retailDiscountValue"],
      retailDiscountPercent: json["retailDiscountPercent"],
      retailOriginalDiscount: json["retailOriginalDiscount"],
      salePrice: json["salePrice"] == null
          ? null
          : DiscountPrice.fromJson(json["salePrice"]),
      suggestedSalePrice: json["suggestedSalePrice"],
      isInversion: json["isInversion"],
      isNewCoupon: json["isNewCoupon"],
      discountPrice: json["discountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["discountPrice"]),
      voucherDiscountPrice: json["voucherDiscountPrice"],
      unitDiscount: json["unit_discount"],
      promotionStatus: json["promotion_status"],
      promotionLogoType: json["promotion_logo_type"],
      originalDiscount: json["original_discount"],
      originalDiscountPrice: json["original_discount_price"] == null
          ? null
          : DiscountPrice.fromJson(json["original_discount_price"]),
      prevDiscountValue: json["prev_discount_value"] == null
          ? null
          : DiscountPrice.fromJson(json["prev_discount_value"]),
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      unitDiscountString: json["unitDiscountString"],
    );
  }
}

class Variant {
  Variant({
    required this.goodsId,
    required this.goodsRelationId,
    required this.catId,
    required this.goodsSn,
    required this.goodsUrlName,
    required this.goodsName,
    required this.goodsColorImage,
    required this.originalImg,
    required this.businessModel,
    required this.storeCode,
    required this.spuImage,
    required this.goodsThumb,
    required this.goodsImg,
    required this.mallCode,
    required this.srpPrice,
    required this.srpDiscount,
    required this.showSrpDiscount,
    required this.retailPrice,
    required this.retailDiscountPrice,
    required this.retailOriginalDiscountPrice,
    required this.retailVipDiscountPrice,
    required this.retailDiscountValue,
    required this.retailDiscountPercent,
    required this.retailOriginalDiscount,
    required this.salePrice,
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
    required this.unitDiscountString,
    required this.mallPrice,
    required this.mallList,
    required this.mallSource,
    required this.priceSku,
    required this.productUrl,
  });

  final String? goodsId;
  final String? goodsRelationId;
  final String? catId;
  final String? goodsSn;
  final String? goodsUrlName;
  final String? goodsName;
  final String? goodsColorImage;
  final String? originalImg;
  final int? businessModel;
  final int? storeCode;
  final String? spuImage;
  final String? goodsThumb;
  final String? goodsImg;
  final String? mallCode;
  final dynamic srpPrice;
  final int? srpDiscount;
  final int? showSrpDiscount;
  final DiscountPrice? retailPrice;
  final DiscountPrice? retailDiscountPrice;
  final DiscountPrice? retailOriginalDiscountPrice;
  final DiscountPrice? retailVipDiscountPrice;
  final String? retailDiscountValue;
  final int? retailDiscountPercent;
  final int? retailOriginalDiscount;
  final DiscountPrice? salePrice;
  final int? isNewCoupon;
  final DiscountPrice? discountPrice;
  final dynamic voucherDiscountPrice;
  final int? unitDiscount;
  final dynamic promotionStatus;
  final dynamic promotionLogoType;
  final String? originalDiscount;
  final DiscountPrice? originalDiscountPrice;
  final DiscountPrice? prevDiscountValue;
  final List<dynamic> couponPrices;
  final String? unitDiscountString;
  final List<MallPrice> mallPrice;
  final List<MallList> mallList;
  final String? mallSource;
  final String? priceSku;
  final String? productUrl;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      goodsId: json["goods_id"],
      goodsRelationId: json["goods_relation_id"],
      catId: json["cat_id"],
      goodsSn: json["goods_sn"],
      goodsUrlName: json["goods_url_name"],
      goodsName: json["goods_name"],
      goodsColorImage: json["goods_color_image"],
      originalImg: json["original_img"],
      businessModel: json["business_model"],
      storeCode: json["store_code"],
      spuImage: json["spu_image"],
      goodsThumb: json["goods_thumb"],
      goodsImg: json["goods_img"],
      mallCode: json["mall_code"],
      srpPrice: json["srpPrice"],
      srpDiscount: json["srpDiscount"],
      showSrpDiscount: json["showSrpDiscount"],
      retailPrice: json["retailPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailPrice"]),
      retailDiscountPrice: json["retailDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailDiscountPrice"]),
      retailOriginalDiscountPrice: json["retailOriginalDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailOriginalDiscountPrice"]),
      retailVipDiscountPrice: json["retailVipDiscountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["retailVipDiscountPrice"]),
      retailDiscountValue: json["retailDiscountValue"],
      retailDiscountPercent: json["retailDiscountPercent"],
      retailOriginalDiscount: json["retailOriginalDiscount"],
      salePrice: json["salePrice"] == null
          ? null
          : DiscountPrice.fromJson(json["salePrice"]),
      isNewCoupon: json["isNewCoupon"],
      discountPrice: json["discountPrice"] == null
          ? null
          : DiscountPrice.fromJson(json["discountPrice"]),
      voucherDiscountPrice: json["voucherDiscountPrice"],
      unitDiscount: json["unit_discount"],
      promotionStatus: json["promotion_status"],
      promotionLogoType: json["promotion_logo_type"],
      originalDiscount: json["original_discount"],
      originalDiscountPrice: json["original_discount_price"] == null
          ? null
          : DiscountPrice.fromJson(json["original_discount_price"]),
      prevDiscountValue: json["prev_discount_value"] == null
          ? null
          : DiscountPrice.fromJson(json["prev_discount_value"]),
      couponPrices: json["coupon_prices"] == null
          ? []
          : List<dynamic>.from(json["coupon_prices"]!.map((x) => x)),
      unitDiscountString: json["unitDiscountString"],
      mallPrice: json["mall_price"] == null
          ? []
          : List<MallPrice>.from(
              json["mall_price"]!.map((x) => MallPrice.fromJson(x)),
            ),
      mallList: json["mallList"] == null
          ? []
          : List<MallList>.from(
              json["mallList"]!.map((x) => MallList.fromJson(x)),
            ),
      mallSource: json["mallSource"],
      priceSku: json["priceSku"],
      productUrl: json["productUrl"],
    );
  }
}
