import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/lapor_pajak_controller.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_topic.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:http/http.dart' as http;

class TambahNpwpdbaruController extends GetxController {
  final laporController = Get.find<LaporPajakController>();
  late AuthModel authModel;
  double? lat;
  double? long;
  int activeStepIndex = 0;
  XFile? imageFileKTP = null;
  XFile? imageFileNPWP = null;

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

  Set<Marker> markers2 = <Marker>{};

  void addMarkers() {
    if (lat != null && long != null) {
      markers2 = <Marker>{
        Marker(
          markerId: const MarkerId('selected_location'),
          position: LatLng(lat!, long!),
        ),
      };
      update();
    }
  }

  void removelatlng() {
    lat = null;
    long = null;
    logInfo("$lat");
    update();
  }

  bool buttonsalin = false;
  String? ValueJenisPajak;
  String? ValueKelurahan;
  String? ValueKecamatan;

  Future<void> salin() async {
    buttonsalin = true;
    nama_pemilik.text = nama_usaha.text;
    alamat_pemilik.text = alamat_usaha.text;
    rt_pemilik.text = rt_usaha.text;
    kota_pemilik.text = kota_usaha.text;
    kel_pemilik.text = ValueKelurahan!;
    kec_pemilik.text = ValueKecamatan!;
    nohp_pemilik.text = nohp_usaha.text;
    email_pemilik.text = email_usaha.text;
    update();
  }

  Future<void> hapussalin() async {
    buttonsalin = false;
    nama_pemilik.text = "";
    alamat_pemilik.text = "";
    rt_pemilik.text = "";
    kota_pemilik.text = "";
    kel_pemilik.text = "";
    kec_pemilik.text = "";
    nohp_pemilik.text = "";
    email_pemilik.text = "";
    update();
  }

  Future<void> showChoiceDialog(BuildContext context, String KodeGambar) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(8, 6),
                        color: lightGreenColor.withOpacity(0.3)),
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(-1, -5),
                        color: lightGreenColor.withOpacity(0.3))
                  ]),
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      onTap: () {
                        if (KodeGambar == "KTP") {
                          _openGallery(context);
                        } else {
                          _openGalleryNPWP(context);
                        }
                      },
                      title: Text("Gallery"),
                      leading: Icon(
                        Icons.account_box,
                        color: Colors.blue,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      onTap: () {
                        if (KodeGambar == "KTP") {
                          _openCamera(context);
                        } else {
                          _openCameraNPWP(context);
                        }
                      },
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFileKTP = pickedFile!;
    update();
    Get.back();
  }

  void _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    imageFileKTP = pickedFile!;
    update();
    Get.back();
  }

  void _openGalleryNPWP(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFileNPWP = pickedFile!;
    update();
    Get.back();
  }

  void _openCameraNPWP(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    imageFileNPWP = pickedFile!;
    update();
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
  }

  void PickedLocation(PickedData pickedData) async {
    EasyLoading.show(status: "Sedang mengambil titik koordinat");
    lat = null;
    update();
    await Future.delayed(Duration(seconds: 1));
    lat = pickedData.latLong.latitude;
    long = pickedData.latLong.longitude;
    update();
    EasyLoading.dismiss();
    Get.back();
  }

  void SimpanData() {
    getDefaultDialog().onConfirm(
      title: "Anda yakin telah Mengisi Data dengan Benar?",
      desc: "Pastikan data yang anda isi telah sesuai",
      kategori: "warning",
      handler: () {
        Get.back();
        ProsesData();
        update();
      },
    );
  }

  Future ProsesData() async {
    //Awal Loading Disini-------------------------------
    EasyLoading.show();
    var request = http.MultipartRequest(
        "POST", Uri.parse("${URL_APP}/upload_image/daftarwp.php"));
    request.fields['nik'] = "${authModel.nik}";
    request.fields['jenispajak'] = ValueJenisPajak!;
    request.fields['nama_usaha'] = nama_usaha.text;
    request.fields['alamat_usaha'] = alamat_usaha.text;
    request.fields['rt_usaha'] = rt_usaha.text;
    request.fields['rw_usaha'] = "";
    request.fields['kel_usaha'] = ValueKelurahan!;
    request.fields['kec_usaha'] = ValueKecamatan!;
    request.fields['kota_usaha'] = kota_usaha.text;
    request.fields['kdpos_usaha'] = "";
    request.fields['nohp_usaha'] = nohp_usaha.text;
    request.fields['email_usaha'] = email_usaha.text;
    request.fields['nama_pemilik'] = nama_pemilik.text;
    request.fields['pekerjaan_pemilik'] = pekerjaan_pemilik.text;
    request.fields['alamat_pemilik'] = alamat_pemilik.text;
    request.fields['rt_pemilik'] = rt_pemilik.text;
    request.fields['rw_pemilik'] = "";
    request.fields['kel_pemilik'] = kel_pemilik.text;
    request.fields['kec_pemilik'] = kec_pemilik.text;
    request.fields['kota_pemilik'] = kota_pemilik.text;
    request.fields['kdpos_pemilik'] = "";
    request.fields['nohp_pemilik'] = nohp_pemilik.text;
    request.fields['email_pemilik'] = email_pemilik.text;
    request.fields['lat'] = '${lat}';
    request.fields['long'] = '${long}';

    var pic = await http.MultipartFile.fromPath("image", imageFileKTP!.path);
    request.files.add(pic);

    var picnpwp =
        await http.MultipartFile.fromPath("imagenpwp", imageFileNPWP!.path);
    request.files.add(picnpwp);

    var response = await request.send();
    //print(response.statusCode);
    if (response.statusCode == 200) {
      Get.back(); //keluar dari from pendaftaran
      Get.back(); //keluar dari dialog pilihan
      print("sukses");
      EasyLoading.dismiss();
      RawSnackbar_top(
          message: "Berhasil Menyimpan Data", kategori: "success", duration: 3);
      sendPushMessage_topic(
          "operatorpejabat",
          "Pendaftaran Wajib Pajak baru masuk!",
          "Validasi Data ini pada menu Pendaftaran.",
          PENDAFTARAN_MASUK);
      laporController.datalist.clear();
      laporController.init();
      update();
    } else {
      EasyLoading.dismiss();
      RawSnackbar_top(
          message: "Gagal Menyimpan Data", kategori: "error", duration: 2);
      update();
    }
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
