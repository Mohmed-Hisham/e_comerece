import 'dart:developer';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/support_model/get_chats_model.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  Statusrequest getChatsstatusrequest = Statusrequest.none;
  List<Chat> chatList = [];

  @override
  void onInit() {
    getChats();
    super.onInit();
  }

  getChats() async {
    getChatsstatusrequest = Statusrequest.loading;
    update();
    try {
      final response = await Get.find<ApiService>().get(
        endpoint: ApisUrl.myChats,
      );

      if (response.statusCode == 200) {
        final modelresponse = GetChatsModel.fromJson(response.data);
        chatList.clear();
        chatList.assignAll(modelresponse.chats);
        getChatsstatusrequest = Statusrequest.success;
      } else {
        getChatsstatusrequest = Statusrequest.failuer;
      }
    } catch (e) {
      getChatsstatusrequest = Statusrequest.failuer;
      log("Error fetching chats: $e");
    }
    update();
  }

  Future<dynamic> goToMassagesScreen(
    String chatid,
    String type,
    String serviceid,
    String referenceid,
  ) async {
    final result = await Get.toNamed(
      AppRoutesname.messagesScreen,
      arguments: {
        'chat_id': chatid,
        'type': type,
        'service_id': serviceid,
        'reference_id': referenceid,
        'platform': type == 'service' ? 'localService' : 'support',
      },
    );
    return result;
  }
}
