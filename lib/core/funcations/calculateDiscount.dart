String calculateDiscountPercent(originalPrice, promotionPrice) {
  if (originalPrice == 0) return "0";
  if (originalPrice is String || originalPrice is String) {
    originalPrice = double.parse(originalPrice.toString());
    promotionPrice = double.parse(promotionPrice.toString());
  }
  double discount = originalPrice - promotionPrice;
  double discountPercent = (discount / originalPrice) * 100;
  return "${discountPercent.toStringAsFixed(0)}%";
}
