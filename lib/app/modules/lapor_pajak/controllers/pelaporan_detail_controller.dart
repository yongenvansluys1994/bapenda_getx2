import 'dart:async';
import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/pelaporan_history_controller.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_topic.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PelaporanDetailController extends GetxController {
  final pelaporanHistoryC = Get.find<PelaporanHistoryController>();
  Api api;
  PelaporanDetailController(this.api);

  List<int> tahunhistory = [];
  late String jenispajak;
  late ModelObjekku dataArgument;
  DateTime? selectedDate;
  DateTime? selectedDate_akhir;
  var FinalDate;
  var FinalDate_akhir;
  TextEditingController pendapatan = TextEditingController();
  TextEditingController kwh = TextEditingController();
  XFile? imageFile = null;
  XFile? previousImageFile = null;

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
    jenispajak = Get.parameters['jenispajak'].toString();

    int tahunSekarang = DateTime.now().year;
    for (int i = 0; i < 5; i++) {
      tahunhistory.add(
          tahunSekarang - i); //mengisi list tahunhistory 5 tahun kebelakang
    }
    listenFCM();
  }

  void checkhistorynow(DateTime newDate) {
    final controllerhist = Get.find<PelaporanHistoryController>();

    if (controllerhist.datalist.isEmpty) {
      print('Tidak ada data sebelumnya, Anda bisa memasukkan data baru.');
      InputPelaporan();
    } else {
      // Check if newDate already exists in controllerhist.datalist
      bool dateExists = controllerhist.datalist.any((data) {
        DateTime dataDate = DateFormat('dd/MM/yyyy').parse(data.masaPajak2);
        return dataDate.year == newDate.year && dataDate.month == newDate.month;
      });

      if (dateExists) {
        EasyLoading.dismiss();
        logInfo('Data Sudah Ada!');
        getDefaultDialog().onFixWithoutIcon(
            title: "Data Sudah Ada!",
            desc:
                "Anda Telah melapor pada Masa Pajak yang sama sebelumnya! Pastikan anda memilih Masa Pajak dengan Benar");
      } else {
        // logInfo("${jsonEncode(controllerhist.datalist)}");
        ModelGetpelaporanUser lastData = controllerhist.datalist.first;
        DateTime lastDate = DateFormat('dd/MM/yyyy').parse(lastData.masaAkhir2);

        DateTime nextMonth = DateTime(lastDate.year, lastDate.month + 1);
        if (newDate.year == nextMonth.year &&
            newDate.month == nextMonth.month) {
          // Data bisa dimasukkan
          logInfo('Data bisa dimasukkan.');
          InputPelaporan();
        } else {
          EasyLoading.dismiss();
          // Tampilkan notifikasi tidak bisa melompat bulan
          logInfo('Anda tidak bisa melompat bulan.');
          getDefaultDialog().onFixWithoutIcon(
              title: "Mohon maaf!",
              desc:
                  "Pelaporan Pajak tidak bisa melompat bulan, mohon laporkan urutan periode pajak sesuai periode bulan terakhir");
        }
        // logInfo("${jsonEncode(controllerhist.datalist.first)}");
      }
    }
  }

  void checkhistorynow_PPJ(DateTime newDate) {
    final controllerhist = Get.find<PelaporanHistoryController>();

    if (controllerhist.datalist.isEmpty) {
      print('Tidak ada data sebelumnya, Anda bisa memasukkan data baru.');
      InputPelaporanPPJ(); //start proses input pelaporan();
    } else {
      // Check if newDate already exists in controllerhist.datalist
      bool dateExists = controllerhist.datalist.any((data) {
        DateTime dataDate = DateFormat('dd/MM/yyyy').parse(data.masaPajak2);
        return dataDate.year == newDate.year && dataDate.month == newDate.month;
      });

      if (dateExists) {
        EasyLoading.dismiss();
        logInfo('Data Sudah Ada!');
        getDefaultDialog().onFixWithoutIcon(
            title: "Data Sudah Ada!",
            desc:
                "Anda Telah melapor pada Masa Pajak yang sama sebelumnya! Pastikan anda memilih Masa Pajak dengan Benar");
      } else {
        // logInfo("${jsonEncode(controllerhist.datalist)}");
        ModelGetpelaporanUser lastData = controllerhist.datalist.first;
        DateTime lastDate = DateFormat('dd/MM/yyyy').parse(lastData.masaAkhir2);

        DateTime nextMonth = DateTime(lastDate.year, lastDate.month + 1);
        if (newDate.year == nextMonth.year &&
            newDate.month == nextMonth.month) {
          // Data bisa dimasukkan
          logInfo('Data bisa dimasukkan.');
          InputPelaporanPPJ(); //start proses input pelaporan();
        } else {
          EasyLoading.dismiss();
          // Tampilkan notifikasi tidak bisa melompat bulan
          logInfo('Anda tidak bisa melompat bulan.');
          getDefaultDialog().onFixWithoutIcon(
              title: "Mohon maaf!",
              desc:
                  "Pelaporan Pajak tidak bisa melompat bulan, mohon laporkan urutan periode pajak sesuai periode bulan terakhir");
        }
        // logInfo("${jsonEncode(controllerhist.datalist.first)}");
      }
    }
  }

  void month_picker(BuildContext context) {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        var ubahyear =
            "Tahun: ${selectedDate!.year} Bulan: ${selectedDate!.month}";
        FinalDate = ubahyear.toString();
        update();
      }
    });
    update();
  }

  void date_picker_awal(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:
          DateTime.now(), // The initial date when the date picker is opened.
      firstDate: DateTime(2021), // The earliest date that can be selected.
      lastDate: DateTime(
          DateTime.now().year + 1), // The latest date that can be selected.
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        var ubahyear = DateFormat('dd-MM-yyyy').format(selectedDate!);
        FinalDate = ubahyear.toString();
        update();
      }
    });
    update();
  }

  void date_picker_akhir(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:
          DateTime.now(), // The initial date when the date picker is opened.
      firstDate: DateTime(2021), // The earliest date that can be selected.
      lastDate: DateTime(
          DateTime.now().year + 1), // The latest date that can be selected.
    ).then((date) {
      if (date != null) {
        selectedDate_akhir = date;
        var ubahyear = DateFormat('dd-MM-yyyy').format(selectedDate_akhir!);
        FinalDate_akhir = ubahyear.toString();
        update();
      }
    });
    update();
  }

  void onChangedRp(String string) {
    string = '${formNum(
      string.replaceAll(',', ''),
    )}';
    update();
    pendapatan.value = TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
    update();
  }

  void onChangedRpKWH(String string) {
    string = '${formNum(
      string.replaceAll(',', ''),
    )}';
    update();
    kwh.value = TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
    update();
  }

  void simpanLaporan() {
    if (selectedDate == null || pendapatan.text == "") {
      RawSnackbar_bottom(
          message: "Seluruh Form wajib di isi, Periksa kembali",
          kategori: "error",
          duration: 2);
    } else if (imageFile == null) {
      RawSnackbar_bottom(
          message: "Upload Bukti LHP Tidak Boleh Kosong!",
          kategori: "error",
          duration: 2);
    } else {
      getDefaultDialog().onConfirm(
        title: "Kirim Laporan Pajak",
        desc: "Apakah anda yakin sudah mengisi data dengan benar?",
        kategori: "warning",
        handler: () {
          Get.back(); //dismiss dialog confirm
          EasyLoading.show(
            status: "Sedang memproses Pelaporan",
            maskType: EasyLoadingMaskType.clear,
          );
          checkhistorynow(selectedDate!);
          //start proses input pelaporan
          update();
        },
      );
      update();
    }
    update();
  }

  void simpanLaporanCath() {
    if (selectedDate == null ||
        selectedDate_akhir == null ||
        pendapatan.text == "") {
      RawSnackbar_bottom(
          message: "Seluruh Form wajib di isi, Periksa kembali",
          kategori: "error",
          duration: 2);
    } else if (imageFile == null) {
      RawSnackbar_bottom(
          message: "Upload Bukti LHP Tidak Boleh Kosong!",
          kategori: "error",
          duration: 2);
    } else {
      getDefaultDialog().onConfirm(
        title: "Kirim Laporan Pajak",
        desc: "Apakah anda yakin sudah mengisi data dengan benar?",
        kategori: "warning",
        handler: () {
          Get.back(); //dismiss dialog confirm
          EasyLoading.show(
            status: "Sedang memproses Pelaporan",
            maskType: EasyLoadingMaskType.clear,
          );
          InputPelaporanCath(); //start proses input pelaporan
          update();
        },
      );
      update();
    }
    update();
  }

  void simpanLaporanPPJ() {
    if (selectedDate == null || pendapatan.text == "" || kwh.text == "") {
      RawSnackbar_bottom(
          message: "Seluruh Form wajib di isi, Periksa kembali",
          kategori: "error",
          duration: 2);
    } else if (imageFile == null) {
      RawSnackbar_bottom(
          message: "Upload Bukti LHP Tidak Boleh Kosong!",
          kategori: "error",
          duration: 2);
    } else {
      getDefaultDialog().onConfirm(
        title: "Kirim Laporan Pajak",
        desc: "Apakah anda yakin sudah mengisi data dengan benar?",
        kategori: "warning",
        handler: () {
          Get.back(); //dismiss dialog confirm
          EasyLoading.show(
            status: "Sedang memproses Pelaporan",
            maskType: EasyLoadingMaskType.clear,
          );
          checkhistorynow_PPJ(selectedDate!);
          update();
        },
      );
      update();
    }
    update();
  }

  Future<void> InputPelaporan() async {
    bool isUrlAccessible = await checkUrlSimpatda();
    if (isUrlAccessible) {
      // Awal Loading Disini-------------------------------
      var client = http.Client();
      try {
        var request = http.MultipartRequest("POST",
            Uri.parse("${URL_APP}/pelaporan/${dataArgument.idDaftarwp}"));
        request.fields['id_wajib_pajak'] = dataArgument.idWajibPajak;
        request.fields['masa_pajak'] = "${selectedDate}";
        request.fields['pendapatan'] = pendapatan.text;
        request.fields['nik'] = dataArgument.nikUser;
        request.fields['jenispajak'] = jenispajak;
        request.fields['id_daftarwp'] = dataArgument.idDaftarwp;

        if (imageFile != null) {
          var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
          request.files.add(pic);
        }

        var response =
            await client.send(request).timeout(Duration(seconds: 12));
        final responseData = await response.stream.toBytes();
        final respStr = String.fromCharCodes(responseData);
        if (response.statusCode == 200) {
          if (respStr == "Berhasil") {
            FinalDate = null;
            pendapatan.text = "";
            imageFile = null;
            pelaporanHistoryC.GetHistoryPajak(
                tahunhistory[0], false); //update history pelaporan
            update();
            //-------------------------
            getDefaultDialog().onFix(
                title: "Terima Kasih!",
                desc:
                    "Pelaporan Pajak Berhasil! Petugas Kami akan melakukan Verifikasi dan setelahnya Anda dapat membayar.",
                kategori: "success");
            sendPushMessage_topic(
                "operatorpejabat",
                "Pelaporan Pajak Masuk!",
                "Terdapat Pelaporan Pajak baru, Buka aplikasi untuk melihat detailnya",
                PELAPORAN_MASUK);
          } else if (respStr == "SudahAda") {
            getDefaultDialog().onFixWithoutIcon(
                title: "Data Sudah Ada!",
                desc:
                    "Anda Telah melapor pada Masa Pajak yang sama sebelumnya! Pastikan anda memilih Masa Pajak dengan Benar");
          } else {
            RawSnackbar_top(
                message: "Oops.. Kesalahan Koneksi",
                kategori: "error",
                duration: 2);
          }
        } else {
          // Handle other status codes if needed
        }
      } on TimeoutException catch (_) {
        // Handle timeout
        RawSnackbar_top(
            message:
                "Koneksi gagal, harap periksa kembali koneksi internet Anda",
            kategori: "error",
            duration: 2);
      } catch (e) {
        // Handle other errors
        print('Error: $e');
      } finally {
        client.close(); // Close the client when finished
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.showError(
          "Mohon maaf, Server sedang Maintenance, Coba lagi beberapa saat");
    }
  }

  Future<void> InputPelaporanCath() async {
    bool isUrlAccessible = await checkUrlSimpatda();
    if (isUrlAccessible) {
      // Awal Loading Disini-------------------------------
      var client = http.Client();
      try {
        var request = http.MultipartRequest("POST",
            Uri.parse("${URL_APP}/pelaporan/${dataArgument.idDaftarwp}"));
        request.fields['id_wajib_pajak'] = dataArgument.idWajibPajak;
        request.fields['masa_pajak'] = "${selectedDate}";
        request.fields['masa_pajak_akhir'] = "${selectedDate_akhir}";
        request.fields['pendapatan'] = pendapatan.text;
        request.fields['nik'] = dataArgument.nikUser;
        request.fields['jenispajak'] = jenispajak;
        request.fields['id_daftarwp'] = dataArgument.idDaftarwp;

        if (imageFile != null) {
          var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
          request.files.add(pic);
        }

        var response =
            await client.send(request).timeout(Duration(seconds: 12));
        final responseData = await response.stream.toBytes();
        final respStr = String.fromCharCodes(responseData);

        if (response.statusCode == 200) {
          if (respStr == "Berhasil") {
            FinalDate = null;
            FinalDate_akhir = null;
            pendapatan.text = "";
            imageFile = null;
            pelaporanHistoryC.GetHistoryPajak(
                tahunhistory[0], false); //update history pelaporan
            update();
            //-------------------------
            getDefaultDialog().onFix(
                title: "Terima Kasih!",
                desc:
                    "Pelaporan Pajak Berhasil! Petugas Kami akan melakukan Verifikasi dan setelahnya Anda dapat membayar.",
                kategori: "success");
            sendPushMessage_topic(
                "operatorpejabat",
                "Pelaporan Pajak Masuk!",
                "Terdapat Pelaporan Pajak baru, Buka aplikasi untuk melihat detailnya",
                "pelaporan_masuk");
          } else {
            RawSnackbar_top(
                message: "Oops.. Kesalahan Koneksi",
                kategori: "error",
                duration: 2);
          }
        } else {
          // Handle other status codes if needed
        }
      } on TimeoutException catch (_) {
        // Handle timeout
        RawSnackbar_top(
            message:
                "Koneksi gagal, harap periksa kembali koneksi internet Anda",
            kategori: "error",
            duration: 2);
      } catch (e) {
        // Handle other errors
        print('Error: $e');
      } finally {
        client.close(); // Close the client when finished
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.showError(
          "Mohon maaf, Server sedang Maintenance, Coba lagi beberapa saat");
    }
  }

  Future<void> InputPelaporanPPJ() async {
    //Awal Loading Disini-------------------------------
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "${URL_APP}/pelaporan/index_ppj.php?id_daftarwp=${dataArgument.idDaftarwp}"));
    request.fields['id_wajib_pajak'] = dataArgument.idWajibPajak;
    request.fields['masa_pajak'] = "${selectedDate}";
    request.fields['pendapatan'] = pendapatan.text;
    request.fields['kwh'] = kwh.text;
    request.fields['nik'] = dataArgument.nikUser;
    request.fields['jenispajak'] = jenispajak;
    request.fields['id_daftarwp'] = dataArgument.idDaftarwp;

    if (imageFile == null) {
    } else {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      request.files.add(pic);
    }

    var response = await request.send();
    final responseData = await response.stream.toBytes();
    final respStr = String.fromCharCodes(responseData);
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      if (respStr == "Berhasil") {
        FinalDate = null;
        pendapatan.clear();
        kwh.clear();
        imageFile = null;
        pelaporanHistoryC.GetHistoryPajak(
            tahunhistory[0], false); //update history pelaporan
        update();
        //-------------------------
        getDefaultDialog().onFix(
            title: "Terima Kasih!",
            desc:
                "Pelaporan Pajak Berhasil! Petugas Kami akan melakukan Verifikasi dan setelahnya Anda dapat membayar.",
            kategori: "success");
        sendPushMessage_topic(
            "operatorpejabat",
            "Pelaporan Pajak Masuk!",
            "Terdapat Pelaporan Pajak baru, Buka aplikasi untuk melihat detailnya",
            PELAPORAN_MASUK);
      } else if (respStr == "SudahAda") {
        getDefaultDialog().onFixWithoutIcon(
            title: "Data Sudah Ada!",
            desc:
                "Anda Telah melapor pada Masa Pajak yang sama sebelumnya! Pastikan anda memilih Masa Pajak dengan Benar");
      } else {
        RawSnackbar_top(
            message: "Oops.. Kesalahan Koneksi",
            kategori: "error",
            duration: 2);
      }
    }
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                      update();
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
                      _openCamera(context);
                      update();
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _filePicker(context);
                      update();
                    },
                    title: Text("File Pdf"),
                    leading: Icon(
                      Icons.file_copy,
                      color: Colors.blue,
                    ),
                  ),
                ],
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
      source: ImageSource.camera,
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

  void _filePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Ekstensi file yang diizinkan
    );
    imageFile = XFile(result!.files.single.path!);
    Get.back();
    update();
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "bayar_lunas") {
          pelaporanHistoryC.GetHistoryPajak(
              tahunhistory[0], true); //update history pelaporan
          update();
        } else if (message.data['desc'] == "pelaporan_diverif") {
          pelaporanHistoryC.GetHistoryPajak(
              tahunhistory[0], true); //update history pelaporan
          update();
        }

        //Get.toNamed(Routes.LAPOR_PAJAK, arguments: authModel);
      }
    });
  }

  Future<bool> checkUrlSimpatda() async {
    try {
      final response = await api.getUrlSimpatda();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
