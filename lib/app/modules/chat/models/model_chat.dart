// To parse this JSON data, do
//
//     final modelChat = modelChatFromJson(jsonString);

import 'dart:convert';

ModelChat modelChatFromJson(String str) => ModelChat.fromJson(json.decode(str));

String modelChatToJson(ModelChat data) => json.encode(data.toJson());

class ModelChat {
  String messageId;
  String roomId;
  String senderId;
  String senderName;
  String foto;
  String messageText;
  DateTime sentAt;

  ModelChat({
    required this.messageId,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.foto,
    required this.messageText,
    required this.sentAt,
  });

  factory ModelChat.fromJson(Map<String, dynamic> json) => ModelChat(
        messageId: json["message_id"],
        roomId: json["room_id"],
        senderId: json["sender_id"],
        senderName: json["sender_name"],
        foto: json["foto"],
        messageText: json["message_text"],
        sentAt: DateTime.parse(json["sent_at"]),
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "room_id": roomId,
        "sender_id": senderId,
        "sender_name": senderName,
        "foto": foto,
        "message_text": messageText,
        "sent_at": sentAt.toIso8601String(),
      };
}