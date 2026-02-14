class AddressModel {
  AddressModel({
    required this.success,
    required this.message,
    required this.addresses,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<AddressData> addresses;
  final dynamic errors;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      success: json["success"],
      message: json["message"],
      addresses: json["data"] == null
          ? []
          : (json["data"] is List)
          ? List<AddressData>.from(
              json["data"]!.map((x) => AddressData.fromJson(x)),
            )
          : [AddressData.fromJson(json["data"])],
      errors: json["errors"],
    );
  }
}

class AddressData {
  AddressData({
    this.id,
    this.title,
    this.city,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    this.phone,
    this.lng,
    this.lat,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? city;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;
  final String? phone;
  final double? lng;
  final double? lat;
  final int? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json["id"],
      title: json["title"],
      city: json["city"],
      street: json["street"],
      building: json["building"],
      apartment: json["apartment"],
      floor: json["floor"],
      phone: json["phone"],
      lng: json["lng"]?.toDouble(),
      lat: json["lat"]?.toDouble(),
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (title != null) "title": title,
    if (city != null) "city": city,
    if (street != null) "street": street,
    if (building != null) "building": building,
    if (apartment != null) "apartment": apartment,
    if (floor != null) "floor": floor,
    if (phone != null) "phone": phone,
    if (lat != null) "lat": lat,
    if (lng != null) "lng": lng,
    if (isDefault != null) "is_default": isDefault,
  };
}
