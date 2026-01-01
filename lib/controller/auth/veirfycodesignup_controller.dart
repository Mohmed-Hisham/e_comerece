import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/class/services_helper.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/string_const.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/Auth_Repo/auth_repo_impl.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
      ServicesHelper.saveLocal(token, r.authData!.token!);
      ServicesHelper.saveLocal(userName, r.authData!.name!);
      ServicesHelper.saveLocal(userEmail, r.authData!.email!);
      ServicesHelper.saveLocal(userPhone, r.authData!.phone!);

      FirebaseMessaging.instance.subscribeToTopic(users);
      FirebaseMessaging.instance.subscribeToTopic(r.authData!.token!);

      if (myServises.sharedPreferences.getString("step") == "1") {
        Get.offNamed(AppRoutesname.homepage);
      } else {
        Get.offNamed(AppRoutesname.onBoarding);
      }
      myServises.sharedPreferences.setString("step", "2");
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
