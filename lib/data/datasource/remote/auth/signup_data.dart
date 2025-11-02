import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  postData({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    var respons = await crud.postData(Appapi.signUp, {
      "user_name": username,
      "user_email": email,
      "user_phone": phone,
      "user_password": password,
    });

    return respons.fold((l) => l, (r) => r);
  }
}
