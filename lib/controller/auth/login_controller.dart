import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/helper/auth_success_handler.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/class/failure.dart';

abstract class LoginController extends GetxController {
  Future<void> login();
  void goToSginup();
  void goToForgetpassword();
}

class LoginControllerimplment extends LoginController {
  ScrollController scrollController = .new();
  FocusNode focus = .new();

  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  late TextEditingController passowrd;
  late TextEditingController code;

  late String name;
  late String identifier; // إيميل أو هاتف
  late bool isPhone;
  String? verificationId; // للتحقق عبر SMS

  MyServises myServises = Get.find();

  Statusrequest statusrequest = Statusrequest.none;
  bool visibility = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  void visibilityFun() {
    visibility = visibility == true ? visibility = false : visibility = true;
    update();
  }

  @override
  goToSginup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }

  @override
  login() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }

      String? firebaseIdToken;

      // إذا كان التحقق عبر SMS، نتحقق من الكود عبر Firebase أولاً
      if (isPhone && verificationId != null) {
        final smsResult = await SendOtpHelper.signInWithSmsCode(
          verificationId: verificationId!,
          smsCode: code.text.trim(),
        );

        final tokenOrError = smsResult.fold((error) {
          if (Get.isDialogOpen ?? false) Get.back();
          showCustomGetSnack(isGreen: false, text: error);
          return null;
        }, (token) => token);

        if (tokenOrError == null) {
          statusrequest = Statusrequest.failuer;
          update();
          return;
        }

        firebaseIdToken = tokenOrError;
        debugPrint(
          '🔑 Got Firebase Token: ${firebaseIdToken.substring(0, 50)}...',
        );
      }

      late final Either<Failure, AuthModel> response;

      if (isPhone && firebaseIdToken != null) {
        response = await authRepoImpl.confirmPhoneVerification(
          AuthData(phone: identifier, firebaseToken: firebaseIdToken),
        );
      } else {
        response = await authRepoImpl.loginStepTwo(
          AuthData(
            identifier: identifier,
            password: passowrd.text,
            code: code.text,
          ),
        );
      }

      final r = response.fold((l) => l, (r) => r);
      if (Get.isDialogOpen ?? false) Get.back();

      if (r is AuthModel) {
        await AuthSuccessHandler.handleAuthSuccess(r.authData!);
      }
      if (r is Failure) {
        showCustomGetSnack(isGreen: false, text: r.errorMessage);
        statusrequest = Statusrequest.failuer;
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    name = Get.arguments['name'] ?? '';
    identifier = Get.arguments['identifier'] ?? Get.arguments['email'] ?? '';
    isPhone = Get.arguments['isPhone'] ?? false;
    verificationId = Get.arguments['verificationId'];

    passowrd = .new();
    code = .new();
  }

  @override
  void dispose() {
    super.dispose();
    passowrd.dispose();
    code.dispose();
    focus.dispose();
    scrollController.dispose();
  }

  @override
  goToForgetpassword() {
    Get.toNamed(
      AppRoutesname.forgetpassword,
      arguments: {"identifier": identifier},
    );
  }
}
