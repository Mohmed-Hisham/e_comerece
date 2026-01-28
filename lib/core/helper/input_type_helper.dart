/// Helper للتحقق من نوع الإدخال (هاتف أم إيميل)
class InputTypeHelper {
  /// التحقق مما إذا كان الإدخال رقم هاتف
  static bool isPhoneNumber(String input) {
    // يبدأ بـ + أو أرقام فقط وطوله مناسب لرقم هاتف
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    // إزالة المسافات والشرطات
    final cleanInput = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return phoneRegex.hasMatch(cleanInput);
  }

  /// التحقق مما إذا كان الإدخال بريد إلكتروني
  static bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input.trim());
  }

  /// تنظيف رقم الهاتف وإضافة كود الدولة إذا لزم الأمر
  static String formatPhoneNumber(
    String phone, {
    String defaultCountryCode = '+20',
  }) {
    // إزالة المسافات والشرطات
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // إذا لم يبدأ بـ + أضف كود الدولة
    if (!cleanPhone.startsWith('+')) {
      // إذا بدأ بـ 0، أزل الصفر وأضف كود الدولة
      if (cleanPhone.startsWith('0')) {
        cleanPhone = defaultCountryCode + cleanPhone.substring(1);
      } else {
        cleanPhone = defaultCountryCode + cleanPhone;
      }
    }

    return cleanPhone;
  }
}
