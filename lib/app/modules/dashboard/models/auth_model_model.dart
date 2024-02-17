class AuthModel {
  String? nama;
  String? foto;
  String? nik;
  String? noHp;

  AuthModel({this.nama, this.foto, this.nik, this.noHp});

  AuthModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    foto = json['foto'];
    nik = json['nik'];
    noHp = json['no_hp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama'] = nama;
    data['foto'] = foto;
    data['nik'] = nik;
    data['no_hp'] = noHp;
    return data;
  }
}
