class GetChatsModel {
  GetChatsModel({required this.status, required this.chats});

  final String? status;
  final List<Chat> chats;

  factory GetChatsModel.fromJson(Map<String, dynamic> json) {
    return GetChatsModel(
      status: json["status"],
      chats: json["chats"] == null
          ? []
          : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
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
  });

  final String? chatId;
  final String? platform;
  final String? referenceId;
  final String? lastMessage;
  final String? type;
  final DateTime? lastMessageTime;
  final String? lastSender;
  final int? unreadCount;

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: (json["id"] ?? json["chat_id"])?.toString(),
      platform: json["type"] ?? json["platform"],
      referenceId: json["reference_id"] ?? json["reference_id"],
      lastMessage: json["last_message"],
      type: json["type"] ?? json["type"],
      lastMessageTime: DateTime.tryParse(
        json["updated_at"] ?? json["last_message_time"] ?? "",
      ),
      lastSender: json["last_sender_type"] ?? json["last_sender"],
      unreadCount: json["unread_user"] ?? json["unread_count"],
    );
  }
}
