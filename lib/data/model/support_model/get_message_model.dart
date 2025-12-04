class GetMessagesModel {
  GetMessagesModel({required this.status, required this.messages});

  final String? status;
  final List<Message> messages;

  factory GetMessagesModel.fromJson(Map<String, dynamic> json) {
    return GetMessagesModel(
      status: json["status"],
      messages: json["messages"] == null
          ? []
          : List<Message>.from(
              json["messages"]!.map((x) => Message.fromJson(x)),
            ),
    );
  }
}

class Message {
  Message({
    required this.id,
    required this.chatId,
    required this.senderType,
    required this.senderName,
    required this.message,
    required this.isRead,
    required this.isReplied,
    required this.replyTo,
    required this.createdAt,
    this.imageUrl,
    this.senderId,
  });

  final String? id;
  final String? chatId;
  final String? senderType;
  final String? senderName;
  final String? message;
  final int? isRead;
  final int? isReplied;
  final dynamic replyTo;
  final DateTime? createdAt;
  final String? imageUrl;
  final String? senderId;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: (json["id"] ?? json["message_id"])?.toString(),
      chatId: (json["chat_id"])?.toString(),
      senderType: json["sender_type"],
      senderName: json["sender_name"],
      message: json["message"] ?? json["content"],
      isRead: json["is_read"],
      isReplied: json["is_replied"],
      replyTo: json["reply_to"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      imageUrl: json["image_url"],
      senderId: (json["sender_id"])?.toString(),
    );
  }
}
