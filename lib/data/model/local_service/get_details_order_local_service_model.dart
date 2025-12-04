class GetDetailsOrderLocalServiceModel {
  GetDetailsOrderLocalServiceModel({required this.status, required this.data});

  final String? status;
  final Data? data;

  factory GetDetailsOrderLocalServiceModel.fromJson(Map<String, dynamic> json) {
    return GetDetailsOrderLocalServiceModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.order,
    required this.service,
    required this.user,
    required this.address,
  });

  final Order? order;
  final Service? service;
  final User? user;
  final Address? address;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
      service: json["service"] == null
          ? null
          : Service.fromJson(json["service"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      address: json["address"] == null
          ? null
          : Address.fromJson(json["address"]),
    );
  }
}

class Address {
  Address({
    required this.title,
    required this.city,
    required this.street,
    required this.buildingNumber,
    required this.floor,
    required this.apartment,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  final String? title;
  final String? city;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final String? latitude;
  final String? longitude;
  final String? phone;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      title: json["title"],
      city: json["city"],
      street: json["street"],
      buildingNumber: json["building_number"],
      floor: json["floor"],
      apartment: json["apartment"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      phone: json["phone"],
    );
  }
}

class Order {
  Order({
    required this.orderId,
    required this.userId,
    required this.serviceId,
    required this.status,
    required this.note,
    required this.addressId,
    required this.createAt,
  });

  final int? orderId;
  final int? userId;
  final int? serviceId;
  final String? status;
  final String? note;
  final int? addressId;
  final DateTime? createAt;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json["order_id"],
      userId: json["user_id"],
      serviceId: json["service_id"],
      status: json["status"],
      note: json["note"],
      addressId: json["address_id"],
      createAt: DateTime.tryParse(json["create_at"] ?? ""),
    );
  }
}

class Service {
  Service({
    required this.name,
    required this.image,
    required this.city,
    required this.desc,
    required this.price,
    required this.phone,
  });

  final String? name;
  final String? image;
  final String? city;
  final String? desc;
  final String? price;
  final String? phone;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json["name"],
      image: json["image"],
      city: json["city"],
      desc: json["desc"],
      price: json["price"],
      phone: json["phone"],
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
