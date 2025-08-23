import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/lin_kapi.dart';

class TestData {
  Crud crud;

  TestData(this.crud);

  getData() async {
    var respons = await crud.postData(Appapi.test, {});

    return respons.fold((l) => l, (r) => r);
  }
}
