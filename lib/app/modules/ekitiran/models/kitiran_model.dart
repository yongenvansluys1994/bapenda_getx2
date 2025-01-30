// To parse this JSON data, do
//
//     final modelKitiran = modelKitiranFromJson(jsonString);

import 'dart:convert';

ModelKitiran modelKitiranFromJson(String str) =>
    ModelKitiran.fromJson(json.decode(str));

String modelKitiranToJson(ModelKitiran data) => json.encode(data.toJson());

class ModelKitiran {
  String? kelurahan;
  String? rt;
  String nop;
  String nama;
  String alamat;
  String kecamatanOp;
  String kelurahanOp;
  String alamatOp;
  String tahun;
  String jumlahPajak;
  String statusPembayaranSppt;
  String keterangan;
  DateTime tglBayar;
  String bukti;
  DateTime? datetime;
  bool isSynced;

  ModelKitiran({
    this.kelurahan,
    this.rt,
    required this.nop,
    required this.nama,
    required this.alamat,
    required this.kecamatanOp,
    required this.kelurahanOp,
    required this.alamatOp,
    required this.tahun,
    required this.jumlahPajak,
    required this.statusPembayaranSppt,
    required this.keterangan,
    required this.tglBayar,
    required this.bukti,
    this.datetime,
    required this.isSynced,
  });

  factory ModelKitiran.fromJson(Map<String, dynamic> json) => ModelKitiran(
        kelurahan: json["kelurahan"],
        rt: json["rt"],
        nop: json["nop"],
        nama: json["nama"],
        alamat: json["alamat"],
        kecamatanOp: json["kecamatan_op"] ?? '',
        kelurahanOp: json["kelurahan_op"] ?? '',
        alamatOp: json["alamat_op"] ?? '',
        tahun: json["tahun"],
        jumlahPajak: json["jumlah_pajak"],
        statusPembayaranSppt: json["status_pembayaran_sppt"],
        keterangan: json["keterangan"],
        tglBayar: DateTime.parse(json["tgl_bayar"]),
        bukti: json["bukti"],
        datetime:
            json["datetime"] != null ? DateTime.parse(json["datetime"]) : null,
        isSynced: json["isSynced"],
      );

  Map<String, dynamic> toJson() => {
        "rt": rt,
        "kelurahan": kelurahan,
        "nop": nop,
        "nama": nama,
        "alamat": alamat,
        "kecamatan_op": kecamatanOp,
        "kelurahan_op": kelurahanOp,
        "alamat_op": alamatOp,
        "tahun": tahun,
        "jumlah_pajak": jumlahPajak,
        "status_pembayaran_sppt": statusPembayaranSppt,
        "keterangan": keterangan,
        "tgl_bayar": tglBayar.toIso8601String(),
        "bukti": bukti,
        "datetime": datetime?.toIso8601String(),
        "isSynced": isSynced,
      };
}
