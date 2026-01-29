import 'dart:developer';

class Hepler {
  static String getFirebaseErrorFriendlyMessage(String? code, String? message) {
    // سجل الخطأ التقني للمطورين
    log('Firebase Error: code=$code, message=$message');

    switch (code) {
      case 'invalid-phone-number':
        return 'رقم الهاتف غير صحيح، يرجى التأكد من الرقم';
      case 'too-many-requests':
        return 'تم إرسال طلبات كثيرة، يرجى المحاولة لاحقاً';
      case 'quota-exceeded':
        return 'تم تجاوز الحد المسموح، يرجى المحاولة لاحقاً';
      case 'app-not-authorized':
      case 'captcha-check-failed':
      case 'missing-client-identifier':
        return 'حدث خطأ في التحقق، يرجى المحاولة مرة أخرى';
      case 'network-request-failed':
        return 'تحقق من اتصالك بالإنترنت';
      case 'session-expired':
        return 'انتهت صلاحية الجلسة، يرجى المحاولة مرة أخرى';
      case 'invalid-verification-code':
        return 'رمز التحقق غير صحيح';
      case 'invalid-verification-id':
        return 'انتهت صلاحية الرمز، يرجى طلب رمز جديد';
      default:
        // رسالة عامة للأخطاء غير المعروفة
        return 'فشل إرسال رمز التحقق، يرجى المحاولة عبر البريد الإلكتروني';
    }
  }
}
