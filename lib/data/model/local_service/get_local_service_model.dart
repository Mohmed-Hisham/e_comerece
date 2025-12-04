class GetLocalServiceModel {
  GetLocalServiceModel({
    required this.status,
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.nextPage,
    required this.data,
  });

  final String? status;
  final int? count;
  final int? totalPages;
  final String? currentPage;
  final dynamic nextPage;
  final List<Service> data;

  factory GetLocalServiceModel.fromJson(Map<String, dynamic> json) {
    return GetLocalServiceModel(
      status: json["status"],
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      nextPage: json["next_page"],
      data: json["data"] == null
          ? []
          : List<Service>.from(json["data"]!.map((x) => Service.fromJson(x))),
    );
  }
}

class Service {
  Service({
    required this.serviceId,
    required this.serviceName,
    required this.serviceDesc,
    required this.serviceImage,
    required this.servicePrice,
    required this.serviceCity,
    required this.servicePhone,
    required this.serviceVisible,
    required this.serviceCreateAt,
  });

  final int? serviceId;
  final String? serviceName;
  final String? serviceDesc;
  final String? serviceImage;
  final String? servicePrice;
  final String? serviceCity;
  final String? servicePhone;
  final int? serviceVisible;
  final DateTime? serviceCreateAt;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json["service_id"],
      serviceName: json["service_name"],
      serviceDesc: json["service_desc"],
      serviceImage: json["service_image"],
      servicePrice: json["service_price"],
      serviceCity: json["service_city"],
      servicePhone: json["service_phone"],
      serviceVisible: json["service_visible"],
      serviceCreateAt: DateTime.tryParse(json["service_create_at"] ?? ""),
    );
  }
}
