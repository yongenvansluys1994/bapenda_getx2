// To parse this JSON data, do
//
//     final modelListNotifikasi = modelListNotifikasiFromJson(jsonString);

import 'dart:convert';

ModelListNotifikasi modelListNotifikasiFromJson(String str) => ModelListNotifikasi.fromJson(json.decode(str));

String modelListNotifikasiToJson(ModelListNotifikasi data) => json.encode(data.toJson());

class ModelListNotifikasi {
    String id;
    String kategori;
    String keterangan;
    String status;
    DateTime date;

    ModelListNotifikasi({
        required this.id,
        required this.kategori,
        required this.keterangan,
        required this.status,
        required this.date,
    });

    factory ModelListNotifikasi.fromJson(Map<String, dynamic> json) => ModelListNotifikasi(
        id: json["id"],
        kategori: json["kategori"],
        keterangan: json["keterangan"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "keterangan": keterangan,
        "status": status,
        "date": date.toIso8601String(),
    };
}
