import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class ViewOrdersData {
  Crud crud;

  ViewOrdersData(this.crud);

  Future<dynamic> viewOrders({required String userid}) async {
    var response = await crud.postData(Appapi.viewlocalServiceUser, {
      "userid": userid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
