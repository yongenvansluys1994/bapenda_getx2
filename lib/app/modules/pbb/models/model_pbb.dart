class ModelPbbInformasi {
  final String namaWp;
  final String alamatWp;
  final String kelurahanWp;
  final String alamatOp;

  ModelPbbInformasi({
    required this.namaWp,
    required this.alamatWp,
    required this.kelurahanWp,
    required this.alamatOp,
  });

  factory ModelPbbInformasi.fromJson(Map<String, dynamic> json) {
    return ModelPbbInformasi(
      namaWp: json['NM_WP_SPPT'] ?? '',
      alamatWp: json['ALM_WP'] ?? '',
      kelurahanWp: json['KELURAHAN_WP_SPPT'] ?? '',
      alamatOp: json['ALM_OP'] ?? '',
    );
  }
}

class ModelPbbSppt {
  final String nopthn;
  final String tahunPajak;
  final String statusPembayaran;
  final String pokok;
  final String denda;
  final String jumlahHarusBayar;
  final String jumlahTelahBayar;
  final String tanggalBayar;

  ModelPbbSppt({
    required this.nopthn,
    required this.tahunPajak,
    required this.statusPembayaran,
    required this.pokok,
    required this.denda,
    required this.jumlahHarusBayar,
    required this.jumlahTelahBayar,
    required this.tanggalBayar,
  });

  factory ModelPbbSppt.fromJson(Map<String, dynamic> json) {
    return ModelPbbSppt(
      nopthn: json['NOPTHN'].toString(),
      tahunPajak: json['THN_PAJAK_SPPT'],
      statusPembayaran: json['STATUS_PEMBAYARAN_SPPT'],
      pokok: json['POKOK'],
      denda: json['DENDA'],
      jumlahHarusBayar: json['JML_HARUS_BAYAR'],
      jumlahTelahBayar: json['JML_TELAH_BAYAR'],
      tanggalBayar: json['TGL_BAYAR'],
    );
  }
}
