class SearchAmazonModel {
  SearchAmazonModel({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  final String? status;
  final String? requestId;
  final Parameters? parameters;
  final Data? data;

  factory SearchAmazonModel.fromJson(Map<String, dynamic> json) {
    return SearchAmazonModel(
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
    required this.totalProducts,
    required this.country,
    required this.domain,
    required this.products,
  });

  final int? totalProducts;
  final String? country;
  final String? domain;
  final List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      totalProducts: json["total_products"],
      country: json["country"],
      domain: json["domain"],
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
    required this.asin,
    required this.productTitle,
    required this.productPrice,
    required this.productOriginalPrice,
    required this.currency,
    required this.productStarRating,
    required this.productNumRatings,
    required this.productUrl,
    required this.productPhoto,
    required this.productNumOffers,
    required this.productMinimumOfferPrice,
    required this.isBestSeller,
    required this.isAmazonChoice,
    required this.isPrime,
    required this.climatePledgeFriendly,
    required this.salesVolume,
    required this.delivery,
    required this.hasVariations,
    required this.productAvailability,
    required this.productBadge,
    required this.bookFormat,
    required this.productByline,
  });

  final String? asin;
  final String? productTitle;
  final String? productPrice;
  final String? productOriginalPrice;
  final String? currency;
  final String? productStarRating;
  final int? productNumRatings;
  final String? productUrl;
  final String? productPhoto;
  final int? productNumOffers;
  final String? productMinimumOfferPrice;
  final bool? isBestSeller;
  final bool? isAmazonChoice;
  final bool? isPrime;
  final bool? climatePledgeFriendly;
  final String? salesVolume;
  final String? delivery;
  final bool? hasVariations;
  final String? productAvailability;
  final String? productBadge;
  final String? bookFormat;
  final String? productByline;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      asin: json["asin"],
      productTitle: json["product_title"],
      productPrice: json["product_price"],
      productOriginalPrice: json["product_original_price"],
      currency: json["currency"],
      productStarRating: json["product_star_rating"],
      productNumRatings: json["product_num_ratings"],
      productUrl: json["product_url"],
      productPhoto: json["product_photo"],
      productNumOffers: json["product_num_offers"],
      productMinimumOfferPrice: json["product_minimum_offer_price"],
      isBestSeller: json["is_best_seller"],
      isAmazonChoice: json["is_amazon_choice"],
      isPrime: json["is_prime"],
      climatePledgeFriendly: json["climate_pledge_friendly"],
      salesVolume: json["sales_volume"],
      delivery: json["delivery"],
      hasVariations: json["has_variations"],
      productAvailability: json["product_availability"],
      productBadge: json["product_badge"],
      bookFormat: json["book_format"],
      productByline: json["product_byline"],
    );
  }
}

class Parameters {
  Parameters({
    required this.query,
    required this.country,
    required this.sortBy,
    required this.page,
    required this.minPrice,
    required this.maxPrice,
    required this.isPrime,
    required this.language,
  });

  final String? query;
  final String? country;
  final String? sortBy;
  final int? page;
  final int? minPrice;
  final int? maxPrice;
  final bool? isPrime;
  final String? language;

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      query: json["query"],
      country: json["country"],
      sortBy: json["sort_by"],
      page: json["page"],
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      isPrime: json["is_prime"],
      language: json["language"],
    );
  }
}
