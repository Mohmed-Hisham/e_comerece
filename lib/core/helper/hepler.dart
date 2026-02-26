import 'dart:developer';

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Hepler {
  static String getFirebaseErrorFriendlyMessage(String? code, String? message) {
    log('Firebase Error: code=$code, message=$message');

    switch (code) {
      case 'invalid-phone-number':
        return StringsKeys.invalidPhoneNumber.tr;
      case 'too-many-requests':
        return StringsKeys.tooManyRequests.tr;
      case 'quota-exceeded':
        return StringsKeys.quotaExceeded.tr;
      case 'app-not-authorized':
      case 'captcha-check-failed':
      case 'missing-client-identifier':
        return StringsKeys.verificationFailed.tr;
      case 'network-request-failed':
        return StringsKeys.noInternetConnection.tr;
      case 'session-expired':
        return StringsKeys.sessionExpired.tr;
      case 'invalid-verification-code':
        return StringsKeys.invalidVerificationCode.tr;
      case 'invalid-verification-id':
        return StringsKeys.invalidVerificationId.tr;
      default:
        return StringsKeys.otpSendFailedUseEmail.tr;
    }
  }
}

Widget buildHeader() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringsKeys.relatedProducts.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.black,
          ),
        ),
      ],
    ),
  );
}
