import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ObjekkuDetailController extends GetxController {
  late ModelObjekku dataArgument;
  String? authModel_no_hp;

  double? lat;
  double? long;
  int activeStepIndex = 0;
  XFile? imageFileKTP = null;
  XFile? imageFileNPWP = null;

  final PageController pageController = PageController();
  int currentPage = 0;

  TextEditingController nama_usaha = TextEditingController();
  TextEditingController alamat_usaha = TextEditingController();
  TextEditingController rt_usaha = TextEditingController();
  TextEditingController kota_usaha = TextEditingController();
  TextEditingController nohp_usaha = TextEditingController();
  TextEditingController email_usaha = TextEditingController();
  TextEditingController nama_pemilik = TextEditingController();
  TextEditingController pekerjaan_pemilik = TextEditingController();
  TextEditingController alamat_pemilik = TextEditingController();
  TextEditingController rt_pemilik = TextEditingController();
  TextEditingController kota_pemilik = TextEditingController();
  TextEditingController nohp_pemilik = TextEditingController();
  TextEditingController email_pemilik = TextEditingController();
  TextEditingController kel_pemilik = TextEditingController();
  TextEditingController kec_pemilik = TextEditingController();

  bool isVisibleSwipe = false;

  Set<Marker> markers2 = <Marker>{};

  void addMarkers() {
    var latm = lat == null ? 0.13295280196348974 : lat!;
    var longm = long == null ? 0.13295280196348974 : long!;
    markers2 = <Marker>{
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latm, longm),
      ),
    };
    update();
  }

  bool buttonsalin = false;
  String? ValueKelurahan;
  String? ValueKecamatan;

  Future<void> salin() async {
    buttonsalin = true;
    rt_pemilik.text = rt_usaha.text;
    kota_pemilik.text = kota_usaha.text;
    nohp_pemilik.text = nohp_usaha.text;
    email_pemilik.text = email_usaha.text;
    update();
  }

  Future<void> hapussalin() async {
    buttonsalin = false;
    rt_pemilik.text = "";
    kota_pemilik.text = "";
    nohp_pemilik.text = "";
    email_pemilik.text = "";
    update();
  }

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    authModel_no_hp = Get.parameters['authModel_no_hp']!;
    dataArgument = Get.arguments;
    nama_usaha.text = dataArgument.namaUsaha;
    alamat_usaha.text = dataArgument.alamatUsaha;
    rt_usaha.text = dataArgument.rtUsaha;
    kota_usaha.text = dataArgument.kotaUsaha;
    nohp_usaha.text = dataArgument.nohpUsaha;
    email_usaha.text = dataArgument.emailUsaha;
    nama_pemilik.text = dataArgument.namaPemilik;
    pekerjaan_pemilik.text = dataArgument.pekerjaanPemilik;
    alamat_pemilik.text = dataArgument.alamatPemilik;
    rt_pemilik.text = dataArgument.rtPemilik;
    kota_pemilik.text = dataArgument.kotaPemilik;
    nohp_pemilik.text = dataArgument.nohpPemilik;
    email_pemilik.text = dataArgument.emailPemilik;
    kel_pemilik.text = dataArgument.kelPemilik;
    kec_pemilik.text = dataArgument.kecPemilik;
    ValueKelurahan = dataArgument.kelUsaha;
    ValueKecamatan = dataArgument.kecUsaha;
    lat = double.parse(dataArgument.lat);
    long = double.parse(dataArgument.lng);
    visibleSwipe();
    update();
  }

  void visibleSwipe() {
    Future.delayed(Duration(milliseconds: 700), () {
      //isVisibleSwipe = !isVisibleSwipe;
      isVisibleSwipe = true;
      update();
    });
  }

  void swipePage() {
    isVisibleSwipe = !isVisibleSwipe;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
