class GetOrderWithStatusModel {
  GetOrderWithStatusModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Orders> data;

  factory GetOrderWithStatusModel.fromJson(Map<String, dynamic> json) {
    return GetOrderWithStatusModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Orders>.from(json["data"]!.map((x) => Orders.fromJson(x))),
    );
  }
}

class Orders {
  Orders({
    required this.id,
    required this.orderNumber,
    required this.paymentMethod,
    required this.subtotal,
    required this.couponDiscount,
    required this.productReviewFee,
    required this.total,
    required this.status,
    required this.statusName,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  final String? id;
  final String? orderNumber;
  final String? paymentMethod;
  final double? subtotal;
  final double? couponDiscount;
  final double? productReviewFee;
  final double? total;
  final String? status;
  final String? statusName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrderItems? items;

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json["id"],
      orderNumber: json["orderNumber"],
      paymentMethod: json["paymentMethod"],
      subtotal: json["subtotal"]?.toDouble(),
      couponDiscount: json["couponDiscount"]?.toDouble(),
      productReviewFee: json["productReviewFee"]?.toDouble(),
      total: json["total"]?.toDouble(),
      status: json["status"],
      statusName: json["statusName"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      items: json["items"] != null ? OrderItems.fromJson(json["items"]) : null,
    );
  }
}

class OrderItems {
  OrderItems({required this.itemsCount, required this.productImages});

  final int? itemsCount;
  final List<ProductImage> productImages;

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      itemsCount: json["itemsCount"],
      productImages: json["itemsproductImage"] == null
          ? []
          : List<ProductImage>.from(
              json["itemsproductImage"]!.map((x) => ProductImage.fromJson(x)),
            ),
    );
  }
}

class ProductImage {
  ProductImage({required this.productImage});

  final String? productImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(productImage: json["productImage"]);
  }
}
