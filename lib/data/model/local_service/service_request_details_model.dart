class ServiceRequestDetailsModel {
  String? status;
  List<ServiceRequestDetailData>? data;

  ServiceRequestDetailsModel({this.status, this.data});

  ServiceRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ServiceRequestDetailData>[];
      json['data'].forEach((v) {
        data!.add(ServiceRequestDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceRequestDetailData {
  int? requestId;
  String? status;
  String? quotedPrice;
  String? note;
  String? createdAt;
  User? user;
  Service? service;
  Address? address;

  ServiceRequestDetailData({
    this.requestId,
    this.status,
    this.quotedPrice,
    this.note,
    this.createdAt,
    this.user,
    this.service,
    this.address,
  });

  ServiceRequestDetailData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    status = json['status'];
    quotedPrice = json['quoted_price'];
    note = json['note'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    service = json['service'] != null
        ? Service.fromJson(json['service'])
        : null;
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['status'] = status;
    data['quoted_price'] = quotedPrice;
    data['note'] = note;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;

  User({this.name, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? description;
  String? image;
  String? price;
  String? city;
  String? contactPhone;

  Service({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.city,
    this.contactPhone,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    city = json['city'];
    contactPhone = json['contact_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['city'] = city;
    data['contact_phone'] = contactPhone;
    return data;
  }
}

class Address {
  int? id;
  String? title;
  String? city;
  String? street;
  String? buildingNumber;
  String? floor;
  String? apartment;
  String? latitude;
  String? longitude;
  String? phone;

  Address({
    this.id,
    this.title,
    this.city,
    this.street,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.latitude,
    this.longitude,
    this.phone,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    city = json['city'];
    street = json['street'];
    buildingNumber = json['building_number'];
    floor = json['floor'];
    apartment = json['apartment'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['city'] = city;
    data['street'] = street;
    data['building_number'] = buildingNumber;
    data['floor'] = floor;
    data['apartment'] = apartment;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    return data;
  }
}
