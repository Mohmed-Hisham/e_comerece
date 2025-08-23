import 'dart:convert';

class ShearchNameModel {
  int? pageIndex;
  String? pageSize;
  int? totalCount;
  List<ItemList>? itemList;

  ShearchNameModel({
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.itemList,
  });

  ShearchNameModel.fromJson(Map<String, dynamic> json) {
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
  String? originalPriceCurrency;
  String? salePrice;
  String? discount;
  String? itemMainPic;
  String? title;
  String? type;
  String? score;
  String? itemId;
  String? targetSalePrice;
  String? cateId;
  String? targetOriginalPriceCurrency;
  OriginMinPrice? originMinPrice; // <<-- تم تغيير النوع
  String? evaluateRate;
  String? salePriceFormat;
  String? orders;
  String? targetOriginalPrice;
  String? salePriceCurrency;

  ItemList({
    this.originalPrice,
    this.originalPriceCurrency,
    this.salePrice,
    this.discount,
    this.itemMainPic,
    this.title,
    this.type,
    this.score,
    this.itemId,
    this.targetSalePrice,
    this.cateId,
    this.targetOriginalPriceCurrency,
    this.originMinPrice,
    this.evaluateRate,
    this.salePriceFormat,
    this.orders,
    this.targetOriginalPrice,
    this.salePriceCurrency,
  });

  ItemList.fromJson(Map<String, dynamic> json) {
    originalPrice = json['originalPrice'];
    originalPriceCurrency = json['originalPriceCurrency'];
    salePrice = json['salePrice'];
    discount = json['discount'];
    itemMainPic = json['itemMainPic'];
    title = json['title'];
    type = json['type'];
    score = json['score'];
    itemId = json['itemId'];
    targetSalePrice = json['targetSalePrice'];
    cateId = json['cateId'];
    targetOriginalPriceCurrency = json['targetOriginalPriceCurrency'];
    if (json['originMinPrice'] != null) {
      // الـ API يرسله أحيانا كنص JSON، لذا يجب فك ترميزه أولاً
      if (json['originMinPrice'] is String) {
        final decodedPrice = jsonDecode(json['originMinPrice']);
        originMinPrice = OriginMinPrice.fromJson(decodedPrice);
      }
      // وأحياناً يرسله كـ Map مباشرة
      else if (json['originMinPrice'] is Map) {
        originMinPrice = OriginMinPrice.fromJson(json['originMinPrice']);
      }
    } else {
      originMinPrice = null;
    }
    evaluateRate = json['evaluateRate'];
    salePriceFormat = json['salePriceFormat'];
    orders = json['orders'];
    targetOriginalPrice = json['targetOriginalPrice'];
    salePriceCurrency = json['salePriceCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['originalPrice'] = originalPrice;
    data['originalPriceCurrency'] = originalPriceCurrency;
    data['salePrice'] = salePrice;
    data['discount'] = discount;
    data['itemMainPic'] = itemMainPic;
    data['title'] = title;
    data['type'] = type;
    data['score'] = score;
    data['itemId'] = itemId;
    data['targetSalePrice'] = targetSalePrice;
    data['cateId'] = cateId;
    data['targetOriginalPriceCurrency'] = targetOriginalPriceCurrency;
    if (originMinPrice != null) {
      data['originMinPrice'] = originMinPrice!.toJson(); // <<-- تم التعديل
    }
    data['evaluateRate'] = evaluateRate;
    data['salePriceFormat'] = salePriceFormat;
    data['orders'] = orders;
    data['targetOriginalPrice'] = targetOriginalPrice;
    data['salePriceCurrency'] = salePriceCurrency;
    return data;
  }
}

// أضف هذا الكلاس الجديد
class OriginMinPrice {
  String? formatPrice;
  // أضف أي حقول أخرى تحتاجها من هذا الكائن
  // String? currencySymbol;
  // int? cent;

  OriginMinPrice({this.formatPrice});

  OriginMinPrice.fromJson(Map<String, dynamic> json) {
    formatPrice = json['formatPrice'];
    // currencySymbol = json['currencySymbol'];
    // cent = json['cent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatPrice'] = formatPrice;
    return data;
  }
}
