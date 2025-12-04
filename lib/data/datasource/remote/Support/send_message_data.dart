import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class SendMessageData {
  Crud crud;
  SendMessageData(this.crud);

  sendMessage({
    int? chatid,
    required int userid,
    String? sendername,
    String? imagelink,
    required String message,
    required String devicetokens,
    required String platform,
    required String referenceid,
  }) async {
    var respons = await crud.postData(Appapi.sendMessage, {
      "sender_type": "user",
      "chat_id": chatid,
      "user_id": userid,
      "sender_name": sendername,
      "message": message,
      "device_tokens": devicetokens,
      "platform": platform,
      "reference_id": referenceid,
      "image_link": imagelink,
    }, sendJson: true);

    return respons.fold((l) => l, (r) => r);
  }
}
