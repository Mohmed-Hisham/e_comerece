import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
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
}

class LLoginStepOneControllerimplment extends LoginStepOneController {
  ScrollController scrollController = ScrollController();
  FocusNode emailFocus = .new();

  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  TextEditingController email = .new(); // يقبل إيميل أو رقم هاتف
  MyServises myServises = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // بيانات التحقق عبر SMS
  VerificationData? smsVerificationData;

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  void dispose() {
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

      // أرسل للسيرفر - السيرفر سيفهم تلقائياً إذا كان إيميل أو هاتف
      final response = await authRepoImpl.loginStepOne(
        AuthData(identifier: input),
      );

      final r = response.fold((l) => l, (r) => r);

      if (r is AuthModel && r.success == true) {
        // إذا كان الإدخال رقم هاتف، نحتاج لإرسال OTP عبر Firebase
        if (isPhone) {
          // السيرفر رد بـ "Please verify via SMS" مع رقم الهاتف
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
              text: r.message ?? 'تم إرسال رمز التحقق',
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
            // فشل إرسال SMS - اقترح استخدام الإيميل
            showCustomGetSnack(
              isGreen: false,
              text:
                  '${otpResult.userFriendlyError ?? StringsKeys.smsSendFailed.tr}\n${StringsKeys.tryWithEmail.tr}',
            );
          }
        } else {
          // الإدخال إيميل - السيرفر أرسل الكود للإيميل
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
}
