class InputTypeHelper {
  static bool isPhoneNumber(String input) {
    final cleanInput = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    return phoneRegex.hasMatch(cleanInput);
  }

  static bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input.trim());
  }

  static String formatPhoneNumber(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanPhone.startsWith('+')) {
      return cleanPhone;
    }

    if (cleanPhone.startsWith('00')) {
      return '+${cleanPhone.substring(2)}';
    }

    if (cleanPhone.startsWith('01') && cleanPhone.length == 11) {
      return '+2$cleanPhone';
    }

    if (cleanPhone.startsWith('1') && cleanPhone.length == 10) {
      return '+20$cleanPhone';
    }

    if (cleanPhone.startsWith('07') && cleanPhone.length == 10) {
      return '+967${cleanPhone.substring(1)}';
    }

    if (cleanPhone.startsWith('7') && cleanPhone.length == 9) {
      return '+967$cleanPhone';
    }

    if (cleanPhone.startsWith('0') && cleanPhone.length == 11) {
      return '+2$cleanPhone';
    }

    if (cleanPhone.startsWith('0') && cleanPhone.length == 10) {
      return '+967${cleanPhone.substring(1)}';
    }

    return '+20$cleanPhone';
  }

  static String? detectCountry(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanPhone.isEmpty) return null;
    if (cleanPhone.contains('@')) return null;
    if (RegExp(r'[a-zA-Z]').hasMatch(cleanPhone)) return null;

    if (cleanPhone.startsWith('+20') || cleanPhone.startsWith('0020')) {
      return 'EG';
    }
    if (cleanPhone.startsWith('+967') || cleanPhone.startsWith('00967')) {
      return 'YE';
    }

    if (cleanPhone.startsWith('01')) {
      return 'EG';
    }

    if (cleanPhone.startsWith('07') || cleanPhone.startsWith('7')) {
      return 'YE';
    }

    if (cleanPhone.startsWith('+')) {
      return null;
    }

    if (cleanPhone.startsWith('0') &&
        RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
      return 'EG';
    }

    if (RegExp(r'^[0-9]+$').hasMatch(cleanPhone) && cleanPhone.length >= 2) {
      return 'EG';
    }

    return null;
  }
}
