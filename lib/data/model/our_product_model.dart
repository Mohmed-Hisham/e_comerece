/// Local Product Model - Based on API Response
class LocalProductModel {
  String? id;
  String? title;
  String? description;
  double? price;
  double? discountPrice;
  int? stockQuantity;
  String? mainImage;
  List<String>? images;
  String? categoryId;
  String? categoryName;

  LocalProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPrice,
    this.stockQuantity,
    this.mainImage,
    this.images,
    this.categoryId,
    this.categoryName,
  });

  LocalProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'] != null
        ? double.tryParse(json['price'].toString())
        : null;
    discountPrice = json['discountPrice'] != null
        ? double.tryParse(json['discountPrice'].toString())
        : null;
    stockQuantity = json['stockQuantity'];
    mainImage = json['mainImage'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPrice'] = discountPrice;
    data['stockQuantity'] = stockQuantity;
    data['mainImage'] = mainImage;
    data['images'] = images;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    return data;
  }

  /// Calculate discount percentage
  int? get discountPercent {
    if (price != null && discountPrice != null && price! > 0) {
      return (((price! - discountPrice!) / price!) * 100).round();
    }
    return null;
  }

  /// Check if product has discount
  bool get hasDiscount =>
      discountPrice != null && price != null && discountPrice! < price!;
}

/// Local Product Category Model
class LocalProductCategoryModel {
  String? id;
  String? name;
  String? description;
  String? image;
  int? productCount;

  LocalProductCategoryModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.productCount,
  });

  LocalProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    productCount = json['productCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['productCount'] = productCount;
    return data;
  }
}

/// Products Pagination Response
class LocalProductsResponse {
  List<LocalProductModel>? products;
  int? totalCount;
  int? page;
  int? pageSize;
  int? totalPages;

  LocalProductsResponse({
    this.products,
    this.totalCount,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  LocalProductsResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <LocalProductModel>[];
      json['products'].forEach((v) {
        products!.add(LocalProductModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  bool get hasMore => page != null && totalPages != null && page! < totalPages!;
}

/// Product Details Response (includes related products)
class LocalProductDetailsResponse {
  LocalProductModel? product;
  LocalProductsResponse? relatedProducts;

  LocalProductDetailsResponse({this.product, this.relatedProducts});

  LocalProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? LocalProductModel.fromJson(json['product'])
        : null;
    relatedProducts = json['relatedProducts'] != null
        ? LocalProductsResponse.fromJson(json['relatedProducts'])
        : null;
  }
}

/// API Response Wrapper
class LocalProductApiResponse<T> {
  bool? success;
  String? message;
  T? data;

  LocalProductApiResponse({this.success, this.message, this.data});
}
