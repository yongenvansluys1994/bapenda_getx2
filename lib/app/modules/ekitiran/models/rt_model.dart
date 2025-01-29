class RTModel {
  String? id_user_rt;
  String? nama;
  String? kecamatan;
  String? kelurahan;
  String? rt;
  bool? isSynced;

  RTModel({
    this.id_user_rt,
    this.nama,
    this.kecamatan,
    this.kelurahan,
    this.rt,
    this.isSynced,
  });

  RTModel.fromJson(Map<String, dynamic> json) {
    id_user_rt = json['id_user_rt'];
    nama = json['nama'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    rt = json['rt'];
    isSynced = json['isSynced'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_user_rt'] = id_user_rt;
    data['nama'] = nama;
    data['kecamatan'] = kecamatan;
    data['kelurahan'] = kelurahan;
    data['rt'] = rt;
    data['isSynced'] = isSynced;
    return data;
  }
}
