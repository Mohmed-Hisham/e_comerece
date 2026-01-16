import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ResetcodeController extends GetxController {
  resetPassword();
  goback() => Get.back();
}

class ResetpasswordIemeent extends ResetcodeController {
  AuthRepoImpl authRepoImpl = AuthRepoImpl(apiService: Get.find());
  late TextEditingController passWord;
  late TextEditingController repassWord;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Statusrequest? statusrequest;

  String? email;
  String? code;
  FocusNode passFocus = FocusNode();
  FocusNode repassFocus = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  resetPassword() async {
    var formdate = formState.currentState!;
    if (formdate.validate()) {
      passFocus.unfocus();
      repassFocus.unfocus();
      if (passWord.text != repassWord.text) {
        return showCustomGetSnack(
          isGreen: false,
          text: StringsKeys.passwordNotMatch.tr,
        );
      }
      statusrequest = Statusrequest.loading;

      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }
      var response = await authRepoImpl.resetPassword(
        AuthData(email: email!, code: code!, newPassword: passWord.text),
      );

      final r = response.fold((l) => l, (r) => r);
      if (Get.isDialogOpen ?? false) Get.back();

      if (r is AuthModel) {
        showCustomGetSnack(isGreen: true, text: r.message!);
        Get.offAllNamed(AppRoutesname.successReset);
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
    email = Get.arguments['email'];
    code = Get.arguments['code'];
    passWord = .new();
    repassWord = .new();
  }

  @override
  void dispose() {
    super.dispose();
    passWord.dispose();
    repassWord.dispose();
    passFocus.dispose();
    repassFocus.dispose();
    scrollController.dispose();
  }
}
