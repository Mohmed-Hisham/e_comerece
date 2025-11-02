String extractNumbers(String value) {
  final numericString = value.replaceAll(RegExp(r'[^0-9.]'), '');
  return numericString;
}
