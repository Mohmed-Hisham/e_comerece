import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postData({required String email, required String password}) async {
    var respons = await crud.postData(Appapi.login, {
      "user_email": email,
      "user_password": password,
    });

    return respons.fold((l) => l, (r) => r);
  }

  loginStepOne({required String email}) async {
    var respons = await crud.postData(Appapi.loginStepOne, {
      "user_email": email,
    });

    return respons.fold((l) => l, (r) => r);
  }
}
