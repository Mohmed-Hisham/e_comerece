class ServiceRequestModel {
  ServiceRequestModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<ServiceRequestData> data;
  final dynamic errors;

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<ServiceRequestData>.from(
              json["data"]!.map((x) => ServiceRequestData.fromJson(x)),
            ),
      errors: json["errors"],
    );
  }
}

class ServiceRequestData {
  ServiceRequestData({
    this.id,
    this.serviceId,
    this.note,
    this.addressId,
    this.quotedPrice,
    this.status,
    this.createdAt,
    this.serviceName,
    this.serviceImage,
  });

  final String? id;
  final String? serviceId;
  final String? note;
  final String? addressId;
  final double? quotedPrice;
  final String? status;
  final DateTime? createdAt;
  final String? serviceName;
  final String? serviceImage;

  factory ServiceRequestData.fromJson(Map<String, dynamic> json) {
    return ServiceRequestData(
      id: json["id"],
      serviceId: json["service_id"],
      note: json["note"],
      addressId: json["address_id"],
      quotedPrice: json["quoted_price"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      serviceName: json["service_name"],
      serviceImage: json["service_image"],
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (serviceId != null) "service_id": serviceId,
    if (note != null) "note": note,
    if (addressId != null) "address_id": addressId,
    if (quotedPrice != null) "quoted_price": quotedPrice,
    if (status != null) "status": status,
    if (createdAt != null) "created_at": createdAt?.toIso8601String(),
    if (serviceName != null) "service_name": serviceName,
    if (serviceImage != null) "service_image": serviceImage,
  };
}
