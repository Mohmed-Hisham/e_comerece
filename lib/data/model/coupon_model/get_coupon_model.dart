class CouponResponse {
  CouponResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final CouponData? data;
  final dynamic errors;

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : CouponData.fromJson(json["data"]),
      errors: json["errors"],
    );
  }
}

class CouponData {
  CouponData({
    required this.id,
    required this.couponName,
    required this.couponDiscount,
    required this.couponPlatfrom,
    required this.couponExpired,
    required this.usageLimit,
    required this.remainingUses,
  });

  final String? id;
  final String? couponName;
  final double? couponDiscount;
  final String? couponPlatfrom;
  final DateTime? couponExpired;
  final int? usageLimit;
  final int? remainingUses;

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      id: json["id"],
      couponName: json["coupon_name"],
      couponDiscount: json["coupon_discount"]?.toDouble(),
      couponPlatfrom: json["coupon_platfrom"],
      couponExpired: DateTime.tryParse(json["coupon_expired"] ?? ""),
      usageLimit: json["usage_limit"],
      remainingUses: json["remaining_uses"],
    );
  }
}
