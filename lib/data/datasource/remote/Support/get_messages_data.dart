import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class GetMessagesData {
  Crud crud;

  GetMessagesData(this.crud);

  getData(int chatId) async {
    var response = await crud.postData(Appapi.getMasseges, {"chat_id": chatId});
    return response.fold((l) => l, (r) => r);
  }
}
