import 'dart:developer';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
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
    String? imagelink,
  });
  Future<void> getMessages({required String chatid});
}

class SupportScreenControllerImp extends SupportScreenController {
  LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
  );
  Statusrequest serviceDetailsStatusRequest = Statusrequest.none;

  Statusrequest sendMessagestatusrequest = Statusrequest.none;
  Statusrequest getMessagestatusrequest = Statusrequest.success;
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = .new();

  MyServises myServises = Get.find();
  bool showfildName = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? linkProduct;
  bool hasShownSupportSnack = false;

  late TextEditingController messsageController;

  List<Message> messageList = [];
  String? chatid;
  String? plateform;
  LocalServiceData? serviceModel;
  details.ServiceRequestDetailData? serviceRequestDetails;
  String? type;
  String? serviceid;
  String? referenceid;

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
    referenceid = Get.arguments?['reference_id'];
    if (type == 'service' && serviceid != null) {
      getServiceData();
    }
    if (type == "service_request") {
      log("referenceid: $referenceid");
      getData(id: referenceid);
    }
    if (chatid != null) {
      getMessages(chatid: chatid!);
    }

    if (Get.arguments?['service_model'] != null) {
      serviceModel = Get.arguments['service_model'];
    }

    if (Get.arguments?['service_request_details'] != null) {
      log("service_request_details: is not null");
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

    if (chatid == null) {
      String chatType = serviceModel == null ? 'support' : 'service';
      if (serviceRequestDetails != null) {
        chatType = 'service_request';
      }
      final chat = await Get.find<SupabaseService>().createChat(
        type: chatType,
        referenceId: referenceid,
        lastMessage: messsageController.text,
        lastSenderType: 'user',
      );
      if (chat != null) {
        chatid = chat['id'];

        // Send user message first (which was used as last_message in createChat)
        await Get.find<SupabaseService>().sendMessage(
          chatId: chatid!,
          content: messsageController.text,
          senderType: 'user',
        );

        // Send Bot Message
        await Get.find<SupabaseService>().sendMessage(
          chatId: chatid!,
          content:
              'مرحباً بك! 👋\nلقد تم استلام رسالتك. يرجى شرح استفسارك بالتفصيل وسيقوم أحد ممثلي خدمة العملاء بالرد عليك في أقرب وقت ممكن.',
          senderType: 'bot',
        );

        messsageController.clear();
        getMessages(chatid: chatid!);
        sendMessagestatusrequest = Statusrequest.success;
        update();
        return chatid;
      }
    }

    await Get.find<SupabaseService>().sendMessage(
      chatId: chatid ?? "",
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
    // update();
  }

  getServiceData() async {
    serviceDetailsStatusRequest = Statusrequest.loading;
    update();
    var response = await localServiceRepoImpl.getLocalServiceById(serviceid!);

    serviceDetailsStatusRequest = response.fold((l) => Statusrequest.failuer, (
      r,
    ) {
      if (r.data.isNotEmpty) {
        serviceModel = r.data[0];
        return Statusrequest.success;
      }
      return Statusrequest.noData;
    });
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

  getData({String? id}) async {
    final response = await localServiceRepoImpl.getServiceRequestDetails(id!);

    response.fold((failure) {}, (model) {
      serviceRequestDetails = model.data;
      update();
    });
  }
}
