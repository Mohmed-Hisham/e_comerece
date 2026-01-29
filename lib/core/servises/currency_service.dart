import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/currency.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyService extends GetxService {
  static const String _currencyKey = 'selected_currency';
  static const String _defaultCurrency = 'USD';

  late SharedPreferences _prefs;
  RatesData? ratesData;
  String selectedCurrency = _defaultCurrency;

  final List<String> availableCurrencies = ['USD', 'SAR', 'AED', 'YER'];

  Future<CurrencyService> init() async {
    _prefs = await SharedPreferences.getInstance();
    selectedCurrency = _prefs.getString(_currencyKey) ?? _defaultCurrency;
    await fetchRates();
    return this;
  }

  Future<void> fetchRates() async {
    try {
      final apiService = Get.put(ApiService());
      final response = await apiService
          .get(endpoint: ApisUrl.getCurrency)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 && response.data['success'] == true) {
        ratesData = RatesData.fromMap(response.data['data']);
        log('Currency rates loaded: ${ratesData!.rates}');
      } else {
        log('Failed to fetch currency rates: ${response.data['message']}');
        _setDefaultRates();
      }
    } on DioException catch (e) {
      log('DioException fetching rates: ${e.message}');
      _setDefaultRates();
    } catch (e) {
      log('Error fetching rates: $e');
      _setDefaultRates();
    }
  }

  void _setDefaultRates() {
    ratesData = RatesData(
      baseCurrency: 'USD',
      rates: {'USD': 1.0, 'SAR': 3.75, 'AED': 3.6725, 'YER': 238.39},
      status: 'fallback',
    );
  }

  Future<void> setSelectedCurrency(String currency) async {
    if (availableCurrencies.contains(currency)) {
      selectedCurrency = currency;
      await _prefs.setString(_currencyKey, currency);
      log('Currency changed to: $currency');
    }
  }

  String getCurrencySymbol(String currencyCode) {
    switch (currencyCode) {
      case 'USD':
        return '\$';
      case 'SAR':
        return 'SAR';
      case 'AED':
        return 'AED';
      case 'YER':
        return 'YER';
      default:
        return currencyCode;
    }
  }

  /// Converts an amount from one currency to the selected display currency.
  /// Returns a formatted string like "$100.00" or "375.00 SAR".
  String convertAndFormat({
    required double amount,
    required String from,
    int decimals = 2,
  }) {
    if (ratesData == null) {
      return '${getCurrencySymbol(from)}${amount.toStringAsFixed(decimals)}';
    }

    final result = convertUsingRatesData(
      data: ratesData!,
      amount: amount,
      from: from,
      to: selectedCurrency,
      decimals: decimals,
    );

    if (result.success && result.value != null) {
      final symbol = getCurrencySymbol(selectedCurrency);
      if (selectedCurrency == 'USD') {
        return '$symbol${result.value!.toStringAsFixed(decimals)}';
      }
      return '${result.value!.toStringAsFixed(decimals)} $symbol';
    }

    // Fallback to original amount if conversion fails
    return '${getCurrencySymbol(from)}${amount.toStringAsFixed(decimals)}';
  }

  /// Handles both single prices and ranges (e.g., "$0.55 - 1.69" or "$1.00").
  /// Returns a formatted string with the target currency.
  String convertAndFormatRange({
    required String priceText,
    required String from,
    int decimals = 2,
  }) {
    if (priceText.contains('-')) {
      final parts = priceText.split('-').map((e) => e.trim()).toList();
      final convertedParts = parts.map((part) {
        final amount = _extractNumeric(part);
        return _convertValueOnly(amount, from, decimals);
      }).toList();

      final symbol = getCurrencySymbol(selectedCurrency);
      if (selectedCurrency == 'USD') {
        return '$symbol${convertedParts.join(" - $symbol")}';
      }
      return '${convertedParts.join(" - ")} $symbol';
    } else {
      final amount = _extractNumeric(priceText);
      return convertAndFormat(amount: amount, from: from, decimals: decimals);
    }
  }

  double _extractNumeric(String text) {
    final regex = RegExp(r'([0-9]+(\.[0-9]+)?)');
    final match = regex.firstMatch(text);
    if (match != null) {
      return double.tryParse(match.group(1)!) ?? 0.0;
    }
    return 0.0;
  }

  String _convertValueOnly(double amount, String from, int decimals) {
    if (ratesData == null) return amount.toStringAsFixed(decimals);
    final result = convertUsingRatesData(
      data: ratesData!,
      amount: amount,
      from: from,
      to: selectedCurrency,
      decimals: decimals,
    );
    return result.success && result.value != null
        ? result.value!.toStringAsFixed(decimals)
        : amount.toStringAsFixed(decimals);
  }

  /// Returns just the converted numeric value (alias for convert)
  double? convertNumeric({
    required double amount,
    required String from,
    String? to,
    int decimals = 2,
  }) => convert(amount: amount, from: from, to: to, decimals: decimals);

  /// Returns just the converted numeric value
  double? convert({
    required double amount,
    required String from,
    String? to,
    int decimals = 2,
  }) {
    if (ratesData == null) return amount;

    final result = convertUsingRatesData(
      data: ratesData!,
      amount: amount,
      from: from,
      to: to ?? selectedCurrency,
      decimals: decimals,
    );

    return result.success ? result.value : amount;
  }
}

Future<void> initCurrencyService() async {
  await Get.putAsync(() => CurrencyService().init());
}
