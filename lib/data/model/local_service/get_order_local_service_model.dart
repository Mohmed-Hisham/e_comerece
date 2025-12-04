class GetOrderLocalServiceModel {
  GetOrderLocalServiceModel({required this.status, required this.data});

  final String? status;
  final List<Order> data;

  factory GetOrderLocalServiceModel.fromJson(Map<String, dynamic> json) {
    return GetOrderLocalServiceModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
    );
  }
}

class Order {
  Order({
    required this.ordersServicesId,
    required this.orderUserId,
    required this.orderServiceId,
    required this.orderStatus,
    required this.orderNote,
    required this.orderAddressId,
    required this.orderLat,
    required this.orderLng,
    required this.orderCreateAt,
    required this.serviceName,
    required this.serviceImage,
    required this.serviceCity,
  });

  final int? ordersServicesId;
  final int? orderUserId;
  final int? orderServiceId;
  final String? orderStatus;
  final String? orderNote;
  final int? orderAddressId;
  final dynamic orderLat;
  final dynamic orderLng;
  final DateTime? orderCreateAt;
  final String? serviceName;
  final String? serviceImage;
  final String? serviceCity;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ordersServicesId: json["orders_services_id"],
      orderUserId: json["order_user_id"],
      orderServiceId: json["order_service_id"],
      orderStatus: json["order_status"],
      orderNote: json["order_note"],
      orderAddressId: json["order_address_id"],
      orderLat: json["order_lat"],
      orderLng: json["order_lng"],
      orderCreateAt: DateTime.tryParse(json["order_create_at"] ?? ""),
      serviceName: json["service_name"],
      serviceImage: json["service_image"],
      serviceCity: json["service_city"],
    );
  }
}
