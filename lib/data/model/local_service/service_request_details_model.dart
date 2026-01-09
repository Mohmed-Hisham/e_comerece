class ServiceRequestDetailsModel {
  ServiceRequestDetailsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final ServiceRequestDetailData? data;
  final dynamic errors;

  factory ServiceRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDetailsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : ServiceRequestDetailData.fromJson(json["data"]),
      errors: json["errors"],
    );
  }
}

class ServiceRequestDetailData {
  ServiceRequestDetailData({
    required this.requestId,
    required this.status,
    required this.quotedPrice,
    required this.note,
    required this.createdAt,
    required this.user,
    required this.service,
    required this.address,
  });

  final String? requestId;
  final String? status;
  final String? quotedPrice;
  final String? note;
  final DateTime? createdAt;
  final User? user;
  final Service? service;
  final Address? address;

  factory ServiceRequestDetailData.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDetailData(
      requestId: json["request_id"],
      status: json["status"],
      quotedPrice: json["quoted_price"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      service: json["service"] == null
          ? null
          : Service.fromJson(json["service"]),
      address: json["address"] == null
          ? null
          : Address.fromJson(json["address"]),
    );
  }
}

class Address {
  Address({
    required this.id,
    required this.title,
    required this.city,
    required this.street,
    required this.buildingNumber,
    required this.floor,
    required this.apartment,
    required this.latitude,
    required this.longitude,
  });

  final String? id;
  final String? title;
  final String? city;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final String? latitude;
  final String? longitude;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      title: json["title"],
      city: json["city"],
      street: json["street"],
      buildingNumber: json["building_number"],
      floor: json["floor"],
      apartment: json["apartment"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}

class Service {
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? image;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
    );
  }
}

class User {
  User({required this.name, required this.email, required this.phone});

  final String? name;
  final String? email;
  final String? phone;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json["name"], email: json["email"], phone: json["phone"]);
  }
}
