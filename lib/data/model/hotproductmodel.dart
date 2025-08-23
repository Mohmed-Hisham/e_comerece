class Hotproductmodel {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  List<ItemList>? itemList;

  Hotproductmodel({pageIndex, pageSize, totalCount, itemList});

  Hotproductmodel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList!.add(ItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalCount'] = totalCount;
    if (itemList != null) {
      data['itemList'] = itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  String? originalPrice;
  String? productDetailUrl;
  ProductSmallImageUrls? productSmallImageUrls;
  String? secondLevelCategoryName;
  String? targetSalePrice;
  int? secondLevelCategoryId;
  String? discount;
  String? productMainImageUrl;
  int? firstLevelCategoryId;
  String? targetSalePriceCurrency;
  String? taxRate;
  String? originalPriceCurrency;
  String? shopUrl;
  String? targetOriginalPriceCurrency;
  int? productId;
  String? targetOriginalPrice;
  String? productVideoUrl;
  String? firstLevelCategoryName;
  int? skuId;
  String? shopName;
  String? salePrice;
  String? productTitle;
  int? shopId;
  String? salePriceCurrency;
  int? lastestVolume;
  String? appSalePrice;
  String? targetAppSalePriceCurrency;
  String? appSalePriceCurrency;
  String? targetAppSalePrice;
  String? evaluateRate;
  PromoCodeInfo? promoCodeInfo;

  ItemList({
    originalPrice,
    productDetailUrl,
    productSmallImageUrls,
    secondLevelCategoryName,
    targetSalePrice,
    secondLevelCategoryId,
    discount,
    productMainImageUrl,
    firstLevelCategoryId,
    targetSalePriceCurrency,
    taxRate,
    originalPriceCurrency,
    shopUrl,
    targetOriginalPriceCurrency,
    productId,
    targetOriginalPrice,
    productVideoUrl,
    firstLevelCategoryName,
    skuId,
    shopName,
    salePrice,
    productTitle,
    shopId,
    salePriceCurrency,
    lastestVolume,
    appSalePrice,
    targetAppSalePriceCurrency,
    appSalePriceCurrency,
    targetAppSalePrice,
    evaluateRate,
    promoCodeInfo,
  });

  ItemList.fromJson(Map<String, dynamic> json) {
    originalPrice = json['original_price'];
    productDetailUrl = json['product_detail_url'];
    productSmallImageUrls = json['product_small_image_urls'] != null
        ? ProductSmallImageUrls.fromJson(json['product_small_image_urls'])
        : null;
    secondLevelCategoryName = json['second_level_category_name'];
    targetSalePrice = json['target_sale_price'];
    secondLevelCategoryId = json['second_level_category_id'];
    discount = json['discount'];
    productMainImageUrl = json['product_main_image_url'];
    firstLevelCategoryId = json['first_level_category_id'];
    targetSalePriceCurrency = json['target_sale_price_currency'];
    taxRate = json['tax_rate'];
    originalPriceCurrency = json['original_price_currency'];
    shopUrl = json['shop_url'];
    targetOriginalPriceCurrency = json['target_original_price_currency'];
    productId = json['product_id'];
    targetOriginalPrice = json['target_original_price'];
    productVideoUrl = json['product_video_url'];
    firstLevelCategoryName = json['first_level_category_name'];
    skuId = json['sku_id'];
    shopName = json['shop_name'];
    salePrice = json['sale_price'];
    productTitle = json['product_title'];
    shopId = json['shop_id'];
    salePriceCurrency = json['sale_price_currency'];
    lastestVolume = json['lastest_volume'];
    appSalePrice = json['app_sale_price'];
    targetAppSalePriceCurrency = json['target_app_sale_price_currency'];
    appSalePriceCurrency = json['app_sale_price_currency'];
    targetAppSalePrice = json['target_app_sale_price'];
    evaluateRate = json['evaluate_rate'];
    promoCodeInfo = json['promo_code_info'] != null
        ? PromoCodeInfo.fromJson(json['promo_code_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original_price'] = originalPrice;
    data['product_detail_url'] = productDetailUrl;
    if (productSmallImageUrls != null) {
      data['product_small_image_urls'] = productSmallImageUrls!.toJson();
    }
    data['second_level_category_name'] = secondLevelCategoryName;
    data['target_sale_price'] = targetSalePrice;
    data['second_level_category_id'] = secondLevelCategoryId;
    data['discount'] = discount;
    data['product_main_image_url'] = productMainImageUrl;
    data['first_level_category_id'] = firstLevelCategoryId;
    data['target_sale_price_currency'] = targetSalePriceCurrency;
    data['tax_rate'] = taxRate;
    data['original_price_currency'] = originalPriceCurrency;
    data['shop_url'] = shopUrl;
    data['target_original_price_currency'] = targetOriginalPriceCurrency;
    data['product_id'] = productId;
    data['target_original_price'] = targetOriginalPrice;
    data['product_video_url'] = productVideoUrl;
    data['first_level_category_name'] = firstLevelCategoryName;
    data['sku_id'] = skuId;
    data['shop_name'] = shopName;
    data['sale_price'] = salePrice;
    data['product_title'] = productTitle;
    data['shop_id'] = shopId;
    data['sale_price_currency'] = salePriceCurrency;
    data['lastest_volume'] = lastestVolume;
    data['app_sale_price'] = appSalePrice;
    data['target_app_sale_price_currency'] = targetAppSalePriceCurrency;
    data['app_sale_price_currency'] = appSalePriceCurrency;
    data['target_app_sale_price'] = targetAppSalePrice;
    data['evaluate_rate'] = evaluateRate;
    if (promoCodeInfo != null) {
      data['promo_code_info'] = promoCodeInfo!.toJson();
    }
    return data;
  }
}

class ProductSmallImageUrls {
  List<String>? string;

  ProductSmallImageUrls({string});

  ProductSmallImageUrls.fromJson(Map<String, dynamic> json) {
    string = json['string'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['string'] = string;
    return data;
  }
}

class PromoCodeInfo {
  String? codeCampaigntype;
  String? codeAvailabletimeEnd;
  String? codeQuantity;
  String? codeAvailabletimeStart;
  String? codeValue;
  String? promoCode;
  String? codeMiniSpend;

  PromoCodeInfo({
    codeCampaigntype,
    codeAvailabletimeEnd,
    codeQuantity,
    codeAvailabletimeStart,
    codeValue,
    promoCode,
    codeMiniSpend,
  });

  PromoCodeInfo.fromJson(Map<String, dynamic> json) {
    codeCampaigntype = json['code_campaigntype'];
    codeAvailabletimeEnd = json['code_availabletime_end'];
    codeQuantity = json['code_quantity'];
    codeAvailabletimeStart = json['code_availabletime_start'];
    codeValue = json['code_value'];
    promoCode = json['promo_code'];
    codeMiniSpend = json['code_mini_spend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code_campaigntype'] = codeCampaigntype;
    data['code_availabletime_end'] = codeAvailabletimeEnd;
    data['code_quantity'] = codeQuantity;
    data['code_availabletime_start'] = codeAvailabletimeStart;
    data['code_value'] = codeValue;
    data['promo_code'] = promoCode;
    data['code_mini_spend'] = codeMiniSpend;
    return data;
  }
}
