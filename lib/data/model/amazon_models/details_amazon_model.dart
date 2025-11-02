class DetailsAmazonModel {
  DetailsAmazonModel({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  final String? status;
  final String? requestId;
  final Parameters? parameters;
  final Data? data;

  factory DetailsAmazonModel.fromJson(Map<String, dynamic> json) {
    return DetailsAmazonModel(
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
    required this.asin,
    required this.productTitle,
    required this.productPrice,
    required this.productOriginalPrice,
    required this.minimumOrderQuantity,
    required this.currency,
    required this.country,
    required this.productByline,
    required this.productBylineLink,
    required this.productBylineLinks,
    required this.productStarRating,
    required this.productNumRatings,
    required this.productUrl,
    required this.productSlug,
    required this.productPhoto,
    required this.productNumOffers,
    required this.productAvailability,
    required this.isBestSeller,
    required this.isAmazonChoice,
    required this.isPrime,
    required this.climatePledgeFriendly,
    required this.salesVolume,
    required this.aboutProduct,
    required this.productDescription,
    required this.productInformation,
    required this.ratingDistribution,
    required this.productPhotos,
    required this.productVideos,
    required this.userUploadedVideos,
    required this.hasVideo,
    required this.productDetails,
    required this.customersSay,
    required this.topReviews,
    required this.topReviewsGlobal,
    required this.delivery,
    required this.primaryDeliveryTime,
    required this.category,
    required this.categoryPath,
    required this.productVariationsDimensions,
    required this.productVariations,
    required this.allProductVariations,
    required this.hasAplus,
    required this.aplusImages,
    required this.hasBrandstory,
    required this.frequentlyBoughtTogether,
    required this.landingAsin,
    required this.parentAsin,
    required couponDiscountPercentage,
  });

  final String? asin;
  final String? productTitle;
  final String? productPrice;
  final String? productOriginalPrice;
  final dynamic minimumOrderQuantity;
  final String? currency;
  final String? country;
  final String? productByline;
  final String? productBylineLink;
  final List<String> productBylineLinks;
  final String? productStarRating;
  final int? productNumRatings;
  final String? productUrl;
  final String? productSlug;
  final String? productPhoto;
  final int? productNumOffers;
  final String? productAvailability;
  final bool? isBestSeller;
  final bool? isAmazonChoice;
  final bool? isPrime;
  final bool? climatePledgeFriendly;
  final String? salesVolume;
  final List<String> aboutProduct;
  final String? productDescription;
  final ProductInformation? productInformation;
  final Map<String, int> ratingDistribution;
  final List<String> productPhotos;
  final List<ProductVideo> productVideos;

  final List<dynamic> userUploadedVideos;
  final bool? hasVideo;
  final ProductDetails? productDetails;
  final String? customersSay;
  final List<TopReview> topReviews;
  final List<TopReview> topReviewsGlobal;
  final String? delivery;
  final String? primaryDeliveryTime;
  final Category? category;
  final List<CategoryPath> categoryPath;
  final List<String> productVariationsDimensions;
  final ProductVariations? productVariations;
  final Map<String, AllProductVariation> allProductVariations;
  final bool? hasAplus;
  final List<String> aplusImages;
  final bool? hasBrandstory;
  final List<FrequentlyBoughtTogether> frequentlyBoughtTogether;
  final String? landingAsin;
  final String? parentAsin;

  // داخل ملف details_amazon_model.dart
  factory Data.fromJson(Map<String, dynamic> json) {
    // product_variations قد تكون Map أو List (مثلاً [])
    final pv = json["product_variations"];
    final ProductVariations? productVariationsParsed =
        (pv is Map<String, dynamic>) ? ProductVariations.fromJson(pv) : null;

    // all_product_variations قد تكون Map أو List/empty - نتعامل آمن
    final apv = json["all_product_variations"];
    final Map<String, AllProductVariation> allProductVariationsParsed =
        (apv is Map<String, dynamic>)
        ? Map.from(apv).map(
            (k, v) => MapEntry(
              k,
              AllProductVariation.fromJson(
                v is Map<String, dynamic> ? v : <String, dynamic>{},
              ),
            ),
          )
        : <String, AllProductVariation>{};

    return Data(
      asin: json["asin"],
      productTitle: json["product_title"],
      productPrice: json["product_price"],
      productOriginalPrice: json["product_original_price"],
      minimumOrderQuantity: json["minimum_order_quantity"],
      currency: json["currency"],
      country: json["country"],
      productByline: json["product_byline"],
      productBylineLink: json["product_byline_link"],
      productBylineLinks: json["product_byline_links"] == null
          ? []
          : List<String>.from(
              json["product_byline_links"]
                  .where((e) => e != null)
                  .map((x) => x.toString()),
            ),
      productStarRating: json["product_star_rating"],
      productNumRatings: json["product_num_ratings"],
      productUrl: json["product_url"],
      productSlug: json["product_slug"],
      productPhoto: json["product_photo"],
      productNumOffers: json["product_num_offers"],
      productAvailability: json["product_availability"],
      isBestSeller: json["is_best_seller"],
      isAmazonChoice: json["is_amazon_choice"],
      isPrime: json["is_prime"],
      climatePledgeFriendly: json["climate_pledge_friendly"],
      salesVolume: json["sales_volume"]?.toString(),
      aboutProduct: json["about_product"] == null
          ? []
          : List<String>.from(json["about_product"].map((x) => x.toString())),
      productDescription: json["product_description"],
      productInformation: json["product_information"] is Map<String, dynamic>
          ? ProductInformation.fromJson(json["product_information"])
          : null,
      ratingDistribution: (json["rating_distribution"] is Map)
          ? Map.from(
              json["rating_distribution"],
            ).map((k, v) => MapEntry<String, int>(k.toString(), v as int))
          : <String, int>{},
      productPhotos: json["product_photos"] == null
          ? []
          : List<String>.from(json["product_photos"].map((x) => x.toString())),
      productVideos: (json["product_videos"] is List)
          ? List<ProductVideo>.from(
              json["product_videos"]
                  .where((e) => e != null)
                  .map(
                    (e) => ProductVideo.fromJson(
                      e is Map<String, dynamic>
                          ? e
                          : Map<String, dynamic>.from(e),
                    ),
                  ),
            )
          : [],

      userUploadedVideos: json["user_uploaded_videos"] == null
          ? []
          : List<dynamic>.from(json["user_uploaded_videos"]),
      hasVideo: json["has_video"],
      productDetails: json["product_details"] is Map<String, dynamic>
          ? ProductDetails.fromJson(json["product_details"])
          : null,
      customersSay: json["customers_say"]?.toString(),
      topReviews: json["top_reviews"] == null
          ? []
          : List<TopReview>.from(
              json["top_reviews"].map((x) => TopReview.fromJson(x)),
            ),
      topReviewsGlobal: json["top_reviews_global"] == null
          ? []
          : List<TopReview>.from(
              json["top_reviews_global"].map((x) => TopReview.fromJson(x)),
            ),
      delivery: json["delivery"],
      primaryDeliveryTime: json["primary_delivery_time"],
      category: json["category"] is Map<String, dynamic>
          ? Category.fromJson(json["category"])
          : null,
      categoryPath: json["category_path"] == null
          ? []
          : List<CategoryPath>.from(
              json["category_path"].map((x) => CategoryPath.fromJson(x)),
            ),
      productVariationsDimensions: json["product_variations_dimensions"] == null
          ? []
          : List<String>.from(json["product_variations_dimensions"]),
      productVariations: productVariationsParsed,
      allProductVariations: allProductVariationsParsed,
      couponDiscountPercentage: json["coupon_discount_percentage"],
      hasAplus: json["has_aplus"],
      aplusImages: json["aplus_images"] == null
          ? []
          : List<String>.from(json["aplus_images"].map((x) => x.toString())),
      hasBrandstory: json["has_brandstory"],
      frequentlyBoughtTogether: json["frequently_bought_together"] == null
          ? []
          : List<FrequentlyBoughtTogether>.from(
              json["frequently_bought_together"].map(
                (x) => FrequentlyBoughtTogether.fromJson(x),
              ),
            ),
      landingAsin: json["landing_asin"],
      parentAsin: json["parent_asin"]?.toString(),
    );
  }
}

class ProductVideo {
  ProductVideo({
    this.id,
    this.title,
    this.videoUrl,
    this.videoHeight,
    this.videoWidth,
    this.thumbnailUrl,
    this.productAsin,
    this.parentAsin,
  });

  final String? id;
  final String? title;
  final String? videoUrl;
  final int? videoHeight;
  final int? videoWidth;
  final String? thumbnailUrl;
  final String? productAsin;
  final String? parentAsin;

  factory ProductVideo.fromJson(Map<String, dynamic> json) {
    return ProductVideo(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      videoUrl: json['video_url']?.toString(),
      // video_height/video_width ممكن ييجوا كـ String أو int -> نحاول نحولهم لـ int
      videoHeight: json['video_height'] != null
          ? (int.tryParse(json['video_height'].toString()))
          : null,
      videoWidth: json['video_width'] != null
          ? (int.tryParse(json['video_width'].toString()))
          : null,
      thumbnailUrl: json['thumbnail_url']?.toString(),
      productAsin: json['product_asin']?.toString(),
      parentAsin: json['parent_asin']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'video_url': videoUrl,
      'video_height': videoHeight,
      'video_width': videoWidth,
      'thumbnail_url': thumbnailUrl,
      'product_asin': productAsin,
      'parent_asin': parentAsin,
    };
  }
}

class AllProductVariation {
  AllProductVariation({
    required this.size,
    required this.color,
    required this.serviceProvider,
    required this.productGrade,
  });

  final String? size;
  final String? color;
  final String? serviceProvider;
  final String? productGrade;

  factory AllProductVariation.fromJson(Map<String, dynamic> json) {
    return AllProductVariation(
      size: json["size"]?.toString(),
      color: json["color"]?.toString(),
      serviceProvider: json["service_provider"]?.toString(),
      productGrade: json["product_grade"]?.toString(),
    );
  }
}

class Category {
  Category({required this.id, required this.name});

  final String? id;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"]);
  }
}

class CategoryPath {
  CategoryPath({required this.id, required this.name, required this.link});

  final String? id;
  final String? name;
  final String? link;

  factory CategoryPath.fromJson(Map<String, dynamic> json) {
    return CategoryPath(id: json["id"], name: json["name"], link: json["link"]);
  }
}

class FrequentlyBoughtTogether {
  FrequentlyBoughtTogether({
    required this.productTitle,
    required this.productPrice,
    required this.productPhoto,
    required this.productUrl,
  });

  final String? productTitle;
  final String? productPrice;
  final String? productPhoto;
  final String? productUrl;

  factory FrequentlyBoughtTogether.fromJson(Map<String, dynamic> json) {
    return FrequentlyBoughtTogether(
      productTitle: json["product_title"],
      productPrice: json["product_price"],
      productPhoto: json["product_photo"],
      productUrl: json["product_url"],
    );
  }
}

class ProductDetails {
  ProductDetails({
    required this.brand,
    required this.operatingSystem,
    required this.ramMemoryInstalledSize,
    required this.cpuModel,
    required this.cpuSpeed,
    required this.memoryStorageCapacity,
    required this.screenSize,
    required this.resolution,
    required this.refreshRate,
    required this.modelName,
  });

  final String? brand;
  final String? operatingSystem;
  final String? ramMemoryInstalledSize;
  final String? cpuModel;
  final String? cpuSpeed;
  final String? memoryStorageCapacity;
  final String? screenSize;
  final String? resolution;
  final String? refreshRate;
  final String? modelName;

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      brand: json["Brand"],
      operatingSystem: json["Operating System"],
      ramMemoryInstalledSize: json["Ram Memory Installed Size"],
      cpuModel: json["CPU Model"],
      cpuSpeed: json["CPU Speed"],
      memoryStorageCapacity: json["Memory Storage Capacity"],
      screenSize: json["Screen Size"],
      resolution: json["Resolution"],
      refreshRate: json["Refresh Rate"],
      modelName: json["Model Name"],
    );
  }
}

class ProductInformation {
  ProductInformation({
    required this.productDimensions,
    required this.itemWeight,
    required this.asin,
    required this.itemModelNumber,
    required this.batteries,
    required this.bestSellersRank,
    required this.isDiscontinuedByManufacturer,
    required this.os,
    required this.ram,
    required this.wirelessCommunicationTechnologies,
    required this.connectivityTechnologies,
    required this.gps,
    required this.specialFeatures,
    required this.otherDisplayFeatures,
    required this.humanInterfaceInput,
    required this.scannerResolution,
    required this.otherCameraFeatures,
    required this.formFactor,
    required this.color,
    required this.batteryPowerRating,
    required this.whatsInTheBox,
    required this.manufacturer,
    required this.dateFirstAvailable,
    required this.memoryStorageCapacity,
    required this.standingScreenDisplaySize,
    required this.ramMemoryInstalledSize,
    required this.batteryCapacity,
    required this.weight,
  });

  final String? productDimensions;
  final String? itemWeight;
  final String? asin;
  final String? itemModelNumber;
  final String? batteries;
  final String? bestSellersRank;
  final String? isDiscontinuedByManufacturer;
  final String? os;
  final String? ram;
  final String? wirelessCommunicationTechnologies;
  final String? connectivityTechnologies;
  final String? gps;
  final String? specialFeatures;
  final String? otherDisplayFeatures;
  final String? humanInterfaceInput;
  final String? scannerResolution;
  final String? otherCameraFeatures;
  final String? formFactor;
  final String? color;
  final String? batteryPowerRating;
  final String? whatsInTheBox;
  final String? manufacturer;
  final String? dateFirstAvailable;
  final String? memoryStorageCapacity;
  final String? standingScreenDisplaySize;
  final String? ramMemoryInstalledSize;
  final String? batteryCapacity;
  final String? weight;

  factory ProductInformation.fromJson(Map<String, dynamic> json) {
    return ProductInformation(
      productDimensions: json["Product Dimensions"],
      itemWeight: json["Item Weight"],
      asin: json["ASIN"],
      itemModelNumber: json["Item model number"],
      batteries: json["Batteries"],
      bestSellersRank: json["Best Sellers Rank"],
      isDiscontinuedByManufacturer: json["Is Discontinued By Manufacturer"],
      os: json["OS"],
      ram: json["RAM"],
      wirelessCommunicationTechnologies:
          json["Wireless communication technologies"],
      connectivityTechnologies: json["Connectivity technologies"],
      gps: json["GPS"],
      specialFeatures: json["Special features"],
      otherDisplayFeatures: json["Other display features"],
      humanInterfaceInput: json["Human Interface Input"],
      scannerResolution: json["Scanner Resolution"],
      otherCameraFeatures: json["Other camera features"],
      formFactor: json["Form Factor"],
      color: json["Color"],
      batteryPowerRating: json["Battery Power Rating"],
      whatsInTheBox: json["Whats in the box"],
      manufacturer: json["Manufacturer"],
      dateFirstAvailable: json["Date First Available"],
      memoryStorageCapacity: json["Memory Storage Capacity"],
      standingScreenDisplaySize: json["Standing screen display size"],
      ramMemoryInstalledSize: json["Ram Memory Installed Size"],
      batteryCapacity: json["Battery Capacity"],
      weight: json["Weight"],
    );
  }
}

class ProductVariations {
  ProductVariations({
    required this.size,
    required this.color,
    required this.serviceProvider,
  });

  final List<Color> size;
  final List<Color> color;
  final List<Color> serviceProvider;

  factory ProductVariations.fromJson(Map<String, dynamic> json) {
    return ProductVariations(
      size: (json["size"] is List)
          ? List<Color>.from(json["size"].map((x) => Color.fromJson(x)))
          : [],
      color: (json["color"] is List)
          ? List<Color>.from(json["color"].map((x) => Color.fromJson(x)))
          : [],
      serviceProvider: (json["service_provider"] is List)
          ? List<Color>.from(
              json["service_provider"].map((x) => Color.fromJson(x)),
            )
          : [],
    );
  }
}

class Color {
  Color({
    required this.asin,
    required this.value,
    required this.photo,
    required this.isAvailable,
  });

  final String? asin;
  final String? value;
  final String? photo;
  final bool? isAvailable;

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      asin: json["asin"],
      value: json["value"],
      photo: json["photo"],
      isAvailable: json["is_available"],
    );
  }
}

class TopReview {
  TopReview({
    required this.reviewId,
    required this.reviewTitle,
    required this.reviewComment,
    required this.reviewStarRating,
    required this.reviewLink,
    required this.reviewAuthorId,
    required this.reviewAuthor,
    required this.reviewAuthorUrl,
    required this.reviewAuthorAvatar,
    required this.reviewImages,
    required this.reviewVideo,
    required this.reviewDate,
    required this.isVerifiedPurchase,
    required this.helpfulVoteStatement,
    required this.reviewedProductAsin,
    required this.reviewedProductVariant,
    required this.isVine,
  });

  final String? reviewId;
  final String? reviewTitle;
  final String? reviewComment;
  final String? reviewStarRating;
  final String? reviewLink;
  final String? reviewAuthorId;
  final String? reviewAuthor;
  final String? reviewAuthorUrl;
  final String? reviewAuthorAvatar;
  final List<String> reviewImages;
  final dynamic reviewVideo;
  final String? reviewDate;
  final bool? isVerifiedPurchase;
  final String? helpfulVoteStatement;
  final String? reviewedProductAsin;
  final ReviewedProductVariant? reviewedProductVariant;
  final bool? isVine;

  factory TopReview.fromJson(Map<String, dynamic> json) {
    return TopReview(
      reviewId: json["review_id"],
      reviewTitle: json["review_title"],
      reviewComment: json["review_comment"],
      reviewStarRating: json["review_star_rating"],
      reviewLink: json["review_link"],
      reviewAuthorId: json["review_author_id"],
      reviewAuthor: json["review_author"],
      reviewAuthorUrl: json["review_author_url"],
      reviewAuthorAvatar: json["review_author_avatar"],
      reviewImages: json["review_images"] == null
          ? []
          : List<String>.from(json["review_images"]!.map((x) => x)),
      reviewVideo: json["review_video"],
      reviewDate: json["review_date"],
      isVerifiedPurchase: json["is_verified_purchase"],
      helpfulVoteStatement: json["helpful_vote_statement"],
      reviewedProductAsin: json["reviewed_product_asin"],
      reviewedProductVariant: json["reviewed_product_variant"] == null
          ? null
          : ReviewedProductVariant.fromJson(json["reviewed_product_variant"]),
      isVine: json["is_vine"],
    );
  }
}

class ReviewedProductVariant {
  ReviewedProductVariant({
    required this.size,
    required this.color,
    required this.serviceProvider,
    required this.productGrade,
  });

  final String? size;
  final String? color;
  final String? serviceProvider;
  final String? productGrade;

  factory ReviewedProductVariant.fromJson(Map<String, dynamic> json) {
    return ReviewedProductVariant(
      size: json["Size"],
      color: json["Color"],
      serviceProvider: json["Service provider"],
      productGrade: json["Product grade"],
    );
  }
}

class Parameters {
  Parameters({
    required this.asin,
    required this.country,
    required this.language,
  });

  final String? asin;
  final String? country;
  final String? language;

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      asin: json["asin"],
      country: json["country"],
      language: json["language"],
    );
  }
}
