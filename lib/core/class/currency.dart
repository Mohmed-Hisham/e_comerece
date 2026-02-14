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

class PlatformVisibility {
  final bool showShein;
  final bool showAlibaba;
  final bool showAliexpress;
  final bool showAmazon;
  final bool showLocalProducts;

  PlatformVisibility({
    this.showShein = true,
    this.showAlibaba = true,
    this.showAliexpress = true,
    this.showAmazon = true,
    this.showLocalProducts = true,
  });

  factory PlatformVisibility.fromMap(Map<String, dynamic> map) {
    return PlatformVisibility(
      showShein: map['show_shein'] ?? true,
      showAlibaba: map['show_alibaba'] ?? true,
      showAliexpress: map['show_aliexpress'] ?? true,
      showAmazon: map['show_amazon'] ?? true,
      showLocalProducts: map['show_local_products'] ?? true,
    );
  }
}

class GeneralSettings {
  final bool maintenanceMode;
  final String? minVersionAndroid;
  final String? minVersionIos;

  GeneralSettings({
    this.maintenanceMode = false,
    this.minVersionAndroid,
    this.minVersionIos,
  });

  factory GeneralSettings.fromMap(Map<String, dynamic> map) {
    return GeneralSettings(
      maintenanceMode: map['maintenance_mode'] ?? false,
      minVersionAndroid: map['min_version_android'],
      minVersionIos: map['min_version_ios'],
    );
  }
}

class AppConfigModel {
  final RatesData ratesData;
  final PlatformVisibility platformVisibility;
  final GeneralSettings generalSettings;

  // New nullable fields (Fees/Coefficients)
  final String? qAmzon;
  final String? qAliExpriess;
  final String? qAlibaba;
  final String? qShein;

  AppConfigModel({
    required this.ratesData,
    required this.platformVisibility,
    required this.generalSettings,
    this.qAmzon,
    this.qAliExpriess,
    this.qAlibaba,
    this.qShein,
  });

  factory AppConfigModel.fromMap(Map<String, dynamic> map) {
    return AppConfigModel(
      ratesData: RatesData.fromMap(map),
      platformVisibility: PlatformVisibility.fromMap(
        Map<String, dynamic>.from(map['platform_visibility'] ?? {}),
      ),
      generalSettings: GeneralSettings.fromMap(
        Map<String, dynamic>.from(map['general_settings'] ?? {}),
      ),
      qAmzon: map['qAmzon']?.toString(),
      qAliExpriess: map['qAliExpriess']?.toString(),
      qAlibaba: map['qAlibaba']?.toString(),
      qShein: map['qShein']?.toString(),
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

  final base = data.baseCurrency.toUpperCase();
  if (!data.rates.containsKey(base)) {
    data.rates[base] = 1.0;
  }

  final rateFrom = data.rates[f];
  final rateTo = data.rates[t];

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
