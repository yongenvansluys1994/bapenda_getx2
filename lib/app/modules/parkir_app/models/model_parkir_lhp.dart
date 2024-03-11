// To parse this JSON data, do
//
//     final modelParkirLhp = modelParkirLhpFromJson(jsonString);

import 'dart:convert';

ModelParkirLhp modelParkirLhpFromJson(String str) =>
    ModelParkirLhp.fromJson(json.decode(str));

String modelParkirLhpToJson(ModelParkirLhp data) => json.encode(data.toJson());

class ModelParkirLhp {
  String nik;
  String namaUsaha;
  String npwpd;
  String jenis;
  String nominal;
  DateTime date;

  ModelParkirLhp({
    required this.nik,
    required this.namaUsaha,
    required this.npwpd,
    required this.jenis,
    required this.nominal,
    required this.date,
  });

  factory ModelParkirLhp.fromJson(Map<String, dynamic> json) => ModelParkirLhp(
        nik: json["nik"],
        namaUsaha: json["nama_usaha"],
        npwpd: json["npwpd"],
        jenis: json["jenis"],
        nominal: json["nominal"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "nama_usaha": namaUsaha,
        "npwpd": npwpd,
        "jenis": jenis,
        "nominal": nominal,
        "date": date.toIso8601String(),
      };
}
