class CouponResponse {
  final String status;
  final String? error;
  final String? message;
  final CouponData? data;

  CouponResponse({required this.status, this.error, this.message, this.data});

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      status: json["status"],
      error: json["error"],
      message: json["message"],
      data: json["data"] != null ? CouponData.fromJson(json["data"]) : null,
    );
  }
}

class CouponData {
  // Success fields
  final int? couponId;
  final String? couponName;
  final double? couponDiscount;
  final String? couponPlatform;
  final String? couponExpired;
  final int? usageLimit;
  final int? remainingUses;

  // Error fields
  final int? userId;
  final int? usedCountByUser;

  CouponData({
    this.couponId,
    this.couponName,
    this.couponDiscount,
    this.couponPlatform,
    this.couponExpired,
    this.usageLimit,
    this.remainingUses,
    this.userId,
    this.usedCountByUser,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      couponId: json["coupon_id"],
      couponName: json["coupon_name"],
      couponDiscount: json["coupon_discount"] is int
          ? json["coupon_discount"].toDouble()
          : json["coupon_discount"],
      couponPlatform: json["coupon_platfrom"],
      couponExpired: json["coupon_expired"],
      usageLimit: json["usage_limit"],
      remainingUses: json["remaining_uses"],

      // error response fields
      userId: json["user_id"],
      usedCountByUser: json["used_count_by_user"],
    );
  }
}
