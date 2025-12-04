class GetOrderWithIdModel {
  GetOrderWithIdModel({required this.status, required this.data});

  final String? status;
  final Data? data;

  factory GetOrderWithIdModel.fromJson(Map<String, dynamic> json) {
    return GetOrderWithIdModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.subtotal,
    required this.discountAmount,
    required this.shippingAmount,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.coupon,
    required this.items,
  });

  final int? orderId;
  final int? userId;
  final String? status;
  final double? subtotal;
  final int? discountAmount;
  final int? shippingAmount;
  final double? totalAmount;
  final String? paymentMethod;
  final String? paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Address? address;
  final Coupon? coupon;
  final List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      orderId: json["order_id"],
      userId: json["user_id"],
      status: json["status"],
      subtotal: json["subtotal"],
      discountAmount: json["discount_amount"],
      shippingAmount: json["shipping_amount"],
      totalAmount: json["total_amount"],
      paymentMethod: json["payment_method"],
      paymentStatus: json["payment_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      address: json["address"] == null
          ? null
          : Address.fromJson(json["address"]),
      coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }
}

class Address {
  Address({
    required this.addressId,
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

  final int? addressId;
  final String? title;
  final String? city;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final double? latitude;
  final double? longitude;
  final String? phone;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json["address_id"],
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

class Coupon {
  Coupon({required this.couponName, required this.couponDiscount});

  final String? couponName;
  final int? couponDiscount;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponName: json["coupon_name"],
      couponDiscount: json["coupon_discount"],
    );
  }
}

class Item {
  Item({
    required this.itemId,
    required this.productId,
    required this.productPlatform,
    required this.productTitle,
    required this.productLink,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    required this.attributes,
  });

  final int? itemId;
  final String? productId;
  final String? productPlatform;
  final String? productTitle;
  final String? productLink;
  final String? productImage;
  final String? productPrice;
  final int? quantity;
  final String? attributes;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json["item_id"],
      productId: json["product_id"],
      productPlatform: json["product_platform"],
      productTitle: json["product_title"],
      productLink: json["product_link"],
      productImage: json["product_image"],
      productPrice: json["product_price"],
      quantity: json["quantity"],
      attributes: json["attributes"],
    );
  }
}
