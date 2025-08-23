class ItemDetelis {
  String? welcomedeal;
  ProductInfoComponent? productInfoComponent;
  SkuComponent? skuComponent;
  PriceComponent? priceComponent;
  CurrencyComponent? currencyComponent;
  SellerComponent? sellerComponent;
  MultiLanguageUrlComponent? multiLanguageUrlComponent;
  ImageComponent? imageComponent;

  ItemDetelis({
    this.welcomedeal,
    this.productInfoComponent,
    this.skuComponent,
    this.priceComponent,
    this.currencyComponent,
    this.sellerComponent,
    this.multiLanguageUrlComponent,
    this.imageComponent,
  });

  ItemDetelis.fromJson(Map<String, dynamic> json) {
    welcomedeal = json['welcomedeal'];
    productInfoComponent = json['productInfoComponent'] != null
        ? ProductInfoComponent.fromJson(json['productInfoComponent'])
        : null;
    skuComponent = json['skuComponent'] != null
        ? SkuComponent.fromJson(json['skuComponent'])
        : null;
    priceComponent = json['priceComponent'] != null
        ? PriceComponent.fromJson(json['priceComponent'])
        : null;
    currencyComponent = json['currencyComponent'] != null
        ? CurrencyComponent.fromJson(json['currencyComponent'])
        : null;
    sellerComponent = json['sellerComponent'] != null
        ? SellerComponent.fromJson(json['sellerComponent'])
        : null;
    multiLanguageUrlComponent = json['multiLanguageUrlComponent'] != null
        ? MultiLanguageUrlComponent.fromJson(json['multiLanguageUrlComponent'])
        : null;
    imageComponent = json['imageComponent'] != null
        ? ImageComponent.fromJson(json['imageComponent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['welcomedeal'] = welcomedeal;
    if (productInfoComponent != null) {
      data['productInfoComponent'] = productInfoComponent!.toJson();
    }
    if (skuComponent != null) {
      data['skuComponent'] = skuComponent!.toJson();
    }
    if (priceComponent != null) {
      data['priceComponent'] = priceComponent!.toJson();
    }
    if (currencyComponent != null) {
      data['currencyComponent'] = currencyComponent!.toJson();
    }
    if (sellerComponent != null) {
      data['sellerComponent'] = sellerComponent!.toJson();
    }
    if (multiLanguageUrlComponent != null) {
      data['multiLanguageUrlComponent'] = multiLanguageUrlComponent!.toJson();
    }
    if (imageComponent != null) {
      data['imageComponent'] = imageComponent!.toJson();
    }
    return data;
  }
}

class ProductInfoComponent {
  int? categoryId;
  String? subject;
  List<String>? imageList;
  PackageInfo? packageInfo;
  String? productId;
  Video? video;

  ProductInfoComponent({
    this.categoryId,
    this.subject,
    this.imageList,
    this.packageInfo,
    this.productId,
    this.video,
  });

  ProductInfoComponent.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    subject = json['subject'];
    imageList = json['imageList'].cast<String>();
    packageInfo = json['packageInfo'] != null
        ? PackageInfo.fromJson(json['packageInfo'])
        : null;
    productId = json['productId'];
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['subject'] = subject;
    data['imageList'] = imageList;
    if (packageInfo != null) {
      data['packageInfo'] = packageInfo!.toJson();
    }
    data['productId'] = productId;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class PackageInfo {
  int? height;
  int? length;
  double? weight;
  int? width;

  PackageInfo({this.height, this.length, this.weight, this.width});

  PackageInfo.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    length = json['length'];
    weight = (json['weight'] as num?)?.toDouble();
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['length'] = length;
    data['weight'] = weight;
    data['width'] = width;
    return data;
  }
}

class Video {
  String? posterUrl;
  int? videoId;
  String? videoUrl;

  Video({this.posterUrl, this.videoId, this.videoUrl});

  Video.fromJson(Map<String, dynamic> json) {
    posterUrl = json['posterUrl'];
    videoId = json['videoId'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posterUrl'] = posterUrl;
    data['videoId'] = videoId;
    data['videoUrl'] = videoUrl;
    return data;
  }
}

class SkuComponent {
  List<ProductSKUPropertyList>? productSKUPropertyList;

  SkuComponent({this.productSKUPropertyList});

  SkuComponent.fromJson(Map<String, dynamic> json) {
    if (json['productSKUPropertyList'] != null) {
      productSKUPropertyList = <ProductSKUPropertyList>[];
      json['productSKUPropertyList'].forEach((v) {
        productSKUPropertyList!.add(ProductSKUPropertyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productSKUPropertyList != null) {
      data['productSKUPropertyList'] = productSKUPropertyList!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ProductSKUPropertyList {
  String? skuPropertyName;
  String? skuPropertyId;
  int? order;
  String? showType;
  bool? showTypeColor;
  bool? sizeProperty;
  bool? isNewStandardSizeChart;
  List<SkuPropertyValues>? skuPropertyValues;

  ProductSKUPropertyList({
    this.skuPropertyName,
    this.skuPropertyId,
    this.order,
    this.showType,
    this.showTypeColor,
    this.sizeProperty,
    this.isNewStandardSizeChart,
    this.skuPropertyValues,
  });

  ProductSKUPropertyList.fromJson(Map<String, dynamic> json) {
    skuPropertyName = json['skuPropertyName'];
    skuPropertyId = json['skuPropertyId'];
    order = json['order'];
    showType = json['showType'];
    showTypeColor = json['showTypeColor'];
    sizeProperty = json['sizeProperty'];
    isNewStandardSizeChart = json['isNewStandardSizeChart'];
    if (json['skuPropertyValues'] != null) {
      skuPropertyValues = <SkuPropertyValues>[];
      json['skuPropertyValues'].forEach((v) {
        skuPropertyValues!.add(SkuPropertyValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skuPropertyName'] = skuPropertyName;
    data['skuPropertyId'] = skuPropertyId;
    data['order'] = order;
    data['showType'] = showType;
    data['showTypeColor'] = showTypeColor;
    data['sizeProperty'] = sizeProperty;
    data['isNewStandardSizeChart'] = isNewStandardSizeChart;
    if (skuPropertyValues != null) {
      data['skuPropertyValues'] = skuPropertyValues!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class SkuPropertyValues {
  int? propertyValueId;
  String? propertyValueName;
  int? propertyValueIdLong;
  String? propertyValueDisplayName;
  int? skuPropertyValueShowOrder;
  String? skuPropertyTips;
  String? skuPropertyValueTips;
  String? skuPropertyImagePath;
  String? skuPropertyImageSummPath;

  SkuPropertyValues({
    this.propertyValueId,
    this.propertyValueName,
    this.propertyValueIdLong,
    this.propertyValueDisplayName,
    this.skuPropertyValueShowOrder,
    this.skuPropertyTips,
    this.skuPropertyValueTips,
    this.skuPropertyImagePath,
    this.skuPropertyImageSummPath,
  });

  SkuPropertyValues.fromJson(Map<String, dynamic> json) {
    propertyValueId = json['propertyValueId'];
    propertyValueName = json['propertyValueName'];
    propertyValueIdLong = json['propertyValueIdLong'];
    propertyValueDisplayName = json['propertyValueDisplayName'];
    skuPropertyValueShowOrder = json['skuPropertyValueShowOrder'];
    skuPropertyTips = json['skuPropertyTips'];
    skuPropertyValueTips = json['skuPropertyValueTips'];
    skuPropertyImagePath = json['skuPropertyImagePath'];
    skuPropertyImageSummPath = json['skuPropertyImageSummPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyValueId'] = propertyValueId;
    data['propertyValueName'] = propertyValueName;
    data['propertyValueIdLong'] = propertyValueIdLong;
    data['propertyValueDisplayName'] = propertyValueDisplayName;
    data['skuPropertyValueShowOrder'] = skuPropertyValueShowOrder;
    data['skuPropertyTips'] = skuPropertyTips;
    data['skuPropertyValueTips'] = skuPropertyValueTips;
    data['skuPropertyImagePath'] = skuPropertyImagePath;
    data['skuPropertyImageSummPath'] = skuPropertyImageSummPath;
    return data;
  }
}

class PriceComponent {
  List<SkuPriceList>? skuPriceList;

  PriceComponent({this.skuPriceList});

  PriceComponent.fromJson(Map<String, dynamic> json) {
    if (json['skuPriceList'] != null) {
      skuPriceList = <SkuPriceList>[];
      json['skuPriceList'].forEach((v) {
        skuPriceList!.add(SkuPriceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (skuPriceList != null) {
      data['skuPriceList'] = skuPriceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkuPriceList {
  String? skuId;
  String? skuPropIds;
  String? skuAttr;
  SkuVal? skuVal;

  SkuPriceList({this.skuId, this.skuPropIds, this.skuAttr, this.skuVal});

  SkuPriceList.fromJson(Map<String, dynamic> json) {
    skuId = json['skuId'];
    skuPropIds = json['skuPropIds'];
    skuAttr = json['skuAttr'];
    skuVal = json['skuVal'] != null ? SkuVal.fromJson(json['skuVal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skuId'] = skuId;
    data['skuPropIds'] = skuPropIds;
    data['skuAttr'] = skuAttr;
    if (skuVal != null) {
      data['skuVal'] = skuVal!.toJson();
    }
    return data;
  }
}

class SkuVal {
  SkuAmount? skuAmount;
  SkuAmount? skuActivityAmount;
  String? discountTips;
  int? availQuantity;

  SkuVal({
    this.skuAmount,
    this.skuActivityAmount,
    this.discountTips,
    this.availQuantity,
  });

  SkuVal.fromJson(Map<String, dynamic> json) {
    skuAmount = json['skuAmount'] != null
        ? SkuAmount.fromJson(json['skuAmount'])
        : null;
    skuActivityAmount = json['skuActivityAmount'] != null
        ? SkuAmount.fromJson(json['skuActivityAmount'])
        : null;
    discountTips = json['discountTips'];
    availQuantity = json['availQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (skuAmount != null) {
      data['skuAmount'] = skuAmount!.toJson();
    }
    if (skuActivityAmount != null) {
      data['skuActivityAmount'] = skuActivityAmount!.toJson();
    }
    data['discountTips'] = discountTips;
    data['availQuantity'] = availQuantity;
    return data;
  }
}

class SkuAmount {
  String? formatedAmount;
  double? value;

  SkuAmount({this.formatedAmount, this.value});

  SkuAmount.fromJson(Map<String, dynamic> json) {
    formatedAmount = json['formatedAmount'];
    value = (json['value'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatedAmount'] = formatedAmount;
    data['value'] = value;
    return data;
  }
}

class CurrencyComponent {
  String? baseCurrencyCode;
  String? currencyCode;

  CurrencyComponent({this.baseCurrencyCode, this.currencyCode});

  CurrencyComponent.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['baseCurrencyCode'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseCurrencyCode'] = baseCurrencyCode;
    data['currencyCode'] = currencyCode;
    return data;
  }
}

class SellerComponent {
  String? storeName;
  String? sellerAdminSeq;
  String? storeLogo;

  SellerComponent({this.storeName, this.sellerAdminSeq, this.storeLogo});

  SellerComponent.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    sellerAdminSeq = json['sellerAdminSeq'];
    storeLogo = json['storeLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['sellerAdminSeq'] = sellerAdminSeq;
    data['storeLogo'] = storeLogo;
    return data;
  }
}

class MultiLanguageUrlComponent {
  String? itemDetailUrl;

  MultiLanguageUrlComponent({this.itemDetailUrl});

  MultiLanguageUrlComponent.fromJson(Map<String, dynamic> json) {
    itemDetailUrl = json['itemDetailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemDetailUrl'] = itemDetailUrl;
    return data;
  }
}

class ImageComponent {
  List<String>? image640PathList;

  ImageComponent({this.image640PathList});

  ImageComponent.fromJson(Map<String, dynamic> json) {
    image640PathList = json['image640PathList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image640PathList'] = image640PathList;
    return data;
  }
}
