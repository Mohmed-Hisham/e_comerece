double extractPrice(String priceText) {
  final regex = RegExp(r'([0-9]+(\.[0-9]+)?)');

  final match = regex.firstMatch(priceText);

  if (match != null) {
    return double.parse(match.group(0)!);
  } else {
    return 0.0;
  }
}
