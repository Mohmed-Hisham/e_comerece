import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/error_dialog.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/funcations/loading_dialog.dart';
import 'package:e_comerece/data/datasource/remote/auth/verifycodesignup_data.dart';
import 'package:get/get.dart';

abstract class VeirfycodesignupController extends GetxController {
  resend();
  goTosuccesssginup(String verifycodeSignup);
  goTOSignup();
}

class VerifycodesignupControllerImp extends VeirfycodesignupController {
  VerifycodesignupData verifycodesignupData = VerifycodesignupData(Get.find());

  Statusrequest statusrequest = Statusrequest.none;

  String? email;
  @override
  goTosuccesssginup(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    if (!Get.isDialogOpen!) {
      loadingDialog();
    }
    var response = await verifycodesignupData.postData(
      email: email!,
      verifycode: verifycodeSignup,
    );

    statusrequest = handlingData(response);
    if (Get.isDialogOpen ?? false) Get.back();
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.offAllNamed(AppRoutesname.successsginup);
      } else {
        errorDialog(StringsKeys.error.tr, StringsKeys.incorrectCode.tr);
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  resend() {
    verifycodesignupData.resend(email: email!);
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
