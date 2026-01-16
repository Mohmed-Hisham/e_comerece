class CreateOrderRequest {
  final String addressId;
  final String? paymentMethod;
  final String? chatId;
  final String? couponId;
  final double productReviewFee;
  final double? deliveryFee;
  final double? deliveryTips;
  final String? noteUser;

  CreateOrderRequest({
    required this.addressId,
    this.paymentMethod,
    this.chatId,
    this.couponId,
    required this.productReviewFee,
    this.deliveryFee,
    this.deliveryTips,
    this.noteUser,
  });

  Map<String, dynamic> toJson() {
    return {
      "addressId": addressId,
      if (paymentMethod != null) "paymentMethod": paymentMethod,
      if (chatId != null) "chatId": chatId,
      if (couponId != null) "couponId": couponId,
      "productReviewFee": productReviewFee,
      if (deliveryFee != null) "deliveryFee": deliveryFee,
      if (deliveryTips != null) "deliveryTips": deliveryTips,
      if (noteUser != null) "noteUser": noteUser,
    };
  }
}
