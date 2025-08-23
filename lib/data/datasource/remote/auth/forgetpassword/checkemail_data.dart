import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/lin_kapi.dart';

class CheckemailData {
  Crud crud;

  CheckemailData(this.crud);

  postData({required String email}) async {
    var respons = await crud.postData(Appapi.checkEmail, {"user_email": email});

    return respons.fold((l) => l, (r) => r);
  }
}
