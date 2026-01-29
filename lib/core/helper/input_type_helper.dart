/// Helper للتحقق من نوع الإدخال (هاتف أم إيميل)
class InputTypeHelper {
  /// التحقق مما إذا كان الإدخال رقم هاتف
  static bool isPhoneNumber(String input) {
    // إزالة المسافات والشرطات
    final cleanInput = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // يبدأ بـ + أو أرقام فقط وطوله مناسب لرقم هاتف
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    return phoneRegex.hasMatch(cleanInput);
  }

  /// التحقق مما إذا كان الإدخال بريد إلكتروني
  static bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input.trim());
  }

  /// تنظيف رقم الهاتف وتحويله لتنسيق E.164
  /// يدعم: مصر (+20) واليمن (+967)
  static String formatPhoneNumber(String phone) {
    // إزالة المسافات والشرطات والأقواس
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // إذا بدأ بـ + فهو جاهز
    if (cleanPhone.startsWith('+')) {
      return cleanPhone;
    }

    // إذا بدأ بـ 00 (كود دولي بديل)
    if (cleanPhone.startsWith('00')) {
      return '+${cleanPhone.substring(2)}';
    }

    // 🇪🇬 مصر: الأرقام تبدأ بـ 01 وطولها 11 رقم
    // مثال: 01012345678 → +201012345678
    if (cleanPhone.startsWith('01') && cleanPhone.length == 11) {
      return '+2$cleanPhone'; // +2 + 01012345678 = +201012345678
    }

    // 🇪🇬 مصر: لو بدأ بـ 1 مباشرة (بدون الصفر) وطوله 10
    // مثال: 1012345678 → +201012345678
    if (cleanPhone.startsWith('1') && cleanPhone.length == 10) {
      return '+20$cleanPhone';
    }

    // 🇾🇪 اليمن: الأرقام تبدأ بـ 07 وطولها 10 أرقام (مع الصفر)
    // مثال: 0771234567 → +967771234567
    if (cleanPhone.startsWith('07') && cleanPhone.length == 10) {
      return '+967${cleanPhone.substring(1)}'; // أزل الصفر الأول
    }

    // 🇾🇪 اليمن: لو بدأ بـ 7 مباشرة وطوله 9
    // مثال: 771234567 → +967771234567
    if (cleanPhone.startsWith('7') && cleanPhone.length == 9) {
      return '+967$cleanPhone';
    }

    // افتراضي: لو بدأ بـ 0 وطوله 11، نفترض مصر
    if (cleanPhone.startsWith('0') && cleanPhone.length == 11) {
      return '+2$cleanPhone';
    }

    // افتراضي: لو بدأ بـ 0 وطوله 10، نفترض يمن
    if (cleanPhone.startsWith('0') && cleanPhone.length == 10) {
      return '+967${cleanPhone.substring(1)}';
    }

    // لو ما حددنا البلد، نفترض مصر
    return '+20$cleanPhone';
  }

  /// كشف البلد من رقم الهاتف (يعمل من أول ما يبدأ الكتابة)
  static String? detectCountry(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // لو فاضي أو فيه حروف أو @ → مش رقم هاتف
    if (cleanPhone.isEmpty) return null;
    if (cleanPhone.contains('@')) return null;
    if (RegExp(r'[a-zA-Z]').hasMatch(cleanPhone)) return null;

    // 🇪🇬 مصر: +20 أو 0020
    if (cleanPhone.startsWith('+20') || cleanPhone.startsWith('0020')) {
      return 'EG';
    }
    // 🇾🇪 اليمن: +967 أو 00967
    if (cleanPhone.startsWith('+967') || cleanPhone.startsWith('00967')) {
      return 'YE';
    }

    // 🇪🇬 مصر: يبدأ بـ 01 (أرقام مصرية)
    if (cleanPhone.startsWith('01')) {
      return 'EG';
    }

    // 🇾🇪 اليمن: يبدأ بـ 07 أو 7
    if (cleanPhone.startsWith('07') || cleanPhone.startsWith('7')) {
      return 'YE';
    }

    // لو بدأ بـ + بس مش مصر ولا يمن
    if (cleanPhone.startsWith('+')) {
      return null;
    }

    // لو أرقام فقط وبدأ بـ 0 → نفترض مصر مبدئياً
    if (cleanPhone.startsWith('0') &&
        RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
      return 'EG';
    }

    // لو أرقام فقط → نفترض مصر
    if (RegExp(r'^[0-9]+$').hasMatch(cleanPhone) && cleanPhone.length >= 2) {
      return 'EG';
    }

    return null;
  }
}
