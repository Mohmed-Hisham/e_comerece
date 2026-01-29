import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/helper/auth_success_handler.dart';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
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
  @override
  goTosuccesssginup(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    final response = await authRepoImpl.verifyCode(
      AuthData(email: email!, code: verifycodeSignup),
    );

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

  @override
  resend() {
    authRepoImpl.loginStepOne(AuthData(email: email!));
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  @override
  goTOSignup() {
    Get.offAllNamed(AppRoutesname.sginin);
  }
}
