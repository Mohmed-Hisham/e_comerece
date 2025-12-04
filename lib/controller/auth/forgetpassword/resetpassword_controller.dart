import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/resetpassword_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ResetcodeController extends GetxController {
  resetPassword();
  goback() => Get.back();
}

class ResetpasswordIemeent extends ResetcodeController {
  ResetpasswordData resetpasswordData = ResetpasswordData(Get.find());
  late TextEditingController passWord;
  late TextEditingController repassWord;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Statusrequest? statusrequest;

  String? email;
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
        return errorDialog(
          StringsKeys.error.tr,
          StringsKeys.passwordNotMatch.tr,
        );
      }
      statusrequest = Statusrequest.loading;

      update();
      if (!Get.isDialogOpen!) {
        loadingDialog();
      }
      var response = await resetpasswordData.postData(
        email: email!,
        password: passWord.text,
      );

      statusrequest = handlingData(response);
      if (Get.isDialogOpen ?? false) Get.back();
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          Get.toNamed(AppRoutesname.resetPassWord, arguments: {"email": email});
        } else {
          errorDialog(StringsKeys.error.tr, StringsKeys.error.tr);
          statusrequest = Statusrequest.failuer;
        }
      }
      update();
      Get.offAllNamed(AppRoutesname.successReset);
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    passWord = TextEditingController();
    repassWord = TextEditingController();
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
