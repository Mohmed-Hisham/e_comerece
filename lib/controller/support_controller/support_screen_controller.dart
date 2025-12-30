import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/Support/get_chats_data.dart';
import 'package:e_comerece/data/datasource/remote/local_service/get_details_local_service_data.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/support_model/get_chats_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart'
    as details;
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_comerece/core/servises/supabase_service.dart';

abstract class SupportScreenController extends GetxController {
  Future<String?> sendMessage({
    required String platform,
    required String referenceid,
    // String? chatid,
    String? imagelink,
  });
  Future<void> getMessages({required String chatid});
  Future<void> getChats();
}

class SupportScreenControllerImp extends SupportScreenController {
  GetDetailsLocalService getDetailsLocalService = GetDetailsLocalService(
    Get.find(),
  );
  Statusrequest serviceDetailsStatusRequest = Statusrequest.none;

  GetChatsData getChatsData = GetChatsData(Get.find());
  Statusrequest sendMessagestatusrequest = Statusrequest.none;
  Statusrequest getMessagestatusrequest = Statusrequest.success;
  Statusrequest getChatsstatusrequest = Statusrequest.none;
  ScrollController scrollController = .new();

  MyServises myServises = Get.find();
  bool showfildName = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? linkProduct;
  bool hasShownSupportSnack = false;

  late TextEditingController messsageController;

  List<Message> messageList = [];
  List<Chat> chatList = [];
  String? chatid;
  String? plateform;
  Service? serviceModel;
  details.ServiceRequestDetailData? serviceRequestDetails;
  String? type;
  String? serviceid;
  @override
  void onClose() {
    super.onClose();
    messsageController.dispose();
    scrollController.dispose();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  //  scroll to bottom
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    chatid = Get.arguments?['chat_id'];
    plateform = Get.arguments?['platform'];
    linkProduct = Get.arguments?['link_Product'];
    type = Get.arguments?['type'];
    serviceid = Get.arguments?['service_id'];
    if (type == 'service' && serviceid != null) {
      getServiceData();
    }
    log("type: $type");
    log("serviceid: $serviceid");
    log("chatid: $chatid");

    if (Get.arguments?['service_model'] != null) {
      serviceModel = Get.arguments['service_model'];
    }

    if (Get.arguments?['service_request_details'] != null) {
      serviceRequestDetails = Get.arguments['service_request_details'];
    }

    String? autoMessage = Get.arguments?['auto_message'];
    // String? referenceId = Get.arguments?['reference_id'];

    if (autoMessage != null) {
      messsageController = TextEditingController(text: autoMessage);
    } else {
      messsageController = linkProduct == null
          ? TextEditingController()
          : TextEditingController(text: "$linkProduct\n\n\n");
    }
    checkChatStatus();
  }

  Stream<List<Message>>? messagesStream;

  @override
  Future<String?> sendMessage({
    required String platform,
    required String referenceid,
    String? imagelink,
  }) async {
    sendMessagestatusrequest = Statusrequest.loading;
    update();
    String userid = myServises.sharedPreferences.getString("user_id")!;

    if (chatid == null) {
      final chatType = serviceModel == null ? 'support' : 'service';
      final chat = await Get.find<SupabaseService>().createChat(
        userId: userid,
        type: chatType,
        referenceId: referenceid,
        lastMessage: messsageController.text,
        lastSenderType: 'user',
      );
      if (chat != null) {
        chatid = chat['id'];
        getMessages(chatid: chatid!);
      } else {
        return null;
      }
    }

    await Get.find<SupabaseService>().sendMessage(
      chatId: chatid!,
      senderId: userid,
      content: messsageController.text,
      senderType: 'user',
    );
    sendMessagestatusrequest = Statusrequest.success;
    update();
    messsageController.clear();
    return chatid;
  }

  @override
  getMessages({required String chatid}) async {
    messagesStream = Get.find<SupabaseService>()
        .getMessagesStream(chatid)
        .map((data) => data.map((e) => Message.fromJson(e)).toList());
    update();
  }

  @override
  getChats() async {
    String userid = myServises.sharedPreferences.getString("user_id")!;
    getChatsstatusrequest = Statusrequest.loading;
    update();
    try {
      final response = await Get.find<SupabaseService>().getUserChats(userid);
      final Map<String, dynamic> wrappedResponse = {
        "status": "success",
        "chats": response,
      };

      final modelresponse = GetChatsModel.fromJson(wrappedResponse);
      chatList.clear();
      chatList.assignAll(modelresponse.chats);
      getChatsstatusrequest = Statusrequest.success;
    } catch (e) {
      getChatsstatusrequest = Statusrequest.failuer;
      log("Error fetching chats: $e");
    }
    update();
  }

  goToMassagesScreen(String chatid, String type, String serviceid) async {
    showfildName = false;
    this.chatid = chatid;
    this.type = type;
    this.serviceid = serviceid;
    Get.toNamed(AppRoutesname.messagesScreen);

    getMessages(chatid: chatid);
    if (type == 'service') {
      getServiceData();
    }
  }

  getServiceData() async {
    try {
      var response = await getDetailsLocalService.getOrders(
        serviceid: int.parse(serviceid!),
      );
      serviceDetailsStatusRequest = handlingData(response);
      if (Statusrequest.success == serviceDetailsStatusRequest) {
        if (response['status'] == 'success') {
          List data = response['data'];
          if (data.isNotEmpty) {
            serviceModel = Service.fromJson(data[0]);
          }
        }
      }
    } catch (e) {
      log("Error fetching service: $e");
    }
    update();
  }

  bool isChatClosed = false;

  void checkChatStatus() async {
    if (chatid == null) return;
    try {
      final chatData = await Get.find<SupabaseService>().getChatById(chatid!);
      if (chatData != null && chatData['status'] == 'closed') {
        isChatClosed = true;
        update();
      }
    } catch (e) {
      log("Error checking chat status: $e");
    }
  }

  // Future<void> endChatAndConfirm(String price) async {
  //   if (chatid != null) {
  //     // 1. Update status to closed
  //     await Get.find<SupabaseService>().updateChatStatus(
  //       chatId: chatid!,
  //       status: 'closed',
  //     );

  //     // 2. Send "Chat Ended" message
  //     String userid = myServises.sharedPreferences.getString("user_id")!;
  //     await Get.find<SupabaseService>().sendMessage(
  //       chatId: chatid!,
  //       senderId: userid,
  //       content: "تم إنهاء المحادثة",
  //       senderType:
  //           'user', // Can be system if we implement system type handling
  //     );

  //     isChatClosed = true;
  //     update();
  //   }

  //   // 3. Navigate to Order Screen
  //   Get.to(
  //     () => const ServiceOrderScreen(),
  //     arguments: {
  //       'service_model': serviceModel,
  //       'quoted_price': double.parse(price),
  //     },
  //   );
  // }
}
