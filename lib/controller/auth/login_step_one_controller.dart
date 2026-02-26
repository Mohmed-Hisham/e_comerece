import 'dart:developer';

import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/auth_success_handler.dart';
import 'package:e_comerece/core/helper/google_sign_in_helper.dart';
import 'package:e_comerece/core/helper/input_type_helper.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginStepOneController extends GetxController {
  goToSginup();
  loginStepOne();
  signInWithGoogle();
}

class LLoginStepOneControllerimplment extends LoginStepOneController {
  ScrollController scrollController = ScrollController();
  FocusNode emailFocus = .new();

  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  TextEditingController email = .new();
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  VerificationData? smsVerificationData;

  String? detectedCountry;

  @override
  void onInit() {
    super.onInit();
    email.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    final input = email.text.trim();
    final newCountry = InputTypeHelper.detectCountry(input);

    if (newCountry != detectedCountry) {
      detectedCountry = newCountry;
      update(['country_prefix']);
    }
  }

  String? get countryFlag {
    switch (detectedCountry) {
      case 'EG':
        return '🇪🇬';
      case 'YE':
        return '🇾🇪';
      default:
        return null;
    }
  }

  String? get countryCode {
    switch (detectedCountry) {
      case 'EG':
        return '+20';
      case 'YE':
        return '+967';
      default:
        return null;
    }
  }

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  void dispose() {
    email.removeListener(_onInputChanged);
    super.dispose();
    email.dispose();
    emailFocus.dispose();
    scrollController.dispose();
  }

  @override
  loginStepOne() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }

      final input = email.text.trim();
      final isPhone = InputTypeHelper.isPhoneNumber(input);

      final response = await authRepoImpl.loginStepOne(
        AuthData(identifier: input),
      );

      final r = response.fold((l) => l, (r) => r);

      if (r is AuthModel && r.success == true) {
        if (isPhone) {
          final phoneNumber = InputTypeHelper.formatPhoneNumber(input);
          debugPrint('📱 Sending OTP to: $phoneNumber (original: $input)');

          final otpResult = await SendOtpHelper.verifyPhone(phoneNumber);

          if (Get.isDialogOpen ?? false) Get.back();

          if (otpResult.success && otpResult.verificationData != null) {
            smsVerificationData = otpResult.verificationData;
            showCustomGetSnack(
              isGreen: true,
              text: r.message ?? StringsKeys.verificationCodeSent.tr,
            );
            Get.toNamed(
              AppRoutesname.login,
              arguments: {
                "identifier": input,
                "phone": phoneNumber,
                "name": r.authData?.name ?? "",
                "isPhone": true,
                "verificationId": smsVerificationData!.verificationId,
              },
            );
          } else {
            showCustomGetSnack(
              isGreen: false,
              text:
                  '${otpResult.userFriendlyError ?? StringsKeys.smsSendFailed.tr}\n${StringsKeys.tryWithEmail.tr}',
            );
          }
        } else {
          if (Get.isDialogOpen ?? false) Get.back();
          showCustomGetSnack(isGreen: true, text: r.message!);
          Get.toNamed(
            AppRoutesname.login,
            arguments: {
              "identifier": input,
              "email": input,
              "name": r.authData?.name ?? "",
              "isPhone": false,
            },
          );
        }
      } else if (r is Failure) {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
      }

      emailFocus.unfocus();
      statusrequest = Statusrequest.success;
      update();
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    statusrequest = Statusrequest.loading;
    update();
    loadingDialog();

    // 1️⃣ الحصول على Google ID Token
    final googleToken = await GoogleSignInHelper.signIn();

    // إذا فشل أو ألغى المستخدم
    if (googleToken == null) {
      if (Get.isDialogOpen ?? false) Get.back();
      statusrequest = Statusrequest.none;
      update();
      return;
    }

    debugPrint('🔑 Got Google Token, sending to backend...');

    // 2️⃣ إرسال Token للـ Backend
    final response = await authRepoImpl.googleLogin(googleToken);

    if (Get.isDialogOpen ?? false) Get.back();

    final result = response.fold((l) => l, (r) => r);

    if (result is AuthModel &&
        result.success == true &&
        result.authData != null) {
      // ✅ نجاح التسجيل/الدخول
      showCustomGetSnack(
        isGreen: true,
        text: result.message ?? StringsKeys.loginSuccess.tr,
      );
      await AuthSuccessHandler.handleAuthSuccess(result.authData!);
    } else if (result is Failure) {
      log("Google login failed: ${result.errorMessage}");
      // ❌ خطأ من السيرفر
      showCustomGetSnack(isGreen: false, text: result.errorMessage);
    }

    statusrequest = Statusrequest.none;
    update();
  }
}
