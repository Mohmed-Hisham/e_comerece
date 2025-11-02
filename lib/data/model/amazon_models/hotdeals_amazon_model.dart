class HotDealsAmazonModel {
  HotDealsAmazonModel({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  final String? status;
  final String? requestId;
  final Parameters? parameters;
  final Data? data;

  factory HotDealsAmazonModel.fromJson(Map<String, dynamic> json) {
    return HotDealsAmazonModel(
      status: json["status"],
      requestId: json["request_id"],
      parameters: json["parameters"] == null
          ? null
          : Parameters.fromJson(json["parameters"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.deals,
    required this.totalDeals,
    required this.country,
    required this.domain,
  });

  final List<Deal> deals;
  final int? totalDeals;
  final String? country;
  final String? domain;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      deals: json["deals"] == null
          ? []
          : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
      totalDeals: json["total_deals"],
      country: json["country"],
      domain: json["domain"],
    );
  }
}

class Deal {
  Deal({
    required this.dealId,
    required this.dealType,
    required this.dealTitle,
    required this.dealPhoto,
    required this.dealState,
    required this.dealUrl,
    required this.canonicalDealUrl,
    required this.dealStartsAt,
    required this.dealEndsAt,
    required this.dealPrice,
    required this.listPrice,
    required this.savingsPercentage,
    required this.savingsAmount,
    required this.dealBadge,
    required this.type,
    required this.productAsin,
  });

  final String? dealId;
  final String? dealType;
  final String? dealTitle;
  final String? dealPhoto;
  final String? dealState;
  final String? dealUrl;
  final String? canonicalDealUrl;
  final DateTime? dealStartsAt;
  final DateTime? dealEndsAt;
  final DealPrice? dealPrice;
  final DealPrice? listPrice;
  final int? savingsPercentage;
  final DealPrice? savingsAmount;
  final String? dealBadge;
  final String? type;
  final String? productAsin;

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealId: json["deal_id"],
      dealType: json["deal_type"],
      dealTitle: json["deal_title"],
      dealPhoto: json["deal_photo"],
      dealState: json["deal_state"],
      dealUrl: json["deal_url"],
      canonicalDealUrl: json["canonical_deal_url"],
      dealStartsAt: DateTime.tryParse(json["deal_starts_at"] ?? ""),
      dealEndsAt: DateTime.tryParse(json["deal_ends_at"] ?? ""),
      dealPrice: json["deal_price"] == null
          ? null
          : DealPrice.fromJson(json["deal_price"]),
      listPrice: json["list_price"] == null
          ? null
          : DealPrice.fromJson(json["list_price"]),
      savingsPercentage: json["savings_percentage"],
      savingsAmount: json["savings_amount"] == null
          ? null
          : DealPrice.fromJson(json["savings_amount"]),
      dealBadge: json["deal_badge"],
      type: json["type"],
      productAsin: json["product_asin"],
    );
  }
}

class DealPrice {
  DealPrice({required this.amount, required this.currency});

  final String? amount;
  final String? currency;

  factory DealPrice.fromJson(Map<String, dynamic> json) {
    return DealPrice(amount: json["amount"], currency: json["currency"]);
  }
}

class Parameters {
  Parameters({
    required this.country,
    required this.language,
    required this.offset,
    required this.priceRange,
    required this.discountRange,
    required this.numPages,
  });

  final String? country;
  final String? language;
  final int? offset;
  final String? priceRange;
  final String? discountRange;
  final int? numPages;

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      country: json["country"],
      language: json["language"],
      offset: json["offset"],
      priceRange: json["price_range"],
      discountRange: json["discount_range"],
      numPages: json["num_pages"],
    );
  }
}
