class GetChatsModel {
  GetChatsModel({required this.status, required this.chats});

  final String? status;
  final List<Chat> chats;

  factory GetChatsModel.fromJson(Map<String, dynamic> json) {
    return GetChatsModel(
      status: json["success"]?.toString() ?? json["status"]?.toString(),
      chats: json["data"] == null
          ? (json["chats"] == null
                ? []
                : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))))
          : List<Chat>.from(json["data"]!.map((x) => Chat.fromJson(x))),
    );
  }
}

class Chat {
  Chat({
    required this.chatId,
    required this.platform,
    required this.referenceId,
    required this.lastMessage,
    required this.type,
    required this.lastMessageTime,
    required this.lastSender,
    required this.unreadCount,
    required this.status,
  });

  final String? chatId;
  final String? platform;
  final String? referenceId;
  final String? lastMessage;
  final String? type;
  final DateTime? lastMessageTime;
  final String? lastSender;
  final int? unreadCount;
  final String? status;

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: (json["id"] ?? json["chatId"] ?? json["chat_id"])?.toString(),
      platform: json["type"] ?? json["platform"],
      referenceId: (json["referenceId"] ?? json["reference_id"])?.toString(),
      lastMessage: json["lastMessage"] ?? json["last_message"],
      type: json["type"]?.toString(),
      lastMessageTime: DateTime.tryParse(
        json["updatedAt"] ??
            json["updated_at"] ??
            json["lastMessageTime"] ??
            "",
      ),
      lastSender:
          json["lastSenderType"] ?? json["lastSender"] ?? json["last_sender"],
      unreadCount:
          json["unreadUser"] ?? json["unread_user"] ?? json["unreadCount"],
      status: json["status"],
    );
  }
}
