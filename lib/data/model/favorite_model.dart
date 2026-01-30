class FavoriteModel {
  FavoriteModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<Product> data;
  final dynamic errors;

  factory FavoriteModel.fromJson(dynamic json) {
    if (json is List) {
      return FavoriteModel(
        success: true,
        message: "Success",
        data: json.map((x) => Product.fromJson(x)).toList(),
        errors: null,
      );
    }
    return FavoriteModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.map((x) => x.toJson()).toList(),
    "errors": errors,
  };
}

class Product {
  Product({
    this.id,
    this.productId,
    this.productTitle,
    this.productImage,
    this.productPrice,
    this.favoritePlatform,
    this.goodsSn,
    this.categoryId,
    this.createdAt,
  });

  final String? id;
  final String? productId;
  final String? productTitle;
  final String? productImage;
  final String? productPrice;
  final String? favoritePlatform;
  final String? goodsSn;
  final String? categoryId;
  final DateTime? createdAt;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"]?.toString(),
      productId: json["product_id"]?.toString(),
      productTitle: json["product_title"],
      productImage: json["product_image"],
      productPrice: json["product_price"]?.toString(),
      favoritePlatform: json["favorite_platform"],
      goodsSn: json["goods_sn"]?.toString(),
      categoryId: json["category_id"]?.toString(),
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "product_id": productId,
    "product_title": productTitle,
    "product_image": productImage,
    "product_price": productPrice,
    "favorite_platform": favoritePlatform,
    "goods_sn": goodsSn,
    "category_id": categoryId,
    if (createdAt != null) "created_at": createdAt?.toIso8601String(),
  };
}
