import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// نوع طريقة التحقق المختارة
enum VerificationMethod { sms, email }

/// بيانات التحقق عبر SMS
class VerificationData {
  final String verificationId;
  final int? resendToken;

  VerificationData({required this.verificationId, this.resendToken});
}

/// نتيجة إرسال OTP - تحتوي على رسالة خطأ للمستخدم أو بيانات التحقق
class OtpResult {
  final bool success;
  final String? userFriendlyError; // رسالة ودية للمستخدم
  final String? technicalError; // الخطأ التقني للـ log
  final VerificationData? verificationData;
  final bool
  shouldSuggestEmail; // هل نقترح على المستخدم استخدام الإيميل بدلاً من ذلك

  OtpResult._({
    required this.success,
    this.userFriendlyError,
    this.technicalError,
    this.verificationData,
    this.shouldSuggestEmail = false,
  });

  factory OtpResult.success(VerificationData data) {
    return OtpResult._(success: true, verificationData: data);
  }

  factory OtpResult.failure({
    required String userFriendlyError,
    String? technicalError,
    bool shouldSuggestEmail = true,
  }) {
    return OtpResult._(
      success: false,
      userFriendlyError: userFriendlyError,
      technicalError: technicalError,
      shouldSuggestEmail: shouldSuggestEmail,
    );
  }
}

class SendOtpHelper {
  /// تحويل أخطاء Firebase إلى رسائل ودية للمستخدم
  static String _getFirebaseErrorFriendlyMessage(
    String? code,
    String? message,
  ) {
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

  /// إرسال OTP عبر رقم الهاتف
  static Future<OtpResult> verifyPhone(
    String phoneNumber, {
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Completer<OtpResult> completer = Completer();

    // Safety timer in case callbacks never fire
    Timer? safetyTimer;
    safetyTimer = Timer(timeout + const Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.complete(
          OtpResult.failure(
            userFriendlyError: 'انتهت مهلة الانتظار، يرجى المحاولة مرة أخرى',
            technicalError: 'Timeout: no response from verification service.',
            shouldSuggestEmail: true,
          ),
        );
      }
    });

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('verificationCompleted (auto): $phoneNumber');

          // التحقق التلقائي تم - يمكنك تسجيل الدخول تلقائياً هنا
          // await auth.signInWithCredential(credential);

          if (!completer.isCompleted) {
            // نعتبر التحقق التلقائي نجاح (حالة خاصة)
            completer.complete(
              OtpResult.failure(
                userFriendlyError: 'تم التحقق تلقائياً',
                technicalError: 'Automatic verification completed on device.',
                shouldSuggestEmail: false,
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          log('verificationFailed: ${e.code} ${e.message}');
          if (!completer.isCompleted) {
            completer.complete(
              OtpResult.failure(
                userFriendlyError: _getFirebaseErrorFriendlyMessage(
                  e.code,
                  e.message,
                ),
                technicalError: '${e.code}: ${e.message}',
                shouldSuggestEmail: true,
              ),
            );
          }
        },
        codeSent: (String verId, int? resendToken) {
          log(
            'codeSent to $phoneNumber, verificationId: $verId, resendToken: $resendToken',
          );
          if (!completer.isCompleted) {
            completer.complete(
              OtpResult.success(
                VerificationData(
                  verificationId: verId,
                  resendToken: resendToken,
                ),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          log('codeAutoRetrievalTimeout: verificationId=$verId');
          // قد نكون أكملنا عبر codeSent، لكن إذا لم نكمل، نكمل بـ verId كاحتياطي
          if (!completer.isCompleted) {
            completer.complete(
              OtpResult.success(VerificationData(verificationId: verId)),
            );
          }
        },
      );
    } catch (e, st) {
      log('verifyPhone exception: $e\n$st');
      if (!completer.isCompleted) {
        completer.complete(
          OtpResult.failure(
            userFriendlyError:
                'فشل إرسال رمز التحقق، يرجى المحاولة عبر البريد الإلكتروني',
            technicalError: 'Failed to start phone verification: $e',
            shouldSuggestEmail: true,
          ),
        );
      }
    }

    final result = await completer.future;
    safetyTimer.cancel();
    return result;
  }

  /// التحقق من رمز SMS المُدخل
  /// Returns Either<errorMessage, bool>
  static Future<Either<String, bool>> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode.trim(),
      );

      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      // نجاح
      log('Signed in UID: ${userCredential.user?.uid}');
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      log(
        'FirebaseAuthException during signInWithSmsCode: ${e.code} - ${e.message}',
      );
      // رسالة ودية للمستخدم بدلاً من رسالة Firebase
      final friendlyError = _getFirebaseErrorFriendlyMessage(e.code, e.message);
      return Left(friendlyError);
    } catch (e, st) {
      log('Unknown error during signInWithSmsCode: $e\n$st');
      return const Left('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى');
    }
  }

  /// Legacy method - للتوافق مع الكود القديم
  static Future<Either<String, VerificationData>> verifyPhoneLegacy(
    String phoneNumber, {
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final result = await verifyPhone(phoneNumber, timeout: timeout);
    if (result.success && result.verificationData != null) {
      return Right(result.verificationData!);
    } else {
      return Left(result.userFriendlyError ?? 'فشل إرسال رمز التحقق');
    }
  }
}
