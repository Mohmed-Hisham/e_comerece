import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/helper/hepler.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum VerificationMethod { sms, email }

class VerificationData {
  final String verificationId;
  final int? resendToken;

  VerificationData({required this.verificationId, this.resendToken});
}

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
                userFriendlyError: Hepler.getFirebaseErrorFriendlyMessage(
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

  static Future<Either<String, String>> signInWithSmsCode({
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

      String? idToken = await userCredential.user?.getIdToken();
      log('🔑 Firebase ID Token: $idToken');

      if (idToken == null) {
        return const Left('فشل الحصول على التوكن');
      }

      return Right(idToken);
    } on FirebaseAuthException catch (e) {
      log(
        'FirebaseAuthException during signInWithSmsCode: ${e.code} - ${e.message}',
      );
      final friendlyError = Hepler.getFirebaseErrorFriendlyMessage(
        e.code,
        e.message,
      );
      return Left(friendlyError);
    } catch (e, st) {
      log('Unknown error during signInWithSmsCode: $e\n$st');
      return const Left('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى');
    }
  }
}
