import 'package:intl/intl.dart';

double extractPrice(dynamic price) {
  if (price == null) return 0.0;
  if (price is num) return price.toDouble();

  String priceText = price.toString();

  priceText = priceText.replaceAll(RegExp(r'[^\d.,]'), '');

  // Handle comma as thousands separator (e.g. "3,699.00" or "4,779.00")
  if (priceText.contains(',') && priceText.contains('.')) {
    // Comma is thousands separator, dot is decimal: "3,699.00" → "3699.00"
    priceText = priceText.replaceAll(',', '');
  } else if (priceText.contains(',') && !priceText.contains('.')) {
    // Could be "3,699" (thousands) or "3,50" (decimal)
    // If there are multiple commas or digits after comma > 2, treat as thousands
    final parts = priceText.split(',');
    if (parts.length > 2 || (parts.last.length == 3)) {
      priceText = priceText.replaceAll(',', '');
    } else {
      // Treat comma as decimal separator
      priceText = priceText.replaceAll(',', '.');
    }
  }

  return double.tryParse(priceText) ?? 0.0;
}

String formatPrice(double price) {
  String formattedPrice = NumberFormat('#,###.00').format(price);
  return formattedPrice;
}
