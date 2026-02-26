import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/input_type_helper.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Forgetpassowrd extends GetxController {
  Future<void> goToveyfiycode();
  void goback();
}

class Forgetpassowrdlment extends Forgetpassowrd {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  TextEditingController email = .new(); // يقبل إيميل أو رقم هاتف
  GlobalKey<FormState> formState = .new();
  Statusrequest? statusrequest;
  ScrollController scrollController = .new();
  FocusNode focus = .new();

  // بيانات التحقق عبر SMS
  VerificationData? smsVerificationData;

  // 🔄 لكشف البلد ديناميكياً
  String? detectedCountry;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController(
      text: Get.arguments?['email'] ?? Get.arguments?['identifier'] ?? '',
    );
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
  goToveyfiycode() async {
    if (formState.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }

      final input = email.text.trim();
      final isPhone = InputTypeHelper.isPhoneNumber(input);

      final response = await authRepoImpl.forgetPassword(
        AuthData(identifier: input),
      );

      final r = response.fold((l) => l, (r) => r);

      if (r is AuthModel && r.success == true) {
        // إذا كان الإدخال رقم هاتف، نحتاج لإرسال OTP عبر Firebase
        if (isPhone) {
          final phoneNumber =
              r.authData?.phone ?? InputTypeHelper.formatPhoneNumber(input);

          // إرسال OTP عبر Firebase
          final otpResult = await SendOtpHelper.verifyPhone(phoneNumber);

          if (Get.isDialogOpen ?? false) Get.back();

          if (otpResult.success && otpResult.verificationData != null) {
            // نجح إرسال SMS
            smsVerificationData = otpResult.verificationData;
            showCustomGetSnack(
              isGreen: true,
              text: r.message ?? StringsKeys.verificationCodeSent.tr,
            );
            Get.toNamed(
              AppRoutesname.verFiyCode,
              arguments: {
                "identifier": input,
                "phone": phoneNumber,
                "isPhone": true,
                "verificationId": smsVerificationData!.verificationId,
              },
            );
          } else {
            // فشل إرسال SMS
            showCustomGetSnack(
              isGreen: false,
              text:
                  '${otpResult.userFriendlyError ?? StringsKeys.smsSendFailed.tr}\n${StringsKeys.tryWithEmail.tr}',
            );
          }
        } else {
          // الإدخال إيميل
          if (Get.isDialogOpen ?? false) Get.back();
          showCustomGetSnack(isGreen: true, text: r.message!);
          Get.toNamed(
            AppRoutesname.verFiyCode,
            arguments: {"identifier": input, "email": input, "isPhone": false},
          );
        }
      } else if (r is Failure) {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
        statusrequest = Statusrequest.failuer;
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
      }

      focus.unfocus();
      update();
    }
  }

  @override
  void dispose() {
    email.removeListener(_onInputChanged);
    super.dispose();
    email.dispose();
    focus.dispose();
    scrollController.dispose();
  }

  @override
  goback() {
    Get.back();
  }
}
