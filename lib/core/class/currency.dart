class RatesData {
  final String baseCurrency; // e.g. "USD"
  final Map<String, double> rates; // e.g. {"USD":1.0, "SAR":3.75, ...}
  final DateTime? lastUpdated;
  final String status; // "success" | "failed" etc.

  RatesData({
    required this.baseCurrency,
    required this.rates,
    this.lastUpdated,
    this.status = 'unknown',
  });

  factory RatesData.fromMap(Map<String, dynamic> map) {
    final base = (map['base_currency'] ?? map['base'] ?? 'USD').toString();
    final ratesRaw = Map<String, dynamic>.from(map['rates'] ?? {});
    final rates = <String, double>{};
    ratesRaw.forEach((k, v) {
      try {
        rates[k.toUpperCase()] = (v is num)
            ? v.toDouble()
            : double.parse(v.toString());
      } catch (_) {}
    });

    DateTime? last;
    try {
      final lu = map['last_updated'] ?? map['date'];
      if (lu != null) last = DateTime.parse(lu.toString());
    } catch (_) {}

    return RatesData(
      baseCurrency: base.toUpperCase(),
      rates: rates,
      lastUpdated: last,
      status: (map['status'] ?? 'unknown').toString(),
    );
  }
}

class ConversionResult {
  final bool success;
  final double? value; // rounded (for display)
  final double? rawValue; // full precision
  final double? rateFrom; // rate[from] against base (units per 1 base)
  final double? rateTo; // rate[to] against base
  final DateTime? lastUpdated;
  final String? errorMessage;
  final bool isOutdated; // if status != "success"

  ConversionResult({
    required this.success,
    this.value,
    this.rawValue,
    this.rateFrom,
    this.rateTo,
    this.lastUpdated,
    this.errorMessage,
    this.isOutdated = false,
  });
}

/// الدالة الأساسية للتحويل
ConversionResult convertUsingRatesData({
  required RatesData data,
  required double amount,
  required String from, // مثال: "SAR"
  required String to, // مثال: "USD"
  int decimals = 2, // عدد الأرقام بعد الفاصلة للعرض
  Duration outdatedThreshold = const Duration(hours: 24), // for isOutdated flag
}) {
  // Normalize currency codes
  final f = from.trim().toUpperCase();
  final t = to.trim().toUpperCase();

  // Quick success if same currency
  if (f == t) {
    final rounded = double.parse((amount).toStringAsFixed(decimals));
    return ConversionResult(
      success: true,
      value: rounded,
      rawValue: amount,
      rateFrom: data.rates[f] ?? (f == data.baseCurrency ? 1.0 : null),
      rateTo: data.rates[t] ?? (t == data.baseCurrency ? 1.0 : null),
      lastUpdated: data.lastUpdated,
      isOutdated: data.lastUpdated == null
          ? false
          : (DateTime.now().toUtc().difference(data.lastUpdated!.toUtc()) >
                outdatedThreshold),
    );
  }

  // Ensure rates contain the base currency
  final base = data.baseCurrency.toUpperCase();
  if (!data.rates.containsKey(base)) {
    // ensure base present
    data.rates[base] = 1.0;
  }

  // Look up rates
  final rateFrom = data.rates[f];
  final rateTo = data.rates[t];

  // If either rate is missing -> fail with informative message
  if (rateFrom == null) {
    return ConversionResult(
      success: false,
      errorMessage: 'Missing rate for currency: $f',
      lastUpdated: data.lastUpdated,
      isOutdated: data.status.toLowerCase() != 'success',
    );
  }
  if (rateTo == null) {
    return ConversionResult(
      success: false,
      errorMessage: 'Missing rate for currency: $t',
      lastUpdated: data.lastUpdated,
      isOutdated: data.status.toLowerCase() != 'success',
    );
  }

  // Defensive: avoid division by zero
  if (rateFrom == 0) {
    return ConversionResult(
      success: false,
      errorMessage: 'Invalid rate (zero) for currency: $f',
      lastUpdated: data.lastUpdated,
      isOutdated: data.status.toLowerCase() != 'success',
    );
  }

  // Conversion formula (all rates are units-per-1-baseCurrency, e.g. 1 USD = 3.75 SAR)
  // price_in_base = amount / rateFrom
  // result = price_in_base * rateTo
  final priceInBase = amount / rateFrom;
  final rawResult = priceInBase * rateTo;
  final rounded = double.parse(rawResult.toStringAsFixed(decimals));

  return ConversionResult(
    success: true,
    value: rounded,
    rawValue: rawResult,
    rateFrom: rateFrom,
    rateTo: rateTo,
    lastUpdated: data.lastUpdated,
    isOutdated:
        data.status.toLowerCase() != 'success' ||
        (data.lastUpdated != null &&
            DateTime.now().toUtc().difference(data.lastUpdated!.toUtc()) >
                outdatedThreshold),
  );
}
