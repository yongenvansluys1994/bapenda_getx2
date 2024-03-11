// To parse this JSON data, do
//
//     final modelGetpelaporanUser = modelGetpelaporanUserFromJson(jsonString);

import 'dart:convert';

ModelGetpelaporanUser modelGetpelaporanUserFromJson(String str) =>
    ModelGetpelaporanUser.fromJson(json.decode(str));

String modelGetpelaporanUserToJson(ModelGetpelaporanUser data) =>
    json.encode(data.toJson());

class ModelGetpelaporanUser {
  String idDaftarwp;
  String idSpt;
  String idWajibPajak;
  String idRekening;
  String nmRekening;
  String nomorSpt;
  String npwpd;
  String nomorKohir;
  String tanggalLunas;
  String nikUser;
  String namaUsaha;
  String alamatUsaha;
  String jenispajak;
  String namaPemilik;
  String masaPajak;
  String masaPajak2;
  String masaAkhir2;
  String pendapatan;
  String bukti;
  DateTime date;
  String pajak;
  String tarifPersen;
  String status;
  DateTime batasBayar;
  String metodeBayar;

  ModelGetpelaporanUser({
    required this.idDaftarwp,
    required this.idSpt,
    required this.idWajibPajak,
    required this.idRekening,
    required this.nmRekening,
    required this.nomorSpt,
    required this.npwpd,
    required this.nomorKohir,
    required this.tanggalLunas,
    required this.nikUser,
    required this.namaUsaha,
    required this.alamatUsaha,
    required this.jenispajak,
    required this.namaPemilik,
    required this.masaPajak,
    required this.masaPajak2,
    required this.masaAkhir2,
    required this.pendapatan,
    required this.bukti,
    required this.date,
    required this.pajak,
    required this.tarifPersen,
    required this.status,
    required this.batasBayar,
    required this.metodeBayar,
  });

  factory ModelGetpelaporanUser.fromJson(Map<String, dynamic> json) =>
      ModelGetpelaporanUser(
        idDaftarwp: json["ID_DAFTARWP"],
        idSpt: json["ID_SPT"],
        idWajibPajak: json["ID_WAJIB_PAJAK"],
        idRekening: json["ID_REKENING"],
        nmRekening: json["NAMA_REKENING"],
        nomorSpt: json["NOMOR_SPT"],
        npwpd: json["NPWPD"],
        nomorKohir: json["NOMOR_KOHIR"],
        tanggalLunas: json["TANGGAL_LUNAS"],
        nikUser: json["NIK_USER"],
        namaUsaha: json["NAMA_USAHA"],
        alamatUsaha: json["ALAMAT_USAHA"],
        jenispajak: json["JENISPAJAK"],
        namaPemilik: json["NAMA_PEMILIK"],
        masaPajak: json["MASA_PAJAK"],
        masaPajak2: json["MASA_PAJAK2"],
        masaAkhir2: json["MASA_AKHIR2"],
        pendapatan: json["PENDAPATAN"],
        bukti: json["BUKTI"],
        date: DateTime.parse(json["DATE"]),
        pajak: json["PAJAK"],
        tarifPersen: json["TARIF_PERSEN"],
        status: json["STATUS"],
        batasBayar: DateTime.parse(json["BATAS_BAYAR"]),
        metodeBayar: json["METODE_BAYAR"],
      );

  Map<String, dynamic> toJson() => {
        "ID_DAFTARWP": idDaftarwp,
        "ID_SPT": idSpt,
        "ID_WAJIB_PAJAK": idWajibPajak,
        "ID_REKENING": idRekening,
        "NAMA_REKENING": nmRekening,
        "NOMOR_SPT": nomorSpt,
        "NPWPD": npwpd,
        "NOMOR_KOHIR": nomorKohir,
        "TANGGAL_LUNAS": tanggalLunas,
        "NIK_USER": nikUser,
        "NAMA_USAHA": namaUsaha,
        "ALAMAT_USAHA": alamatUsaha,
        "JENISPAJAK": jenispajak,
        "NAMA_PEMILIK": namaPemilik,
        "MASA_PAJAK": masaPajak,
        "MASA_PAJAK2": masaPajak2,
        "MASA_AKHIR2": masaAkhir2,
        "PENDAPATAN": pendapatan,
        "BUKTI": bukti,
        "DATE":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "PAJAK": pajak,
        "TARIF_PERSEN": tarifPersen,
        "STATUS": status,
        "BATAS_BAYAR":
            "${batasBayar.year.toString().padLeft(4, '0')}-${batasBayar.month.toString().padLeft(2, '0')}-${batasBayar.day.toString().padLeft(2, '0')}",
        "METODE_BAYAR": metodeBayar,
      };
}
