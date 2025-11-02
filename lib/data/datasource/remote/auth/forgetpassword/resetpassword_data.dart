import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class ResetpasswordData {
  Crud crud;

  ResetpasswordData(this.crud);

  postData({required String email, required String password}) async {
    var respons = await crud.postData(Appapi.resetPassword, {
      "user_email": email,
      "user_password": password,
    });

    return respons.fold((l) => l, (r) => r);
  }
}
