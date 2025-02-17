import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/controllers/ekitiran_controller.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/models/kitiran_model.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/models/rt_model.dart';
import 'package:bapenda_getx2/app/modules/ekitiran_form/models/pbbkitiran_model.dart';
import 'package:bapenda_getx2/app/modules/pbb/models/model_pbb.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EkitiranFormController extends GetxController {
  final storage = GetStorage();
  final ekitiranController = Get.find<EkitiranController>();
  late RTModel rtModel;
  final TextEditingController nama_cari = TextEditingController();
  final TextEditingController nop_cari = TextEditingController();
  final TextEditingController nama_wp = TextEditingController();
  final TextEditingController jumlah_pajak = TextEditingController();
  final TextEditingController alamat_wp = TextEditingController();
  final TextEditingController kelurahan_wp = TextEditingController();
  final TextEditingController kecamatan_op = TextEditingController();
  final TextEditingController kelurahan_op = TextEditingController();
  final TextEditingController alamat_op = TextEditingController();

  String ket_loading = "Sedang Memproses";
  bool isReadySubmit = false;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  bool isError = false;
  String message = "";
  XFile? imageFile = null;
  XFile? previousImageFile = null;

  Rx<ModelPbbInformasi> dataInformasi = ModelPbbInformasi(
    namaWp: '',
    alamatWp: '',
    kelurahanWp: '',
    kecamatanOp: '',
    kelurahanOp: '',
    alamatOp: '',
  ).obs;

  var maskFormatter = MaskTextInputFormatter(
    mask: '##.##.###.###.###.####.#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void onInit() {
    super.onInit();
    rtModel = Get.arguments['rtModel'];
  }

  Future<void> FetchData() async {
    EasyLoading.show(
        status: "Sedang Mencari Data", maskType: EasyLoadingMaskType.clear);
    try {
      // Membuat header dengan Basic Authorization
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('API_BPD_ETAM:API_BPD_ETAM'))}';

      String cleanedNOP = nop_cari.text.replaceAll(RegExp(r'[^0-9]'), '');
      // Melakukan request HTTP
      final response = await http.get(
        Uri.parse(
            "https://pajak.bontangkita.id/sismiop/api/informasi/wajib_pajak/${cleanedNOP}"),
        headers: {'Authorization': basicAuth},
      );

      // Mengecek apakah status code berhasil
      if (response.statusCode == 200) {
        // Parsing JSON dari response body
        String jsonData = response.body;
        final parsedData = json.decode(jsonData);

        if (parsedData["is_error"]) {
          isReadySubmit = false;
          isError = parsedData["is_error"];
          message = parsedData["message"];

          getDefaultDialog().onFix(
            title: message,
            desc: "Isi kembali kolom pencarian NOP dengan benar",
            kategori: "warning",
          );
        } else {
          EasyLoading.showSuccess("Data NOP ditemukan!");
          isReadySubmit = true;
          isError = parsedData["is_error"];
          message = parsedData["message"];

          // Mengambil data 'informasi' dari JSON
          final informasiData = parsedData['data']['informasi'];

          // Membuat objek ModelPbbInformasi dari informasiData
          ModelPbbInformasi informasi =
              ModelPbbInformasi.fromJson(informasiData);

          // Memperbarui data di Rx dengan objek ModelPbbInformasi yang baru
          dataInformasi.value = informasi;

          // Jika Anda ingin mengisi ke TextEditingController juga, lakukan ini:
          nama_wp.text = informasi.namaWp;
          alamat_wp.text = informasi.alamatWp;
          kelurahan_wp.text = informasi.kelurahanWp;
          kecamatan_op.text = informasi.kecamatanOp;
          kelurahan_op.text = informasi.kelurahanOp;
          alamat_op.text = informasi.alamatOp;
          isEmpty = false;
          dismissKeyboard();
        }
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        print("Request failed with status: ${response.statusCode}");
        update();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Error: $e");
    }
  }

  Future<void> fetchDataOffline() async {
    try {
      isLoading = true;
      EasyLoading.show(
          status: "Mencari Data Offline", maskType: EasyLoadingMaskType.clear);

      // Membaca data dari GetStorage
      List<dynamic>? jsonData = storage.read('data_pbb');

      if (jsonData == null || jsonData.isEmpty) {
        EasyLoading.showError("Data tidak ditemukan, Periksa NOP kembali");

        isEmpty = true;
        return;
      }

      // Filter data berdasarkan NOP yang dicari
      String cleanedNOP = nop_cari.text.replaceAll(RegExp(r'[^0-9]'), '');
      String targetNOPTHN = "${cleanedNOP}${tahun_pbb}";

      // Mencari data yang sesuai
      var matchedData = jsonData.firstWhere(
        (item) => item["NOPTHN"] == targetNOPTHN,
        orElse: () => null,
      );

      if (matchedData == null) {
        // Data tidak ditemukan
        isEmpty = true;
        EasyLoading.showError("Data tidak ditemukan di penyimpanan lokal");
      } else {
        // Data ditemukan
        EasyLoading.showSuccess("Data NOP ditemukan di penyimpanan lokal!");
        isReadySubmit = true;

        // Map data ke model
        dataInformasi.value = ModelPbbInformasi(
          namaWp: matchedData["NM_WP_SPPT"],
          alamatWp: matchedData["ALM_WP"],
          kelurahanWp: matchedData["KELURAHAN_WP_SPPT"],
          kecamatanOp: matchedData["KECAMATAN_OP"],
          kelurahanOp: matchedData["KELURAHAN_OP"],
          alamatOp: matchedData["ALM_OP"],
        );

        // Isi field UI
        nama_wp.text = dataInformasi.value.namaWp;
        alamat_wp.text = dataInformasi.value.alamatWp;
        kelurahan_wp.text = dataInformasi.value.kelurahanWp;
        alamat_op.text = dataInformasi.value.alamatOp;
        kecamatan_op.text = dataInformasi.value.kecamatanOp;
        kelurahan_op.text = dataInformasi.value.kelurahanOp;
        jumlah_pajak.text = "0";

        isEmpty = false;
      }

      dismissKeyboard();
      isLoading = false;
      update();
    } catch (e) {
      EasyLoading.dismiss();
      getDefaultDialog().onConfirmWithoutIcon(
        title: "Kesalahan Jaringan",
        desc: "Coba lagi namun Internet anda harus Aktif",
        handler: () async {
          Get.back();
          bool isConnected = await isInternetConnected();
          if (isConnected == true) {
            FetchData();
          } else {
            EasyLoading.showError("Internet Belum Aktif");
          }
        },
      );
      isLoading = false;
      update();
    }
  }

  void SimpanData() async {
    // Cek apakah NOP sudah dicari
    if (!isReadySubmit) {
      EasyLoading.showError("NOP Belum dicari, Cari NOP terlebih dahulu");
      return;
    }

    // Cek apakah foto sudah di-upload
    if (imageFile == null) {
      EasyLoading.showError("Foto Dokumentasi belum di Upload");
      return;
    }

    // Cek koneksi internet
    bool isConnected = await isInternetConnected();

    if (isConnected) {
      await CheckUnSyncKitiranStorage(); // Sinkronisasi data dulu
      ProsesSimpanData(); // Kemudian simpan data
    } else {
      ProsesSimpanOffline(); // Simpan offline jika tidak ada internet
    }
  }

  Future<void> CheckUnSyncKitiranStorage() async {
    // Ambil semua data dari GetX Storage
    List<ModelKitiran> kitiranList =
        (GetStorage().read<List<dynamic>>('kitiran_pbb') ?? [])
            .map((e) => ModelKitiran.fromJson(e))
            .toList();

    // Filter data yang belum tersinkronisasi
    List<ModelKitiran> unsyncedData =
        kitiranList.where((item) => !item.isSynced).toList();

    // Jika ada data yang belum tersinkronisasi, jalankan sync
    if (unsyncedData.isNotEmpty) {
      await ekitiranController.syncAndFetchKitiran();
    }
  }

  void ProsesSimpanOffline() async {
    // Bersihkan NOP dari karakter non-angka
    String cleanedNOP = nop_cari.text.replaceAll(RegExp(r'[^0-9]'), '');
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    try {
      // Buat instance dari ModelKitiran dengan data input form
      ModelKitiran newKitiran = ModelKitiran(
        kelurahan: rtModel.kelurahan,
        rt: rtModel.rt,
        nop: cleanedNOP,
        nama: nama_wp.text,
        alamat: alamat_op.text,
        kecamatanOp: kecamatan_op.text,
        kelurahanOp: kelurahan_op.text,
        alamatOp: alamat_op.text,
        tahun: tahun_pbb,
        jumlahPajak: '0', // Nilai default
        statusPembayaranSppt: 'BELUM LUNAS', // Nilai default
        keterangan: '', // Nilai default
        tglBayar: DateTime(1970, 1, 1), // Nilai default
        bukti: imageFile!.path, // Use compressed image path
        isSynced: false, // Tandai data sebagai belum tersinkronisasi
      );

      logInfo("Kitiran Baru Offline : ${jsonEncode(newKitiran)}");

      // Ambil data yang sudah ada di GetX Storage
      List<ModelKitiran> kitiranList = [];

      var storedData = GetStorage().read<List<dynamic>>('kitiran_pbb');
      if (storedData != null && storedData.isNotEmpty) {
        kitiranList = List<ModelKitiran>.from(
          storedData
              .map((e) => ModelKitiran.fromJson(e as Map<String, dynamic>)),
        );
      }

      // Cek jika data dengan NOP yang sama sudah ada
      bool isExist = kitiranList.any((kitiran) => kitiran.nop == cleanedNOP);

      if (!isExist) {
        kitiranList.insert(0, newKitiran);

        // Simpan kembali list yang diperbarui ke GetX Storage
        GetStorage().write(
          'kitiran_pbb',
          kitiranList.map((e) => e.toJson()).toList(),
        );

        Get.back();
        ekitiranController.FetchKitiranOffline();

        RawSnackbar_bottom(
          message: "Data berhasil disimpan ke penyimpanan lokal.",
          kategori: "success",
          duration: 3,
        );
      } else {
        RawSnackbar_top(
          message: "Data dengan NOP ini sudah ada.",
          kategori: "warning",
          duration: 3,
        );
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      RawSnackbar_top(
        message: "Gagal menyimpan data: $e",
        kategori: "Error",
        duration: 3,
      );
    } finally {
      EasyLoading.dismiss();
      update();
    }
  }

  void ProsesSimpanData() async {
    String cleanedNOP = nop_cari.text.replaceAll(RegExp(r'[^0-9]'), '');
    EasyLoading.show(
        status: "Sedang Mengirim Data", maskType: EasyLoadingMaskType.clear);

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("${URL_APP}/ekitiran/kitiran_input.php"));

      request.fields['kelurahan'] = '${rtModel.kelurahan}';
      request.fields['rt'] = '${rtModel.rt}';
      request.fields['nop'] = '${cleanedNOP}';
      request.fields['nama'] = '${nama_wp.text}';
      request.fields['alamat'] = '${alamat_op.text}';
      request.fields['kecamatan_op'] = '${kecamatan_op.text}';
      request.fields['kelurahan_op'] = '${kelurahan_op.text}';
      request.fields['alamat_op'] = '${alamat_op.text}';
      request.fields['tahun'] = '${tahun_pbb}';
      request.fields['jumlah_pajak'] = '0';
      request.fields['status_pembayaran_sppt'] = 'BELUM LUNAS';
      request.fields['keterangan'] = '';
      request.fields['tgl_bayar'] = '1970-01-01';

      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      request.files.add(pic);

      var response =
          await request.send().timeout(Duration(seconds: 30), onTimeout: () {
        throw Exception("Timeout");
      });

      var responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);

      if (response.statusCode == 200 && data['success'] != null) {
        EasyLoading.dismiss();
        final fileName = path.basename(imageFile!.path);
        await clearImagePickerCache(fileName);
        ekitiranController.refreshData(rtModel.kelurahan, rtModel.rt);
        Get.back();
        RawSnackbar_bottom(
          message: "${data['success']}",
          kategori: "success",
          duration: 3,
        );
      } else if (data['Error'] == "Sudah_Ada") {
        EasyLoading.dismiss();
        RawSnackbar_top(
          message: "Data NOP Sudah Ada",
          kategori: "error",
          duration: 3,
        );
      } else {
        await EasyLoading
            .dismiss(); // Tunggu loading berhenti sebelum simpan offline
        ProsesSimpanOffline();
        RawSnackbar_top(
          message: "Terkendala Jaringan, Namun Data tetap tersimpan!.",
          kategori: "success",
          duration: 3,
        );
      }
    } catch (e) {
      await EasyLoading
          .dismiss(); // Tunggu loading berhenti sebelum simpan offline
      ProsesSimpanOffline();
      RawSnackbar_top(
        message: "Koneksi Timeout, Data tetap tersimpan!.",
        kategori: "success",
        duration: 3,
      );
    }

    update();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Pilih Opsi",
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
                        _openGallery(context);
                      },
                      title: Text("Galeri HP"),
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
                        _openCamera(context);
                      },
                      title: Text("Kamera/Foto Langsung"),
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
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800, // Set target width
      maxHeight: 800, // Set target height
      imageQuality: 50, // Set quality (0-100)
    );
    //agar tidak terjadinya penumpukan cache bila user ganti2 foto
    if (previousImageFile != null) {
      final previousFileName = path.basename(previousImageFile!.path);
      await clearImagePickerCache(previousFileName);
    }
    imageFile = pickedFile!;
    previousImageFile = pickedFile;
    update();
    Get.back();
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera, maxWidth: 800, // Set target width
      maxHeight: 800, // Set target height
      imageQuality: 50, // Set quality (0-100)
    );
    if (previousImageFile != null) {
      final previousFileName = path.basename(previousImageFile!.path);
      await clearImagePickerCache(previousFileName);
    }
    imageFile = pickedFile!;
    previousImageFile = pickedFile;
    update();
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void resetData() {
    try {
      // Hapus data yang tersimpan di GetX Storage untuk 'kitiran_pbb'
      GetStorage().remove('already_sync_ekitiran');

      // Tampilkan snackbar untuk memberi tahu pengguna bahwa data telah direset
      RawSnackbar_bottom(
        message: "Data berhasil direset.",
        kategori: "success",
        duration: 3,
      );
    } catch (e) {
      // Tampilkan error jika terjadi kesalahan
      RawSnackbar_top(
        message: "Gagal mereset data: $e",
        kategori: "Error",
        duration: 3,
      );
    }
  }

  void resetAkunRT() {
    try {
      // Hapus data yang tersimpan di GetX Storage untuk 'kitiran_pbb'
      GetStorage().remove('user_rt');

      // Tampilkan snackbar untuk memberi tahu pengguna bahwa data telah direset
      RawSnackbar_bottom(
        message: "Data berhasil direset.",
        kategori: "success",
        duration: 3,
      );
    } catch (e) {
      // Tampilkan error jika terjadi kesalahan
      RawSnackbar_top(
        message: "Gagal mereset data: $e",
        kategori: "Error",
        duration: 3,
      );
    }
  }

  Future<void> clearImagePickerCache(String fileName) async {
    final directory = await getTemporaryDirectory();
    final cacheDirectory = Directory(directory.path);

    final cleanFileName = fileName.replaceFirst(RegExp(r'^scaled_'), '');

    if (cacheDirectory.existsSync()) {
      print("Cache directory: ${cacheDirectory.path}");
      for (var file in cacheDirectory.listSync(recursive: true)) {
        if (file is File && file.path.contains(cleanFileName)) {
          print('Deleting image cache: ${file.path}');
          await file.delete();
        }
      }
    }
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

// Jika tidak ada koneksi sama sekali, langsung return false
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Coba melakukan ping ke Google DNS untuk memastikan akses internet
    // Set timeout agar tidak menunggu terlalu lama
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 2)); // Timeout 2 detik
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet benar-benar aktif
      }
    } catch (e) {
      return false; // Tidak bisa mengakses internet
    }

    return false;
  }

  void isReadySubmitToFalse() {
    isReadySubmit = false;
    update();
    logInfo("isreadysubmit to false");
  }
}
