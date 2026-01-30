import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  late String code;
  ckeckCode(String verifycodeSignup);
  goback() => Get.back();
}

class VerifycodeControllerImp extends VerifycodeController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  Statusrequest? statusrequest;

  String? identifier;
  String? email;
  String? phone;
  bool isPhone = false;
  String? verificationId;
  FocusNode focus = .new();

  @override
  ckeckCode(String verifycodeSignup) async {
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
        // نجح التحقق - ننتقل لصفحة إعادة تعيين كلمة المرور
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(
          isGreen: true,
          text: StringsKeys.verificationSuccess.tr,
        );
        Get.toNamed(
          AppRoutesname.resetPassWord,
          arguments: {
            "identifier": identifier,
            "phone": phone,
            "isPhone": true,
            "firebaseToken": tokenOrError,
          },
        );
      } else {
        // فشل التحقق من Firebase
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: tokenOrError, close: false);
        statusrequest = Statusrequest.failuer;
      }
    } else {
      // 📧 التحقق عبر الإيميل
      final response = await authRepoImpl.verifyCode(
        AuthData(email: email!, code: verifycodeSignup),
      );

      final r = response.fold((l) => l, (r) => r);

      if (r is AuthModel) {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: true, text: r.message!, close: false);
        Get.toNamed(
          AppRoutesname.resetPassWord,
          arguments: {
            "identifier": identifier,
            "email": email,
            "code": verifycodeSignup,
            "isPhone": false,
          },
        );
      } else if (r is Failure) {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: false, text: r.errorMessage, close: false);
        statusrequest = Statusrequest.failuer;
      }
    }
    focus.unfocus();
    update();
  }

  /// إعادة إرسال الكود
  Future<void> resend() async {
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
      authRepoImpl.forgetPassword(AuthData(identifier: email!));
      showCustomGetSnack(isGreen: true, text: StringsKeys.codeSentToEmail.tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    identifier = Get.arguments['identifier'];
    email = Get.arguments['email'];
    phone = Get.arguments['phone'];
    isPhone = Get.arguments['isPhone'] ?? false;
    verificationId = Get.arguments['verificationId'];

    debugPrint('📧 Email: $email');
    debugPrint('📱 Phone: $phone');
    debugPrint('🔄 isPhone: $isPhone');
  }

  @override
  void dispose() {
    super.dispose();
    focus.dispose();
  }
}
