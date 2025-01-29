class ModelPbbSpptKitiran {
  final String nopThn;
  final String thnPajakSppt;
  final String statusPembayaranSppt;
  final String pokok;
  final String denda;
  final String jmlHarusBayar;
  final String jmlTelahBayar;
  final String tglBayar;

  ModelPbbSpptKitiran({
    required this.nopThn,
    required this.thnPajakSppt,
    required this.statusPembayaranSppt,
    required this.pokok,
    required this.denda,
    required this.jmlHarusBayar,
    required this.jmlTelahBayar,
    required this.tglBayar,
  });

  factory ModelPbbSpptKitiran.fromJson(Map<String, dynamic> json) {
    return ModelPbbSpptKitiran(
      nopThn: json["NOPTHN"],
      thnPajakSppt: json["THN_PAJAK_SPPT"],
      statusPembayaranSppt: json["STATUS_PEMBAYARAN_SPPT"],
      pokok: json["POKOK"],
      denda: json["DENDA"],
      jmlHarusBayar: json["JML_HARUS_BAYAR"],
      jmlTelahBayar: json["JML_TELAH_BAYAR"],
      tglBayar: json["TGL_BAYAR"],
    );
  }
}
