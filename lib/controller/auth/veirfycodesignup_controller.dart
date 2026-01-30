import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/helper/auth_success_handler.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VeirfycodesignupController extends GetxController {
  resend();
  goTosuccesssginup(String verifycodeSignup);
  goTOSignup();
}

class VerifycodesignupControllerImp extends VeirfycodesignupController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;

  String? email;
  String? phone;
  bool isPhone = false;
  String? verificationId;

  @override
  goTosuccesssginup(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }

    if (isPhone && verificationId != null) {
      // 📱 التحقق عبر Firebase SMS
      final firebaseResult = await SendOtpHelper.signInWithSmsCode(
        verificationId: verificationId!,
        smsCode: verifycodeSignup,
      );

      final tokenOrError = firebaseResult.fold((e) => e, (t) => t);

      if (firebaseResult.isRight()) {
        // نجح التحقق من Firebase، الآن نؤكد للـ Backend
        final response = await authRepoImpl.confirmPhoneVerification(
          AuthData(email: email, phone: phone, firebaseToken: tokenOrError),
        );

        if (Get.isDialogOpen ?? false) Get.back();

        final r = response.fold((l) => l, (r) => r);
        if (r is AuthModel && r.success == true && r.authData != null) {
          await AuthSuccessHandler.handleAuthSuccess(r.authData!);
        } else if (r is Failure) {
          showCustomGetSnack(isGreen: false, text: r.errorMessage);
          statusrequest = Statusrequest.failuer;
        }
      } else {
        // فشل التحقق من Firebase
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: tokenOrError);
        statusrequest = Statusrequest.failuer;
      }
    } else {
      // 📧 التحقق عبر الإيميل
      final response = await authRepoImpl.verifyCode(
        AuthData(email: email!, code: verifycodeSignup),
      );

      if (Get.isDialogOpen ?? false) Get.back();

      final r = response.fold((l) => l, (r) => r);
      if (r is AuthModel && r.authData != null) {
        await AuthSuccessHandler.handleAuthSuccess(r.authData!);
      } else if (r is Failure) {
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  resend() async {
    if (isPhone && phone != null) {
      // 📱 إعادة إرسال OTP عبر Firebase
      loadingDialog();
      final otpResult = await SendOtpHelper.verifyPhone(phone!);
      if (Get.isDialogOpen ?? false) Get.back();

      if (otpResult.success && otpResult.verificationData != null) {
        verificationId = otpResult.verificationData!.verificationId;
        showCustomGetSnack(isGreen: true, text: StringsKeys.codeSentToPhone.tr);
      } else {
        showCustomGetSnack(
          isGreen: false,
          text: otpResult.userFriendlyError ?? StringsKeys.smsSendFailed.tr,
        );
      }
    } else {
      // 📧 إعادة إرسال الكود عبر الإيميل
      authRepoImpl.loginStepOne(AuthData(identifier: email!));
      showCustomGetSnack(isGreen: true, text: StringsKeys.codeSentToEmail.tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    phone = Get.arguments['phone'];
    isPhone = Get.arguments['isPhone'] ?? false;
    verificationId = Get.arguments['verificationId'];

    debugPrint('📧 Email: $email');
    debugPrint('📱 Phone: $phone');
    debugPrint('🔄 isPhone: $isPhone');
  }

  @override
  goTOSignup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }
}
