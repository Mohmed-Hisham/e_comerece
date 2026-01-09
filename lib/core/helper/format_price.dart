double extractPrice(dynamic price) {
  if (price == null) return 0.0;
  if (price is num) return price.toDouble();
  
  final String priceText = price.toString();
  final regex = RegExp(r'([0-9]+(\.[0-9]+)?)');

  final match = regex.firstMatch(priceText);

  if (match != null) {
    return double.parse(match.group(1)!);
  } else {
    return 0.0;
  }
}
