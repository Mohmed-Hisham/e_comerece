import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class VerifycodesignupData {
  Crud crud;

  VerifycodesignupData(this.crud);

  postData({required String email, required String verifycode}) async {
    var respons = await crud.postData(Appapi.verifycode, {
      "email": email,
      "verifycode": verifycode,
    });

    return respons.fold((l) => l, (r) => r);
  }

  resend({required String email}) async {
    var respons = await crud.postData(Appapi.resend, {"user_email": email});

    return respons.fold((l) => l, (r) => r);
  }
}
