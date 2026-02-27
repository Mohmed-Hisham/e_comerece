import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: kReleaseMode ? Level.off : Level.all,
  );

  /// 🟤 Trace — اللون: رمادي (Gray)
  /// أدق مستوى من اللوجات، بيستخدم لتتبع التفاصيل الدقيقة جدًا
  /// زي دخول وخروج من functions أو قيم متغيرات أثناء الـ loop.
  /// مش هتحتاجه غير لو بتدور على bug صعب جدًا.
  static void verbose(String message) {
    _logger.t(message);
  }

  /// 🟢 Debug — اللون: أزرق فاتح (Cyan)
  /// بيستخدم أثناء التطوير لتتبع سير البرنامج.
  /// زي: "API call started" أو "User tapped button X".
  /// مفيد وأنت شغال على feature جديدة أو بتعمل debug.
  static void debug(String message) {
    _logger.d(message);
  }

  /// 🔵 Info — اللون: أزرق (Blue)
  /// معلومات عامة عن حالة التطبيق.
  /// زي: "User logged in" أو "Data loaded successfully".
  /// بتأكد إن الحاجات الأساسية شغالة تمام.
  static void info(String message) {
    _logger.i(message);
  }

  /// 🟡 Warning — اللون: أصفر (Yellow)
  /// بيدل إن في حاجة مش مثالية بس التطبيق لسه شغال.
  /// زي: "Cache expired, fetching new data" أو "Deprecated API used".
  /// تحذير إنك تراجع الحتة دي قبل ما تبقى مشكلة حقيقية.
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 🔴 Error — اللون: أحمر (Red)
  /// خطأ حصل بس التطبيق لسه شغال ومتأثرش كله.
  /// زي: "Failed to load user profile" أو "Network request timeout".
  /// لازم تتعامل معاه وتعمله handling مناسب.
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 🟣 Fatal — اللون: أحمر غامق / بنفسجي (Dark Red / Magenta)
  /// أخطر مستوى — خطأ كارثي التطبيق مش هيقدر يكمل بعده.
  /// زي: "Database corrupted" أو "Critical auth failure".
  /// معناه إن التطبيق لازم يتقفل أو يعمل restart.
  static void fatal(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
