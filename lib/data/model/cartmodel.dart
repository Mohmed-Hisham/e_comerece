import 'dart:convert';

class CartModel {
  CartModel({
    required this.success,
    required this.message,
    required this.cartData,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<CartData> cartData;
  final dynamic errors;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      success: json["success"],
      message: json["message"],
      cartData: json["data"] == null
          ? []
          : List<CartData>.from(json["data"]!.map((x) => CartData.fromJson(x))),
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": cartData.map((x) => x.toJson()).toList(),
    "errors": errors,
  };
}

class CartData {
  CartData({
    this.id,
    this.productId,
    this.productTitle,
    this.productImage,
    this.productPrice,
    this.cartQuantity,
    this.cartAttributes,
    this.cartAvailableQuantity,
    this.cartPlatform,
    this.cartTier,
    this.goodsSn,
    this.categoryId,
    this.productLink,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? productId;
  final String? productTitle;
  final String? productImage;
  final double? productPrice;
  final int? cartQuantity;
  final String? cartAttributes;
  final int? cartAvailableQuantity;
  final String? cartPlatform;
  final String? cartTier;
  final String? goodsSn;
  final String? categoryId;
  final String? productLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CartData copyWith({
    String? id,
    String? productId,
    String? productTitle,
    String? productImage,
    double? productPrice,
    int? cartQuantity,
    String? cartAttributes,
    int? cartAvailableQuantity,
    String? cartPlatform,
    String? cartTier,
    String? goodsSn,
    String? categoryId,
    String? productLink,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartData(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      cartQuantity: cartQuantity ?? this.cartQuantity,
      cartAttributes: cartAttributes ?? this.cartAttributes,
      cartAvailableQuantity:
          cartAvailableQuantity ?? this.cartAvailableQuantity,
      cartPlatform: cartPlatform ?? this.cartPlatform,
      cartTier: cartTier ?? this.cartTier,
      goodsSn: goodsSn ?? this.goodsSn,
      categoryId: categoryId ?? this.categoryId,
      productLink: productLink ?? this.productLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json["id"],
      productId: json["product_id"],
      productTitle: json["product_title"],
      productImage: json["product_image"],
      productPrice: _parsePrice(json["product_price"]),
      cartQuantity: _parseInt(json["cart_quantity"] ?? json["quantity"]),
      cartAttributes: json["cart_attributes"] ?? json["attributes"],
      cartAvailableQuantity: _parseInt(
        json["cart_available_quantity"] ?? json["available_quantity"],
      ),
      cartPlatform: json["cart_platform"] ?? json["platform"],
      cartTier: json["cart_tier"],
      goodsSn: json["goods_sn"],
      categoryId: json["category_id"],
      productLink: json["product_link"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (productId != null) "product_id": productId,
    if (productTitle != null) "product_title": productTitle,
    if (productImage != null) "product_image": productImage,
    if (productPrice != null) "product_price": productPrice,
    if (cartQuantity != null) "cart_quantity": cartQuantity,
    if (cartAttributes != null) "cart_attributes": cartAttributes,
    if (cartAvailableQuantity != null)
      "cart_available_quantity": cartAvailableQuantity,
    if (cartPlatform != null) "cart_platform": cartPlatform,
    if (cartTier != null) "cart_tier": cartTier,
    if (goodsSn != null) "goods_sn": goodsSn,
    if (categoryId != null) "category_id": categoryId,
    if (productLink != null) "product_link": productLink,
  };

  Map<String, dynamic> get parsedAttributes {
    if (cartAttributes == null || cartAttributes!.isEmpty) return {};
    try {
      final decoded = jsonDecode(cartAttributes!);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else if (decoded is List) {
        return {"items": decoded};
      }
      return {"value": decoded.toString()};
    } catch (e) {
      return {"raw": cartAttributes};
    }
  }

  Map<String, dynamic> toAddJson() => {
    "product_id": productId,
    "product_title": productTitle,
    "product_image": productImage,
    "product_price": productPrice,
    "quantity": cartQuantity,
    "attributes": cartAttributes,
    "available_quantity": cartAvailableQuantity,
    "platform": cartPlatform,
    "cart_tier": cartTier,
    "goods_sn": goodsSn,
    "category_id": categoryId,
    "product_link": productLink,
  };

  static double? _parsePrice(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
