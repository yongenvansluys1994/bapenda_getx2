// To parse this JSON data, do
//
//     final modelParkirTrans = modelParkirTransFromJson(jsonString);

import 'dart:convert';

ModelParkirTrans modelParkirTransFromJson(String str) =>
    ModelParkirTrans.fromJson(json.decode(str));

String modelParkirTransToJson(ModelParkirTrans data) =>
    json.encode(data.toJson());

class ModelParkirTrans {
  String nik;
  String npwpd;
  String jenis;
  String nominal;
  DateTime date;

  ModelParkirTrans({
    required this.nik,
    required this.npwpd,
    required this.jenis,
    required this.nominal,
    required this.date,
  });

  factory ModelParkirTrans.fromJson(Map<String, dynamic> json) =>
      ModelParkirTrans(
        nik: json["nik"],
        npwpd: json["npwpd"],
        jenis: json["jenis"],
        nominal: json["nominal"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "npwpd": npwpd,
        "jenis": jenis,
        "nominal": nominal,
        "date": date.toIso8601String(),
      };
}
