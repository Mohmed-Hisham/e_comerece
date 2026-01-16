class OrderDetailsModel {
  bool? success;
  String? message;
  OrderDetailsData? data;

  OrderDetailsModel({this.success, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? OrderDetailsData.fromJson(json['data'])
        : null;
  }
}

class OrderDetailsData {
  String? id;
  String? orderNumber;
  String? addressId;
  OrderAddress? address;
  String? paymentMethod;
  String? chatId;
  double? subtotal;
  String? couponId;
  OrderCoupon? coupon;
  double? couponDiscount;
  String? couponName;
  double? productReviewFee;
  double? deliveryTips;
  double? total;
  String? status;
  String? statusName;
  String? noteUser;
  String? noteAdmin;
  String? createdAt;
  String? updatedAt;
  List<OrderDetailsItem>? items;

  OrderDetailsData({
    this.id,
    this.orderNumber,
    this.addressId,
    this.address,
    this.paymentMethod,
    this.chatId,
    this.subtotal,
    this.couponId,
    this.coupon,
    this.couponDiscount,
    this.couponName,
    this.productReviewFee,
    this.deliveryTips,
    this.total,
    this.status,
    this.statusName,
    this.noteUser,
    this.noteAdmin,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    addressId = json['addressId'];
    address = json['address'] != null
        ? OrderAddress.fromJson(json['address'])
        : null;
    paymentMethod = json['paymentMethod'];
    chatId = json['chatId'];
    subtotal = (json['subtotal'] as num?)?.toDouble();
    couponId = json['couponId'];
    coupon = json['coupon'] != null
        ? OrderCoupon.fromJson(json['coupon'])
        : null;
    couponDiscount = (json['couponDiscount'] as num?)?.toDouble();
    couponName = json['couponName'];
    productReviewFee = (json['productReviewFee'] as num?)?.toDouble();
    deliveryTips = (json['deliveryTips'] as num?)?.toDouble();
    total = (json['total'] as num?)?.toDouble();
    status = json['status'];
    statusName = json['statusName'];
    noteUser = json['noteUser'];
    noteAdmin = json['noteAdmin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['items'] != null) {
      items = <OrderDetailsItem>[];
      json['items'].forEach((v) {
        items!.add(OrderDetailsItem.fromJson(v));
      });
    }
  }
}

class OrderAddress {
  String? id;
  String? title;
  String? city;
  String? street;
  String? building;
  String? apartment;
  String? floor;
  double? lng;
  double? lat;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  OrderAddress({
    this.id,
    this.title,
    this.city,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    this.lng,
    this.lat,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    city = json['city'];
    street = json['street'];
    building = json['building'];
    apartment = json['apartment'];
    floor = json['floor'];
    lng = (json['lng'] as num?)?.toDouble();
    lat = (json['lat'] as num?)?.toDouble();
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderCoupon {
  String? id;
  String? couponName;
  double? couponDiscount;
  String? couponPlatfrom;
  String? couponExpired;
  int? usageLimit;
  int? remainingUses;

  OrderCoupon({
    this.id,
    this.couponName,
    this.couponDiscount,
    this.couponPlatfrom,
    this.couponExpired,
    this.usageLimit,
    this.remainingUses,
  });

  OrderCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponName = json['coupon_name'];
    couponDiscount = (json['coupon_discount'] as num?)?.toDouble();
    couponPlatfrom = json['coupon_platfrom'];
    couponExpired = json['coupon_expired'];
    usageLimit = json['usage_limit'];
    remainingUses = json['remaining_uses'];
  }
}

class OrderDetailsItem {
  String? id;
  String? productId;
  String? productTitle;
  String? productImage;
  double? productPrice;
  int? quantity;
  String? attributes;
  String? platform;
  String? tier;
  String? goodsSn;
  String? categoryId;
  String? productLink;
  String? createdAt;

  OrderDetailsItem({
    this.id,
    this.productId,
    this.productTitle,
    this.productImage,
    this.productPrice,
    this.quantity,
    this.attributes,
    this.platform,
    this.tier,
    this.goodsSn,
    this.categoryId,
    this.productLink,
    this.createdAt,
  });

  OrderDetailsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
    productPrice = (json['productPrice'] as num?)?.toDouble();
    quantity = json['quantity'];
    attributes = json['attributes'];
    platform = json['platform'];
    tier = json['tier'];
    goodsSn = json['goodsSn'];
    categoryId = json['categoryId'];
    productLink = json['productLink'];
    createdAt = json['createdAt'];
  }
}
