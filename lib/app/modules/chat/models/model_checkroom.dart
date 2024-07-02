// To parse this JSON data, do
//
//     final modelCheckRoom = modelCheckRoomFromJson(jsonString);

import 'dart:convert';

ModelCheckRoom modelCheckRoomFromJson(String str) =>
    ModelCheckRoom.fromJson(json.decode(str));

String modelCheckRoomToJson(ModelCheckRoom data) => json.encode(data.toJson());

class ModelCheckRoom {
  String roomId;
  String nikSender;
  List<String> allToken;

  ModelCheckRoom({
    required this.roomId,
    required this.nikSender,
    required this.allToken,
  });

  factory ModelCheckRoom.fromJson(Map<String, dynamic> json) => ModelCheckRoom(
        roomId: json["room_id"],
        nikSender: json["nik_sender"],
        allToken: List<String>.from(json["all_token"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "nik_sender": nikSender,
        "all_token": List<dynamic>.from(allToken.map((x) => x)),
      };
}
