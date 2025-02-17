class PanduanModel {
  final String idPanduan;
  final String nmPanduan;
  final String nmFolder;
  final String typePanduan;
  final String urlVideo;
  final List<String> listFoto;

  PanduanModel({
    required this.idPanduan,
    required this.nmPanduan,
    required this.nmFolder,
    required this.typePanduan,
    required this.urlVideo,
    required this.listFoto,
  });

  factory PanduanModel.fromJson(Map<String, dynamic> json) {
    return PanduanModel(
      idPanduan: json['id_panduan'],
      nmPanduan: json['nm_panduan'],
      nmFolder: json['nm_folder'],
      typePanduan: json['type_panduan'],
      urlVideo: json['url_video'],
      listFoto:
          List<String>.from(json['list_foto']), // Konversi ke List<String>
    );
  }
}
