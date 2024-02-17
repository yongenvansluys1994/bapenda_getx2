// To parse this JSON data, do
//
//     final modelObjekku = modelObjekkuFromJson(jsonString);

import 'dart:convert';

ModelObjekku modelObjekkuFromJson(String str) =>
    ModelObjekku.fromJson(json.decode(str));

String modelObjekkuToJson(ModelObjekku data) => json.encode(data.toJson());

class ModelObjekku {
  ModelObjekku({
    required this.idDaftarwp,
    required this.idWajibPajak,
    required this.nikUser,
    required this.npwpd,
    required this.namaUsaha,
    required this.alamatUsaha,
    required this.rtUsaha,
    required this.rwUsaha,
    required this.kelUsaha,
    required this.kecUsaha,
    required this.kotaUsaha,
    required this.kdposUsaha,
    required this.nohpUsaha,
    required this.emailUsaha,
    required this.jenispajak,
    required this.namaPemilik,
    required this.pekerjaanPemilik,
    required this.alamatPemilik,
    required this.rtPemilik,
    required this.rwPemilik,
    required this.kelPemilik,
    required this.kecPemilik,
    required this.kotaPemilik,
    required this.kdposPemilik,
    required this.nohpPemilik,
    required this.emailPemilik,
    required this.imageKtp,
    required this.imageNpwp,
    required this.lat,
    required this.lng,
    required this.status,
  });

  String idDaftarwp;
  String idWajibPajak;
  String nikUser;
  String npwpd;
  String namaUsaha;
  String alamatUsaha;
  String rtUsaha;
  String rwUsaha;
  String kelUsaha;
  String kecUsaha;
  String kotaUsaha;
  String kdposUsaha;
  String nohpUsaha;
  String emailUsaha;
  String jenispajak;
  String namaPemilik;
  String pekerjaanPemilik;
  String alamatPemilik;
  String rtPemilik;
  String rwPemilik;
  String kelPemilik;
  String kecPemilik;
  String kotaPemilik;
  String kdposPemilik;
  String nohpPemilik;
  String emailPemilik;
  String imageKtp;
  String imageNpwp;
  String lat;
  String lng;
  String status;

  factory ModelObjekku.fromJson(Map<String, dynamic> json) => ModelObjekku(
        idDaftarwp: json["id_daftarwp"],
        idWajibPajak: json["id_wajib_pajak"],
        nikUser: json["nik_user"],
        npwpd: json["npwpd"],
        namaUsaha: json["nama_usaha"],
        alamatUsaha: json["alamat_usaha"],
        rtUsaha: json["rt_usaha"],
        rwUsaha: json["rw_usaha"],
        kelUsaha: json["kel_usaha"],
        kecUsaha: json["kec_usaha"],
        kotaUsaha: json["kota_usaha"],
        kdposUsaha: json["kdpos_usaha"],
        nohpUsaha: json["nohp_usaha"],
        emailUsaha: json["email_usaha"],
        jenispajak: json["jenispajak"],
        namaPemilik: json["nama_pemilik"],
        pekerjaanPemilik: json["pekerjaan_pemilik"],
        alamatPemilik: json["alamat_pemilik"],
        rtPemilik: json["rt_pemilik"],
        rwPemilik: json["rw_pemilik"],
        kelPemilik: json["kel_pemilik"],
        kecPemilik: json["kec_pemilik"],
        kotaPemilik: json["kota_pemilik"],
        kdposPemilik: json["kdpos_pemilik"],
        nohpPemilik: json["nohp_pemilik"],
        emailPemilik: json["email_pemilik"],
        imageKtp: json["image_ktp"],
        imageNpwp: json["image_npwp"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_daftarwp": idDaftarwp,
        "id_wajib_pajak": idWajibPajak,
        "nik_user": nikUser,
        "npwpd": npwpd,
        "nama_usaha": namaUsaha,
        "alamat_usaha": alamatUsaha,
        "rt_usaha": rtUsaha,
        "rw_usaha": rwUsaha,
        "kel_usaha": kelUsaha,
        "kec_usaha": kecUsaha,
        "kota_usaha": kotaUsaha,
        "kdpos_usaha": kdposUsaha,
        "nohp_usaha": nohpUsaha,
        "email_usaha": emailUsaha,
        "jenispajak": jenispajak,
        "nama_pemilik": namaPemilik,
        "pekerjaan_pemilik": pekerjaanPemilik,
        "alamat_pemilik": alamatPemilik,
        "rt_pemilik": rtPemilik,
        "rw_pemilik": rwPemilik,
        "kel_pemilik": kelPemilik,
        "kec_pemilik": kecPemilik,
        "kota_pemilik": kotaPemilik,
        "kdpos_pemilik": kdposPemilik,
        "nohp_pemilik": nohpPemilik,
        "email_pemilik": emailPemilik,
        "image_ktp": imageKtp,
        "image_npwp": imageNpwp,
        "lat": lat,
        "lng": lng,
        "status": status,
      };
}
