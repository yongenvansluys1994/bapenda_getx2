// To parse this JSON data, do
//
//     final modelCheck = modelCheckFromJson(jsonString);

import 'dart:convert';

ModelCheck modelCheckFromJson(String str) =>
    ModelCheck.fromJson(json.decode(str));

String modelCheckToJson(ModelCheck data) => json.encode(data.toJson());

class ModelCheck {
  ModelCheck({
    required this.idUserwp,
    required this.nama,
    required this.nik,
    required this.noHp,
    required this.password,
    required this.foto,
    required this.lastActive,
  });

  String idUserwp;
  String nama;
  String nik;
  String noHp;
  String password;
  String foto;
  DateTime lastActive;

  factory ModelCheck.fromJson(Map<String, dynamic> json) => ModelCheck(
        idUserwp: json["id_userwp"],
        nama: json["nama"],
        nik: json["nik"],
        noHp: json["no_hp"],
        password: json["password"],
        foto: json["foto"],
        lastActive: DateTime.parse(json["last_active"]),
      );

  Map<String, dynamic> toJson() => {
        "id_userwp": idUserwp,
        "nama": nama,
        "nik": nik,
        "no_hp": noHp,
        "password": password,
        "foto": foto,
        "last_active": lastActive.toIso8601String(),
      };
}
