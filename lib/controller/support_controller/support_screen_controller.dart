import 'dart:developer';
import 'dart:io';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/core/servises/firebase_storage_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart'
    as details;
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:e_comerece/core/servises/signalr_service.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'dart:async';

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
  ScrollController scrollController = .new();
  FocusNode focusNode = .new();

  // Image picker
  File? selectedImage;
  bool isUploadingImage = false;
  final ImagePicker _imagePicker = ImagePicker();

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

  // Typing indicator
  bool isOtherUserTyping = false;
  String? typingUserType;
  Timer? _typingTimer;
  bool _isTyping = false;
  StreamSubscription? _typingSubscription;

  @override
  void onClose() {
    super.onClose();
    messsageController.dispose();
    scrollController.dispose();
    _typingTimer?.cancel();
    _typingSubscription?.cancel();
    // Leave chat and stop typing when closing
    if (chatid != null && Get.isRegistered<SignalRService>()) {
      Get.find<SignalRService>().sendStopTyping(chatid!, 'user');
      Get.find<SignalRService>().leaveChat(chatid!);
    }
  }

  /// Pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (image != null) {
        selectedImage = File(image.path);
        update();
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
      );
      if (image != null) {
        selectedImage = File(image.path);
        update();
      }
    } catch (e) {
      log('Error picking image from camera: $e');
    }
  }

  /// Remove selected image
  void removeSelectedImage() {
    selectedImage = null;
    update();
  }

  /// Upload image and send message
  Future<String?> uploadAndSendImage({
    required String platform,
    required String referenceid,
  }) async {
    if (selectedImage == null) return null;

    isUploadingImage = true;
    sendMessagestatusrequest = Statusrequest.loading;
    update();

    try {
      log('Starting image upload...');

      // Upload image to Firebase Storage with timeout
      final imageUrl =
          await FirebaseStorageHelper.uploadImage(
            imageFile: selectedImage!,
            folder: 'chat_images',
          ).timeout(
            const Duration(minutes: 2),
            onTimeout: () {
              log('Image upload timeout');
              return null;
            },
          );

      if (imageUrl == null) {
        log('Error: Image upload failed');
        isUploadingImage = false;
        sendMessagestatusrequest = Statusrequest.failuer;
        selectedImage = null;
        update();
        showCustomGetSnack(
          isGreen: false,
          text: StringsKeys.imageUploadFailed.tr,
        );
        return null;
      }

      log('Image uploaded successfully: $imageUrl');

      // Clear selected image after upload
      selectedImage = null;
      isUploadingImage = false;
      update();

      // Send message with image URL
      return await sendMessage(
        platform: platform,
        referenceid: referenceid,
        imagelink: imageUrl,
      );
    } catch (e) {
      log('Error uploading image: $e');
      isUploadingImage = false;
      sendMessagestatusrequest = Statusrequest.failuer;
      selectedImage = null;
      update();
      showCustomGetSnack(
        isGreen: false,
        text: StringsKeys.errorUploadingImage.tr,
      );
      return null;
    }
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
    setupSignalR();
    checkChatStatus();
  }

  late StreamSubscription signalRSubscription;

  void setupSignalR() async {
    // Create SignalRService if not exists, then start connection
    if (!Get.isRegistered<SignalRService>()) {
      Get.put(SignalRService());
    }
    final signalR = Get.find<SignalRService>();
    await signalR.startHubConnection(); // Start connection when chat is opened

    if (chatid != null) {
      await signalR.joinChat(chatid!);
    }

    signalRSubscription = signalR.messages.listen((event) {
      if (event['type'] == 'ReceiveMessage') {
        Message newMessage = Message.fromJson(event['data']);
        // Check if message already exists to avoid duplicates
        // تحقق من الـ id أو من المحتوى + المرسل + الوقت القريب
        final isDuplicate = messageList.any((m) {
          if (m.id == newMessage.id) return true;
          // تحقق من الرسائل المحلية التي أضفناها (لها id مؤقت)
          if (m.message == newMessage.message &&
              m.senderType == newMessage.senderType &&
              m.senderId == newMessage.senderId) {
            return true;
          }
          return false;
        });

        if (!isDuplicate) {
          messageList.insert(0, newMessage);
          update();
          scrollToBottom();
        }
      }
    });

    // Setup typing indicator listener
    _setupTypingListener(signalR);
  }

  void _setupTypingListener(SignalRService signalR) {
    _typingSubscription = signalR.typingStream.listen((event) {
      final eventType = event['type'];
      final senderType = event['senderType'];

      // Only show typing indicator if the other party is typing (admin/bot)
      if (senderType != 'user') {
        if (eventType == 'UserTyping') {
          isOtherUserTyping = true;
          typingUserType = senderType;
          update();
        } else if (eventType == 'UserStoppedTyping') {
          isOtherUserTyping = false;
          typingUserType = null;
          update();
        }
      }
    });
  }

  /// Called when user starts typing
  void onUserTyping() {
    if (chatid == null || _isTyping) return;

    _isTyping = true;
    Get.find<SignalRService>().sendTyping(chatid!, 'user');

    // Reset timer
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 3), () {
      _stopTyping();
    });
  }

  /// Called when user stops typing
  void _stopTyping() {
    if (chatid == null || !_isTyping) return;

    _isTyping = false;
    Get.find<SignalRService>().sendStopTyping(chatid!, 'user');
  }

  /// Called when text changes
  void onTextChanged(String text) {
    if (text.isNotEmpty) {
      onUserTyping();
    } else {
      _stopTyping();
    }
  }

  Stream<List<Message>>? messagesStream;

  @override
  Future<String?> sendMessage({
    required String platform,
    required String referenceid,
    String? imagelink,
  }) async {
    // السماح بإرسال صورة بدون نص، لكن منع إرسال رسالة فارغة بدون صورة
    final hasImage = imagelink != null && imagelink.isNotEmpty;
    final hasText = messsageController.text.trim().isNotEmpty;

    if (!hasImage && !hasText) return null;

    sendMessagestatusrequest = Statusrequest.loading;
    update();

    final messageDto = {
      "chatId": chatid,
      "content": messsageController.text,
      "senderId": myServises.sharedPreferences.getString("id"),
      "senderType": "user",
      "messageType": hasImage ? "image" : "text",
      "imageUrl": imagelink,
    };

    if (chatid == null) {
      try {
        String chatType = serviceModel == null ? 'support' : 'service';
        if (serviceRequestDetails != null) {
          chatType = 'service_request';
        }

        final response = await Get.find<ApiService>().post(
          endPoints: ApisUrl.createChat,
          data: {"adminId": null, "type": chatType, "referenceId": referenceid},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          log("Chat created response: ${response.data}");
          // The id is inside the 'data' field because of ServiceResponse format
          chatid = response.data['data']['id']?.toString();
          log("Extracted new chatid: $chatid");
          if (chatid != null) {
            messageDto["chatId"] = chatid;
            setupSignalR(); // Join the new room
          }
        }
      } catch (e) {
        log("Error creating chat: $e");
        sendMessagestatusrequest = Statusrequest.failuer;
        update();
        return null;
      }
    }

    // حفظ محتوى الرسالة قبل مسحها
    final messageContent = messsageController.text;

    await Get.find<SignalRService>().sendChatMessage(messageDto);

    // إضافة الرسالة محلياً فوراً لتظهر في الشاشة
    final localMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatid,
      senderType: "user",
      senderName: myServises.sharedPreferences.getString("username") ?? "User",
      message: messageContent,
      isRead: 0,
      isReplied: 0,
      replyTo: null,
      createdAt: DateTime.now(),
      imageUrl: imagelink,
      senderId: myServises.sharedPreferences.getString("id"),
      messageType: (imagelink != null && imagelink.isNotEmpty)
          ? "image"
          : "text",
    );
    messageList.insert(0, localMessage);

    messsageController.clear();
    sendMessagestatusrequest = Statusrequest.success;
    update();
    scrollToBottom();

    return chatid;
  }

  @override
  Future<void> getMessages({required String chatid}) async {
    getMessagestatusrequest = Statusrequest.loading;
    update();

    try {
      final response = await Get.find<ApiService>().get(
        endpoint: ApisUrl.getChatMessages(chatid),
      );

      if (response.statusCode == 200) {
        final messagesModel = GetMessagesModel.fromJson(response.data);
        // عكس ترتيب الرسائل لتكون الأحدث في البداية (index 0)
        // لأن الـ ListView يستخدم reverse: true
        messageList = messagesModel.messages.reversed.toList();
        getMessagestatusrequest = Statusrequest.success;
      } else {
        getMessagestatusrequest = Statusrequest.failuer;
      }
    } catch (e) {
      log("Error fetching messages: $e");
      getMessagestatusrequest = Statusrequest.failuer;
    }
    update();
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
    // For now, we assume active or handle via the API if needed.
    // The previous implementation used Supabase directly.
  }

  getData({String? id}) async {
    final response = await localServiceRepoImpl.getServiceRequestDetails(id!);

    response.fold((failure) {}, (model) {
      serviceRequestDetails = model.data;
      update();
    });
  }
}
