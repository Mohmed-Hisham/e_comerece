String calculateDiscountPercent(dynamic originalPrice, dynamic promotionPrice) {
  if (originalPrice == null || promotionPrice == null) return "0%";

  String originalStr = originalPrice.toString().trim();
  String promoStr = promotionPrice.toString().trim();

  originalStr = originalStr.replaceAll(RegExp(r'[^0-9.]'), '');
  promoStr = promoStr.replaceAll(RegExp(r'[^0-9.]'), '');

  double? original = double.tryParse(originalStr);
  double? promo = double.tryParse(promoStr);

  if (original == null || promo == null || original == 0) {
    return "0%";
  }

  double discount = original - promo;
  double discountPercent = (discount / original) * 100;

  return "${discountPercent.toInt()}%";
}
