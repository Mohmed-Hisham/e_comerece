import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
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

  // 🔄 لكشف البلد ديناميكياً للهاتف
  String? detectedCountry;

  // 📱 طريقة التحقق: true = هاتف، false = إيميل
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

  /// تبديل طريقة التحقق
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

  /// تنفيذ التسجيل بناءً على اختيار المستخدم
  Future<void> _proceedWithSignup() async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }

    // تحويل رقم الهاتف للصيغة الدولية
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
      // التسجيل نجح، الآن نتعامل حسب اختيار التحقق
      if (verifyViaPhone) {
        // إرسال OTP عبر Firebase SMS
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
          // فشل إرسال SMS، نستخدم الإيميل بدلاً منه
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
        // التحقق عبر الإيميل (السيرفر أرسل الكود تلقائياً)
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
