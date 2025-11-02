class AddressModel {
  AddressModel({required this.status, required this.data});

  final String? status;
  final List<Datum> data;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class Datum {
  Datum({
    this.addressId,
    this.userId,
    this.addressTitle,
    this.city,
    this.street,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.latitude,
    this.longitude,
    this.phone,
    this.isDefault,
    this.createdAt,
  });

  final int? addressId;
  final int? userId;
  final String? addressTitle;
  final String? city;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final int? isDefault;
  final DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      addressId: json["address_id"],
      userId: json["user_id"],
      addressTitle: json["address_title"],
      city: json["city"],
      street: json["street"],
      buildingNumber: json["building_number"],
      floor: json["floor"],
      apartment: json["apartment"],
      latitude: double.tryParse(json["latitude"] ?? ""),
      longitude: double.tryParse(json["longitude"] ?? ""),
      phone: json["phone"],
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "address_id": addressId,
      "user_id": userId,
      "address_title": addressTitle,
      "city": city,
      "street": street,
      "building_number": buildingNumber,
      "floor": floor,
      "apartment": apartment,
      "latitude": latitude,
      "longitude": longitude,
      "phone": phone,
      "is_default": isDefault,
    };

    data.removeWhere((key, value) => value == null);

    return data;
  }
}
