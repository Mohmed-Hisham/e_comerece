import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';

/// Extension for TrendingProductsModel providing safe getters and utility methods
extension TrendingProductsModelX on TrendingProductsModel {
  /// Returns true if the API call was successful
  bool get isSuccess => success ?? false;

  /// Returns the response message or empty string
  String get responseMessage => message ?? "";

  /// Returns the products list or empty list
  List<Product> get productsList => data?.products ?? [];

  /// Returns true if there are products available
  bool get hasProducts => productsList.isNotEmpty;

  /// Returns the number of products
  int get productCount => productsList.length;
}

/// Extension for Data providing safe getters
extension DataX on Data {
  /// Returns the products list or empty list
  List<Product> get safeProducts => products;
}

/// Extension for Product providing safe getters and utility methods
extension ProductX on Product {
  /// Returns the main product image URL with proper formatting
  String get mainImageUrl {
    final img = goodsImg ?? "";
    if (img.isEmpty) return "";
    if (img.startsWith("//")) return "https:$img";
    return img;
  }

  /// Returns the product name or "N/A"
  String get productName => goodsName ?? "N/A";

  /// Returns the product ID as string
  String get productId => goodsId ?? "";

  /// Returns the product ID as integer (safe parsing)
  // int get productIdInt => int.tryParse(goodsId ?? "0") ?? 0;

  // /// Returns the product URL name or empty string
  // String get productUrlName => goodsUrlName ?? "";

  // /// Returns the category name or "N/A"
  // String get categoryName => cateName ?? "N/A";

  // /// Returns the category ID as string
  String get categoryId => catId ?? "";

  // /// Returns the stock quantity as string
  // String get stockQuantity => stock ?? "0";

  // /// Returns the stock quantity as integer (safe parsing)
  // int get stockQuantityInt => int.tryParse(stock ?? "0") ?? 0;

  // /// Returns true if product is available (not sold out)
  // bool get isAvailable => !(soldOutStatus ?? true) && (isOnSale ?? 0) == 1;

  // /// Returns true if product is on sale
  // bool get isOnSaleStatus => (isOnSale ?? 0) == 1;

  // /// Returns the retail price formatted or empty string
  // String get retailPriceFormatted => retailPrice?.amountWithSymbol ?? "";

  // /// Returns the retail price as double (safe parsing)
  // double get retailPriceAsDouble {
  //   final amount = retailPrice?.amount ?? "0";
  //   return double.tryParse(amount) ?? 0.0;
  // }

  // /// Returns the sale price formatted or empty string
  // String get salePriceFormatted => salePrice?.amountWithSymbol ?? "";

  // /// Returns the sale price as double (safe parsing)
  // double get salePriceAsDouble {
  //   final amount = salePrice?.amount ?? "0";
  //   return double.tryParse(amount) ?? 0.0;
  // }

  // /// Returns the discount price formatted or empty string
  // String get discountPriceFormatted => discountPrice?.amountWithSymbol ?? "";

  // /// Returns the discount price as double (safe parsing)
  // double get discountPriceAsDouble {
  //   final amount = discountPrice?.amount ?? "0";
  //   return double.tryParse(amount) ?? 0.0;
  // }

  // /// Returns the current display price (sale price if available, otherwise retail)
  // String get displayPrice {
  //   if (salePriceFormatted.isNotEmpty) return salePriceFormatted;
  //   return retailPriceFormatted;
  // }

  // /// Returns the current display price as double
  // double get displayPriceAsDouble {
  //   if (salePriceAsDouble > 0) return salePriceAsDouble;
  //   return retailPriceAsDouble;
  // }

  // /// Returns true if product has a discount
  // bool get hasDiscount =>
  //     discountPriceAsDouble > 0 && discountPriceAsDouble < retailPriceAsDouble;

  // /// Returns the discount percentage as string
  // String get discountPercentage => retailDiscountPercent ?? "0";

  // /// Returns the discount percentage as double (safe parsing)
  // double get discountPercentageAsDouble {
  //   final percent = retailDiscountPercent ?? "0";
  //   return double.tryParse(percent) ?? 0.0;
  // }

  // /// Returns all product images as list of URLs
  // List<String> get allImageUrls {
  //   final images = <String>[];

  //   // Add main image
  //   if (mainImageUrl.isNotEmpty) images.add(mainImageUrl);

  //   // Add SPU images
  //   final spuImages = spuImagesList;
  //   for (final img in spuImages) {
  //     if (img.isNotEmpty) images.add(img);
  //   }

  //   // Add detail images
  //   final detailImages = detailImageList;
  //   for (final img in detailImages) {
  //     if (img.isNotEmpty) images.add(img);
  //   }

  //   // Add color images
  //   final colorImages = relatedColorImages;
  //   for (final img in colorImages) {
  //     if (img.isNotEmpty) images.add(img);
  //   }

  //   return images;
  // }

  // /// Returns true if product has images
  // bool get hasImages => allImageUrls.isNotEmpty;

  // /// Returns the first available image URL
  // String get firstImage => allImageUrls.isNotEmpty ? allImageUrls.first : "";

  // /// Returns SPU images list or empty list
  // List<String> get spuImagesList => spuImages?.spuImages ?? [];

  // /// Returns detail images list or empty list
  // List<String> get detailImageList => detailImage;

  // /// Returns related color images
  List<String> get relatedColorImages {
    return relatedColorNew
        .map((color) {
          final img = color.colorImage ?? "";
          if (img.isEmpty) return "";
          if (img.startsWith("//")) return "https:$img";
          return img;
        })
        .where((img) => img.isNotEmpty)
        .toList();
  }

  // /// Returns the comment count as integer (safe parsing)
  // int get commentCount => commentNum ?? 0;

  // /// Returns the comment count display text
  // String get commentCountText => commentNumShow ?? "0";

  // /// Returns the comment rank average as double (safe parsing)
  double get commentRankAverageValue =>
      double.tryParse(commentRankAverage ?? "0") ?? 0.0;

  // /// Returns true if product has comments
  // bool get hasComments => commentCount > 0;

  // /// Returns the product URL or empty string
  // String get productUrl => productUrl;

  // /// Returns the video URL or empty string
  // String get videoUrl => videoUrl;

  // /// Returns true if product has video
  // bool get hasVideo => videoUrl.isNotEmpty;

  // /// Returns the unit of measurement or empty string
  // String get unit => unit;

  // /// Returns the business model or empty string
  // String get businessModel => businessModel;

  // /// Returns the store code or empty string
  // String get storeCode => storeCode;

  // /// Returns the mall code or empty string
  // String get mallCode => mallCode;

  // /// Returns the product relation ID or empty string
  // String get productRelationId => productRelationId;

  // /// Returns the local goods ID or empty string
  // String get localGoodsId => localGoodsId;

  // /// Returns the goods SN or empty string
  // String get goodsSn => goodsSn;

  // /// Returns the SPU or empty string
  // String get spu => spu;

  // /// Returns true if product is single SKU
  // bool get isSingleSkuStatus => isSingleSku == "1";

  // /// Returns true if product is clearance
  // bool get isClearanceStatus => isClearance == "1";

  // /// Returns true if product shows plus size
  // bool get isShowPlusSizeStatus => isShowPlusSize == "1";

  // /// Returns the item source or empty string
  // String get itemSource => itemSource;

  // /// Returns the reorder value or empty string
  // String get reorder => reorder;

  // /// Returns the from SKU code or empty string
  // String get fromSkuCode => fromSkuCode;

  // /// Returns the goods color image URL with proper formatting
  // String get goodsColorImageUrl {
  //   final img = goodsColorImage ?? "";
  //   if (img.isEmpty) return "";
  //   if (img.startsWith("//")) return "https:$img";
  //   return img;
  // }

  // /// Returns true if product has color variants
  // bool get hasColorVariants => relatedColorNew.isNotEmpty;

  // /// Returns the number of color variants
  // int get colorVariantCount => relatedColorNew.length;

  // /// Returns the promotion info list or empty list
  // List<PromotionInfo> get promotionInfoList => promotionInfo;

  // /// Returns true if product has promotions
  // bool get hasPromotions => promotionInfo.isNotEmpty;

  // /// Returns the product sales label or null
  // ProductSalesLabel? get salesLabel => productSalesLabel;

  // /// Returns the premium flag info or null
  PremiumFlagNew? get premiumInfo => premiumFlagNew;

  // /// Returns true if product has premium flag
  // bool get isPremium => premiumInfo != null;

  // /// Returns the brand name or empty string
  String get brandName => premiumInfo?.brandName ?? "";

  // /// Returns the brand code or empty string
  // String get brandCode => premiumInfo?.brandCode ?? "";

  // /// Returns the series name or empty string
  // String get seriesName => premiumInfo?.seriesBadgeName ?? "";

  // /// Returns the brand logo URL (left) with proper formatting
  // String get brandLogoUrlLeft {
  //   final img = premiumInfo?.brandLogoUrlLeft ?? "";
  //   if (img.isEmpty) return "";
  //   if (img.startsWith("//")) return "https:$img";
  //   return img;
  // }

  // /// Returns the brand logo URL (right) with proper formatting
  // String get brandLogoUrlRight {
  //   final img = premiumInfo?.brandLogoUrlRight ?? "";
  //   if (img.isEmpty) return "";
  //   if (img.startsWith("//")) return "https:$img";
  //   return img;
  // }
}

// /// Extension for DiscountPrice providing safe getters
// extension DiscountPriceX on DiscountPrice {
//   /// Returns the amount as double (safe parsing)
//   double get amountAsDouble => double.tryParse(amount ?? "0") ?? 0.0;

//   /// Returns the USD amount as double (safe parsing)
//   double get usdAmountAsDouble => double.tryParse(usdAmount ?? "0") ?? 0.0;

//   /// Returns the formatted amount with symbol
//   String get formattedAmount => amountWithSymbol ?? "";

//   /// Returns the formatted USD amount with symbol
//   String get formattedUsdAmount => usdAmountWithSymbol ?? "";
// }

// /// Extension for RelatedColorNew providing safe getters
// extension RelatedColorNewX on RelatedColorNew {
//   /// Returns the color image URL with proper formatting
//   String get colorImageUrl {
//     final img = colorImage ?? "";
//     if (img.isEmpty) return "";
//     if (img.startsWith("//")) return "https:$img";
//     return img;
//   }

//   /// Returns the color name or empty string
//   String get colorName => skcName ?? "";

//   /// Returns the goods ID as string
//   String get goodsIdString => goodsId?.toString() ?? "";

//   /// Returns the goods ID as integer (safe parsing)
//   int get goodsIdInt => int.tryParse(goodsIdString) ?? 0;
// }

// /// Extension for SpuImages providing safe getters
// extension SpuImagesX on SpuImages {
//   /// Returns the SPU images list or empty list
//   List<String> get imagesList => spuImages;

//   /// Returns true if has SPU images
//   bool get hasImages => spuImages.isNotEmpty;

//   /// Returns the first SPU image URL
//   String get firstImage => spuImages.isNotEmpty ? spuImages.first : "";

//   /// Returns the track info or empty string
//   String get trackInfoText => trackInfo ?? "";
// }

// /// Extension for PromotionInfo providing safe getters
// extension PromotionInfoX on PromotionInfo {
//   /// Returns the promotion ID as string
//   String get promotionId => id ?? "";

//   /// Returns the promotion ID as integer (safe parsing)
//   int get promotionIdInt => int.tryParse(id ?? "0") ?? 0;

//   /// Returns the promotion subject or empty string
//   String get promotionSubject => subject ?? "";

//   /// Returns the promotion type ID or empty string
//   String get promotionTypeId => typeId ?? "";

//   /// Returns the end time as DateTime
//   DateTime? get endDateTime => endTime;

//   /// Returns true if promotion is active (not ended)
//   bool get isActive => endDateTime?.isAfter(DateTime.now()) ?? false;

//   /// Returns the discount value as double (safe parsing)
//   double get discountValueAsDouble =>
//       double.tryParse(discountValue ?? "0") ?? 0.0;

//   /// Returns the buy limit as integer (safe parsing)
//   int get buyLimitInt => int.tryParse(buyLimit ?? "0") ?? 0;

//   /// Returns the sold number as integer (safe parsing)
//   int get soldNumberInt => int.tryParse(soldNum ?? "0") ?? 0;

//   /// Returns true if promotion has buy limit
//   bool get hasBuyLimit => buyLimitInt > 0;

//   /// Returns true if promotion is over
//   bool get isOver => isOver == "1";

//   /// Returns the promotion tips text or empty string
//   String get tipsText => tips?.text ?? "";

//   /// Returns the language key or empty string
//   String get languageKey => languageKey;

//   /// Returns the channel type or empty string
//   String get channelType => channelType;

//   /// Returns the flash type or empty string
//   String get flashType => flashType;

//   /// Returns true if it's a flash sale
//   bool get isFlashSaleStatus => flashType.isNotEmpty;

//   /// Returns the rules list or empty list
//   List<Rule> get rulesList => rules;

//   /// Returns true if promotion has rules
//   bool get hasRules => rules.isNotEmpty;
// }

// /// Extension for Rule providing safe getters
// extension RuleX on Rule {
//   /// Returns the rule type as integer
//   int get ruleType => type ?? 0;

//   /// Returns the rule value as integer
//   int get ruleValue => value ?? 0;

//   /// Returns the rule value as double
//   double get ruleValueAsDouble => value?.toDouble() ?? 0.0;

//   /// Returns the max discount as integer
//   int get maxDiscountInt => maxDiscount ?? 0;

//   /// Returns the max discount as double
//   double get maxDiscountAsDouble => maxDiscount?.toDouble() ?? 0.0;

//   /// Returns the value amount as double (safe parsing)
//   double get valueAmountAsDouble => valueAmount?.amountAsDouble ?? 0.0;

//   /// Returns the formatted value amount
//   String get formattedValueAmount => valueAmount?.formattedAmount ?? "";

//   /// Returns the max discount amount as double (safe parsing)
//   double get maxDiscountAmountAsDouble =>
//       maxDiscountAmount?.amountAsDouble ?? 0.0;

//   /// Returns the formatted max discount amount
//   String get formattedMaxDiscountAmount =>
//       maxDiscountAmount?.formattedAmount ?? "";

//   /// Returns the discount info or null
//   Discount? get discountInfo => discount;

//   /// Returns the discount value as double (safe parsing)
//   double get discountValueAsDouble => discount?.value ?? 0.0;

//   /// Returns the discount type as integer
//   int get discountType => discount?.type ?? 0;

//   /// Returns the enjoy goods number as integer
//   int get enjoyGoodsNumber => discount?.enjoyGoodsNum ?? 0;
// }

// /// Extension for Discount providing safe getters
// extension DiscountX on Discount {
//   /// Returns the discount value as double
//   double get discountValue => value ?? 0.0;

//   /// Returns the discount type as integer
//   int get discountType => type ?? 0;

//   /// Returns the enjoy goods number as integer
//   int get enjoyGoodsNumber => enjoyGoodsNum ?? 0;

//   /// Returns the value amount as double (safe parsing)
//   double get valueAmountAsDouble => valueAmount?.amountAsDouble ?? 0.0;

//   /// Returns the formatted value amount
//   String get formattedValueAmount => valueAmount?.formattedAmount ?? "";

//   /// Returns the gift coupons list or empty list
//   List<dynamic> get giftCouponsList => giftCoupons;

//   /// Returns true if has gift coupons
//   bool get hasGiftCoupons => giftCoupons.isNotEmpty;
// }

// Example usage:
/*
// In a widget or controller:
final trendingProducts = TrendingProductsModel.fromJson(jsonData);

// Check if API call was successful and has products
if (trendingProducts.isSuccess && trendingProducts.hasProducts) {
  final firstProduct = trendingProducts.productsList.first;
  
  // Display product information safely
  print('Product: ${firstProduct.productName}');
  print('Price: ${firstProduct.displayPrice}');
  print('Image: ${firstProduct.firstImage}');
  print('Available: ${firstProduct.isAvailable}');
  print('Has Discount: ${firstProduct.hasDiscount}');
  
  // Show product details
  if (firstProduct.hasImages) {
    // Display product images
    firstProduct.allImageUrls.forEach((imageUrl) {
      // Load and display image
    });
  }
  
  // Check promotions
  if (firstProduct.hasPromotions) {
    final promotion = firstProduct.promotionInfoList.first;
    print('Promotion: ${promotion.promotionSubject}');
    print('Discount: ${promotion.discountValueAsDouble}%');
    print('Active: ${promotion.isActive}');
  }
}
*/
