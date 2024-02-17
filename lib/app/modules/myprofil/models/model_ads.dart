// To parse this JSON data, do
//
//     final modelAds = modelAdsFromJson(jsonString);

import 'dart:convert';

ModelAds modelAdsFromJson(String str) => ModelAds.fromJson(json.decode(str));

String modelAdsToJson(ModelAds data) => json.encode(data.toJson());

class ModelAds {
  String id;
  String nik;
  String wajibPajak;
  String judul;
  String deskripsi;
  String urlImage;
  DateTime date;
  String status;

  ModelAds({
    required this.id,
    required this.nik,
    required this.wajibPajak,
    required this.judul,
    required this.deskripsi,
    required this.urlImage,
    required this.date,
    required this.status,
  });

  factory ModelAds.fromJson(Map<String, dynamic> json) => ModelAds(
        id: json["id"],
        nik: json["nik"],
        wajibPajak: json["wajib_pajak"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        urlImage: json["url_image"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "wajib_pajak": wajibPajak,
        "judul": judul,
        "deskripsi": deskripsi,
        "url_image": urlImage,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}
