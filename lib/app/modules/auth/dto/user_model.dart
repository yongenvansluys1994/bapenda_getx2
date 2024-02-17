// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String idUserwp;
  String nama;
  String nik;
  String noHp;
  String password;
  String foto;
  String lastActive;

  User({
    required this.idUserwp,
    required this.nama,
    required this.nik,
    required this.noHp,
    required this.password,
    required this.foto,
    required this.lastActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUserwp: json["id_userwp"],
        nama: json["nama"],
        nik: json["nik"],
        noHp: json["no_hp"],
        password: json["password"],
        foto: json["foto"],
        lastActive: json["last_active"],
      );

  Map<String, dynamic> toJson() => {
        "id_userwp": idUserwp,
        "nama": nama,
        "nik": nik,
        "no_hp": noHp,
        "password": password,
        "foto": foto,
        "last_active": lastActive,
      };
}
