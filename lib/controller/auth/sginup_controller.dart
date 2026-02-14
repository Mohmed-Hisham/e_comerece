import 'dart:developer';

import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/auth_success_handler.dart';
import 'package:e_comerece/core/helper/google_sign_in_helper.dart';
import 'package:e_comerece/core/helper/input_type_helper.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_comerece/core/constant/routesname.dart';

abstract class SginupController extends GetxController {
  Future<void> sginup();
  void goToSginin();
  void toggleVerificationMethod();
}

class SginupControllerimplemnt extends SginupController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  ScrollController scrollController = .new();
  FocusNode emailFocus = .new();
  FocusNode phoneFocus = .new();
  FocusNode passwordFocus = .new();
  FocusNode usernameFocus = .new();

  TextEditingController username = .new();
  TextEditingController email = .new();
  TextEditingController passowrd = .new();
  TextEditingController phone = .new();

  Statusrequest? statusrequest;

  bool visibility = true;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  String? detectedCountry;

  bool verifyViaPhone = false;

  @override
  void onInit() {
    super.onInit();
    phone.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final input = phone.text.trim();
    final newCountry = InputTypeHelper.detectCountry(input);
    if (newCountry != detectedCountry) {
      detectedCountry = newCountry;
      update(['phone_prefix']);
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

  visibilityFun() {
    visibility = visibility == true ? visibility = false : visibility = true;
    update();
  }

  @override
  void toggleVerificationMethod() {
    verifyViaPhone = !verifyViaPhone;
    update(['verification_switch']);
  }

  @override
  sginup() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      _proceedWithSignup();
    }
  }

  Future<void> _proceedWithSignup() async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }

    final formattedPhone = InputTypeHelper.formatPhoneNumber(phone.text);

    final response = await authRepoImpl.sginup(
      AuthData(
        name: username.text,
        email: email.text,
        phone: formattedPhone,
        password: passowrd.text,
      ),
    );

    final r = response.fold((l) => l, (r) => r);

    if (r is AuthModel && r.success == true) {
      if (verifyViaPhone) {
        final otpResult = await SendOtpHelper.verifyPhone(formattedPhone);

        if (Get.isDialogOpen ?? false) Get.back();

        if (otpResult.success && otpResult.verificationData != null) {
          showCustomGetSnack(
            isGreen: true,
            text: r.message ?? StringsKeys.codeSentToPhone.tr,
          );
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {
              "email": email.text,
              "phone": formattedPhone,
              "isPhone": true,
              "verificationId": otpResult.verificationData!.verificationId,
            },
          );
        } else {
          showCustomGetSnack(
            isGreen: false,
            text:
                '${otpResult.userFriendlyError}\n${StringsKeys.codeSentToEmail.tr}',
          );
          Get.offNamed(
            AppRoutesname.verFiyCodeSignUp,
            arguments: {"email": email.text, "isPhone": false},
          );
        }
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
        showCustomGetSnack(isGreen: true, text: r.message!);
        Get.offNamed(
          AppRoutesname.verFiyCodeSignUp,
          arguments: {"email": email.text, "isPhone": false},
        );
      }
    } else if (r is Failure) {
      if (Get.isDialogOpen ?? false) Get.back();
      showCustomGetSnack(isGreen: false, text: r.errorMessage);
    }

    _unfocusAll();
    statusrequest = Statusrequest.success;
    update();
  }

  void _unfocusAll() {
    emailFocus.unfocus();
    phoneFocus.unfocus();
    passwordFocus.unfocus();
    usernameFocus.unfocus();
  }

  @override
  goToSginin() {
    Get.offNamed(AppRoutesname.loginStepOne);
  }

  Future<void> signInWithGoogle() async {
    statusrequest = Statusrequest.loading;
    update();
    loadingDialog();

    final googleToken = await GoogleSignInHelper.signIn();

    if (googleToken == null) {
      if (Get.isDialogOpen ?? false) Get.back();
      statusrequest = Statusrequest.none;
      update();
      return;
    }

    final response = await authRepoImpl.googleLogin(googleToken);

    if (Get.isDialogOpen ?? false) Get.back();

    final result = response.fold((l) => l, (r) => r);

    if (result is AuthModel &&
        result.success == true &&
        result.authData != null) {
      showCustomGetSnack(
        isGreen: true,
        text: result.message ?? 'تم تسجيل الدخول بنجاح',
      );
      await AuthSuccessHandler.handleAuthSuccess(result.authData!);
    } else if (result is Failure) {
      log("Google login failed: ${result.errorMessage}");
      showCustomGetSnack(isGreen: false, text: result.errorMessage);
    }

    statusrequest = Statusrequest.none;
    update();
  }

  @override
  void dispose() {
    phone.removeListener(_onPhoneChanged);
    super.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    usernameFocus.dispose();
    email.dispose();
    phone.dispose();
    passowrd.dispose();
    username.dispose();
    scrollController.dispose();
  }
}
