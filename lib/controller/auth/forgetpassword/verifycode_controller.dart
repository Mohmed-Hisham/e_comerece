import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/auth/forgetpassword/verifycoderesetpass_data.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  late String code;
  ckeckCode(verifycodeSignup);
  goback() => Get.back();
}

class VerifycodeControllerImp extends VerifycodeController {
  VerifycoderesetpassData verifycodesignupData = VerifycoderesetpassData(
    Get.find(),
  );
  Statusrequest? statusrequest;

  String? email;

  @override
  ckeckCode(verifycodeSignup) async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await verifycodesignupData.postData(
      email: email!,
      verifycode: verifycodeSignup,
    );

    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        Get.toNamed(AppRoutesname.resetPassWord, arguments: {"email": email});
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "الكود غير صحيح");
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }
}
