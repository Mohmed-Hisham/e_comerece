class GetOrderWithStatusModel {
  GetOrderWithStatusModel({required this.status, required this.data});

  final String? status;
  final List<Orders> data;

  factory GetOrderWithStatusModel.fromJson(Map<String, dynamic> json) {
    return GetOrderWithStatusModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Orders>.from(json["data"]!.map((x) => Orders.fromJson(x))),
    );
  }
}

class Orders {
  Orders({
    required this.orderId,
    required this.status,
    required this.subtotal,
    required this.discountAmount,
    required this.shippingAmount,
    required this.totalAmount,
    required this.paymentStatus,
    required this.createdAt,
  });

  final int? orderId;
  final String? status;
  final double? subtotal;
  final int? discountAmount;
  final int? shippingAmount;
  final double? totalAmount;
  final String? paymentStatus;
  final DateTime? createdAt;

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orderId: json["order_id"],
      status: json["status"],
      subtotal: json["subtotal"],
      discountAmount: json["discount_amount"],
      shippingAmount: json["shipping_amount"],
      totalAmount: json["total_amount"],
      paymentStatus: json["payment_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}
