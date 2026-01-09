class GetLocalServiceModel {
  GetLocalServiceModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<LocalServiceData> data;
  final dynamic errors;

  factory GetLocalServiceModel.fromJson(Map<String, dynamic> json) {
    return GetLocalServiceModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : (json["data"] is List)
          ? List<LocalServiceData>.from(
              json["data"]!.map((x) => LocalServiceData.fromJson(x)),
            )
          : [LocalServiceData.fromJson(json["data"])],
      errors: json["errors"],
    );
  }
}

class LocalServiceData {
  LocalServiceData({
    required this.id,
    required this.serviceName,
    required this.serviceDesc,
    required this.serviceImage,
  });

  final String? id;
  final String? serviceName;
  final String? serviceDesc;
  final String? serviceImage;

  factory LocalServiceData.fromJson(Map<String, dynamic> json) {
    return LocalServiceData(
      id: json["id"],
      serviceName: json["service_name"],
      serviceDesc: json["service_desc"],
      serviceImage: json["service_image"],
    );
  }
}
