// To parse this JSON data, do
//
//     final modelConfigParkir = modelConfigParkirFromJson(jsonString);

import 'dart:convert';

ModelConfigParkir modelConfigParkirFromJson(String str) =>
    ModelConfigParkir.fromJson(json.decode(str));

String modelConfigParkirToJson(ModelConfigParkir data) =>
    json.encode(data.toJson());

class ModelConfigParkir {
  String namaUsaha;
  String alamatUsaha;
  String hargaRoda2;
  String hargaRoda4;

  ModelConfigParkir({
    required this.namaUsaha,
    required this.alamatUsaha,
    required this.hargaRoda2,
    required this.hargaRoda4,
  });

  factory ModelConfigParkir.fromJson(Map<String, dynamic> json) =>
      ModelConfigParkir(
        namaUsaha: json["nama_usaha"],
        alamatUsaha: json["alamat_usaha"],
        hargaRoda2: json["harga_roda2"],
        hargaRoda4: json["harga_roda4"],
      );

  Map<String, dynamic> toJson() => {
        "nama_usaha": namaUsaha,
        "alamat_usaha": alamatUsaha,
        "harga_roda2": hargaRoda2,
        "harga_roda4": hargaRoda4,
      };
}
