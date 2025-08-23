import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/auth/verifycodesignup_data.dart';
import 'package:get/get.dart';

abstract class VeirfycodesignupController extends GetxController {
  resend();
  goTosuccesssginup(String verifycodeSignup);
}

class VerifycodesignupControllerImp extends VeirfycodesignupController {
  VerifycodesignupData verifycodesignupData = VerifycodesignupData(Get.find());

  Statusrequest? statusrequest;

  String? email;
  @override
  goTosuccesssginup(String verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await verifycodesignupData.postData(
      email: email!,
      verifycode: verifycodeSignup,
    );

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.offAllNamed(AppRoutesname.successsginup);
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "الكود غير صحيح");
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
}
