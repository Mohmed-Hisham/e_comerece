String calculateDiscountPercent(dynamic originalPrice, dynamic promotionPrice) {
  // لو أي من القيمتين null أو غير رقمي، نرجع "0%"
  if (originalPrice == null || promotionPrice == null) return "0%";

  // تحويل للنص أولًا
  String originalStr = originalPrice.toString().trim();
  String promoStr = promotionPrice.toString().trim();

  // إزالة أي رموز غير أرقام أو نقطة عشرية
  originalStr = originalStr.replaceAll(RegExp(r'[^0-9.]'), '');
  promoStr = promoStr.replaceAll(RegExp(r'[^0-9.]'), '');

  // تحويل آمن باستخدام tryParse
  double? original = double.tryParse(originalStr);
  double? promo = double.tryParse(promoStr);

  // لو ما استطعنا التحويل، نرجع "0%"
  if (original == null || promo == null || original == 0) {
    return "0%";
  }

  // حساب الخصم
  double discount = original - promo;
  double discountPercent = (discount / original) * 100;

  // إرجاع النسبة مع علامة %
  return "${discountPercent.toInt()}%"; // أو .toStringAsFixed(0) إذا تحب عدد عشري
}
