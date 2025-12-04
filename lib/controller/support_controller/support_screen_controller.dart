import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/notifcation_service.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/Support/get_chats_data.dart';
import 'package:e_comerece/data/datasource/remote/Support/get_messages_data.dart';
import 'package:e_comerece/data/datasource/remote/Support/send_message_data.dart';
import 'package:e_comerece/data/model/support_model/get_chats_model.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SupportScreenController extends GetxController {
  Future<int> sendMessage({
    required String platform,
    required String referenceid,
    int? chatid,
    String? imagelink,
  });
  Future<void> getMessages({required int chatid});
  Future<void> getChats();
}

class SupportScreenControllerImp extends SupportScreenController {
  SendMessageData sendMessageData = SendMessageData(Get.find());
  GetMessagesData getMessagesData = GetMessagesData(Get.find());
  GetChatsData getChatsData = GetChatsData(Get.find());
  Statusrequest sendMessagestatusrequest = Statusrequest.none;
  Statusrequest getMessagestatusrequest = Statusrequest.none;
  Statusrequest getChatsstatusrequest = Statusrequest.none;

  MyServises myServises = Get.find();
  bool showfildName = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? linkProduct;

  late TextEditingController messsageController;
  TextEditingController nameController = TextEditingController();

  List<Message> messageList = [];
  List<Chat> chatList = [];
  int? chatid;
  String? plateform;
  ScrollController scrollController = ScrollController();
  @override
  void onClose() {
    super.onClose();
    messsageController.dispose();
    nameController.dispose();
    scrollController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    plateform = Get.arguments?['platform'];
    linkProduct = Get.arguments?['link_Product'];
    messsageController = linkProduct == null
        ? TextEditingController()
        : TextEditingController(text: "$linkProduct\n\n\n");
  }

  @override
  sendMessage({
    required String platform,
    required String referenceid,
    int? chatid,
    String? imagelink,
  }) async {
    String userid = myServises.sharedPreferences.getString("user_id")!;
    final String token = await NotifcationService.getFcmToken();

    // if (userid == "0") {
    //   return;
    // }

    sendMessagestatusrequest = Statusrequest.loading;
    update();
    final response = await sendMessageData.sendMessage(
      userid: int.parse(userid),
      message: messsageController.text,
      devicetokens: token,
      platform: platform,
      referenceid: referenceid,
      chatid: chatid,
      imagelink: imagelink,
      sendername: nameController.text,
    );

    sendMessagestatusrequest = handlingData(response);
    if (Statusrequest.success == sendMessagestatusrequest) {
      // showCustomGetSnack(isGreen: true, text: 'تم الارسال بنجاح');
      nameController.clear();
      messsageController.clear();
      return response['chat_id'];
    } else {
      showCustomGetSnack(isGreen: false, text: 'لم يتم الارسال بنجاح');
      return 0;
    }
  }

  @override
  getMessages({required int chatid}) async {
    getMessagestatusrequest = Statusrequest.loading;
    update();
    final response = await getMessagesData.getData(chatid);

    getMessagestatusrequest = handlingData(response);
    if (Statusrequest.success == getMessagestatusrequest) {
      if (response['status'] == 'success' && response['messages'] != null) {
        final modelresponse = GetMessagesModel.fromJson(response);
        messageList.clear();
        messageList.addAll(modelresponse.messages);
        getMessagestatusrequest = Statusrequest.success;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } else {
      getMessagestatusrequest = Statusrequest.failuer;
    }
    update();
  }

  @override
  getChats() async {
    int userid = int.parse(myServises.sharedPreferences.getString("user_id")!);
    getChatsstatusrequest = Statusrequest.loading;
    update();
    final response = await getChatsData.getChats(userid);
    getChatsstatusrequest = handlingData(response);
    if (Statusrequest.success == getChatsstatusrequest) {
      if (response['status'] == 'success' && response['chats'] != null) {
        final modelresponse = GetChatsModel.fromJson(response);
        chatList.clear();
        chatList.assignAll(modelresponse.chats);
        getChatsstatusrequest = Statusrequest.success;
      }
    } else {
      getChatsstatusrequest = Statusrequest.failuer;
    }
    update();
  }

  goToMassagesScreen(int chatid) async {
    showfildName = false;
    this.chatid = chatid;
    Get.toNamed(AppRoutesname.messagesScreen);
    getMessages(chatid: chatid);
  }
}
