import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';

class QrispbbController extends GetxController {
  late AuthModel authModel;
  late ModelGetpelaporanUser dataArgument;
  int? totalpajak;
  String $id_institution_qris =
      "211028001"; //9 digit id_institution khusus QRIS dari BPD
  String username = "qrisdev";
  String password = "PB@|1Kp@paN19112021";
  String kategoriauth = "qrisdev";
  bool isLoading = false;
  String ket_loading = "Sedang Memproses QRIS";
  String barcode_qris = "0";

  Timer? countdownTimer;
  Rx<Duration> myDuration = Duration(seconds: 0).obs;
  int? detik_countdown;
  String strDigits(int n) => n.toString().padLeft(2, '0');
  String? hours;
  String? minutes;
  String? seconds;

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    update();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    final seconds = myDuration.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      // Handle countdown completion
    } else {
      myDuration.value = Duration(seconds: seconds);
    }
  }

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    var user = box.read(STORAGE_LOGIN_USER_DATA);

    authModel = AuthModel.fromJson(user);
    super.onInit();
    //List<dynamic> arguments = Get.arguments;
    //dataArgument = arguments[0]; //data SPT
    totalpajak = 92340; //pajak

    CheckQRIS();
    startTimer();
    update();
  }

  Future CheckQRIS() async {
    isLoading = true;
    //fetch API CHECK QRIS RUMAHWEB
    var url_update = Uri.parse("${URL_APP}/vaqris_dev/check_qris.php");
    var response = await http.post(url_update, body: {
      "nomor_pembayaran": "2024023389",
    });
    List data = json.decode(response.body);
    if (data[0]["message"] == "null") {
      //jika QRIS belum ada/belum pernah di generate untuk nomor_pembayaran ini
      //Auth Untuk pertama kali
      print("QRIS belum ada, GO fetch AuthApiQRIS");
      AuthApiQRIS();
    } else {
      //jika QRIS sudah ada
      DateTime waktuva1 = DateTime.parse(data[0]["expired_time"]);
      DateTime waktuva2 = DateTime.now();
      bool isAfter = waktuva2.isAfter(waktuva1);

      final batas_aktif_QRIS = waktuva1;
      int seconds_batas_QRIS = batas_aktif_QRIS.difference(waktuva2).inSeconds;
      print(waktuva2);
      myDuration.value = Duration(seconds: seconds_batas_QRIS);

      if (isAfter == true) {
        //jika sudah melewati masa aktif QRIS
        //Auth Ulang Kembali
        print(
            "QRIS sudah tidak aktif karena melebihi 24 jam, Go Fetch AuthApiQRIS");
        AuthApiQRIS();
        update();
      } else {
        //jika VA sudah ada dan masih aktif
        print("QRIS berhasil ditampilkan");
        print(data[0]["barcode"]);
        barcode_qris = data[0]["barcode"];
        isLoading = false;
        update();
      }
    }
  }

  Future AuthApiQRIS() async {
    isLoading = true;
    var url_auth = Uri.parse(
        "${URL_APP}/vaqris_dev/check_auth.php?kategori=${kategoriauth}");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 3600000) {
      //jika sudah melewati masa aktif Auth yaitu 1 Jam
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {
        "username": "${username}",
        "password": "${password}"
      }; //{"username": "${username}", "password": "${password}"}
      var url = Uri.parse(
          "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Generate Virtual Account";
        var url_update = Uri.parse(
            "${URL_APP}/vaqris_dev/update.php?kategori=${kategoriauth}");
        var response = await http.post(url_update, body: {
          "username": "${username}",
          "password": "${password}",
          "token": "${data['token']}",
        });
        var data_update = json.decode(response.body);
        if (data_update == "Success") {
          //jika berhasil perbaharui Token di table auth_vaqris Bapenda Rumahweb
          print(
              "Sukses Perbaharui Token Auth di db table auth_vaqris Bapenda ETAM");
          //create New QRIS
          //-------------------CREATE QRIS------------------------------------
          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['token']}',
          };
          final body = {
            "institution": "${$id_institution_qris}",
            "amount": "${totalpajak}",
            "method": "12",
            "kd_tagihan": "2024023389"
          };
          var url = Uri.parse(
              "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/generate");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_QRIS = json.decode(response.body);
          if (data_QRIS['message'] == "success") {
            //jika berhasil create QRIS
            //insert/update number QRIS di table QRIS
            print("${data_QRIS}");
            print("QRIS berhasil dibuat di API Bankaltim");
            ket_loading = "QRIS Berhasil dibuat, Mohon menunggu sebentar lagi";
            var url_update = Uri.parse("${URL_APP}/vaqris_dev/create_qris.php");
            var response = await http.post(url_update, body: {
              "nomor_pembayaran": "2024023389",
              "amount": "${totalpajak}",
              "method": "12",
              "kd_tagihan": "2024023389",
              "creator": "${data_QRIS['creator']}",
              "barcode": "${data_QRIS['barcode']}",
              "expired_time": "${data_QRIS['expired_time']}",
            });
            var data_numberQRIS = json.decode(response.body);
            if (data_numberQRIS == "Success") {
              //jika berhasil insert/update number QRIS di table QRIS rumahweb
              print(
                  "berhasil insert/update number QRIS di table QRIS rumahweb");
              // final batas_aktif_QRIS =
              //     DateTime.parse(data_QRIS['expired_time']);
              final batas_aktif_QRIS =
                  DateTime.now().add(const Duration(days: 1));
              int seconds_batas_QRIS =
                  batas_aktif_QRIS.difference(DateTime.now()).inSeconds;
              myDuration.value = Duration(seconds: seconds_batas_QRIS);
              barcode_qris = "${data_QRIS['barcode']}";
              isLoading = false;
              update();
            } else {
              print(
                  "Gagal insert/update number QRIS di table QRIS ke API bapenda ETAM");
              isLoading = false;
              update();
            }
          } else {
            print("Gagal Create QRIS API Bankaltimtara");
            print(data_QRIS);
            isLoading = false;
            update();
          }
          //---------------------END CREATE QRIS------------------------------
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoading = false;
          update();
        }
      } else {
        print("Gagal Auth API Bankaltimtara");
        print(data);
        isLoading = false;
        update();
      }
    } else {
      //jika token Auth masih aktif
      print("Auth masih aktif, langsung create QRIS");
      ket_loading = "Sedang Generate Virtual Account";
      //-------------------CREATE QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };
      final body = {
        "institution": "${$id_institution_qris}",
        "amount": "${totalpajak}",
        "method": "12",
        "kd_tagihan": "2024023389"
      };
      var url = Uri.parse(
          "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/generate");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data_QRIS = json.decode(response.body);
      if (data_QRIS['message'] == "success") {
        //jika berhasil create QRIS
        //insert/update number QRIS di table QRIS
        print("${data_QRIS}");
        print("QRIS berhasil dibuat di API Bankaltim");
        ket_loading = "QRIS Berhasil dibuat, Mohon menunggu sebentar lagi";
        var url_update = Uri.parse("${URL_APP}/vaqris_dev/create_qris.php");
        var response = await http.post(url_update, body: {
          "nomor_pembayaran": "2024023389",
          "amount": "${totalpajak}",
          "method": "12",
          "kd_tagihan": "2024023389",
          "creator": "${data_QRIS['creator']}",
          "barcode": "${data_QRIS['barcode']}",
          "expired_time": "${data_QRIS['expired_time']}",
        });
        var data_numberQRIS = json.decode(response.body);
        if (data_numberQRIS == "Success") {
          //jika berhasil insert/update number QRIS di table QRIS
          print("Berhasil insert/update number QRIS di table QRIS rumahweb");
          // final batas_aktif_QRIS = DateTime.parse(data_QRIS['expired_time']);
          final batas_aktif_QRIS = DateTime.now().add(const Duration(days: 1));
          int seconds_batas_QRIS =
              batas_aktif_QRIS.difference(DateTime.now()).inSeconds;
          myDuration.value = Duration(seconds: seconds_batas_QRIS);
          barcode_qris = "${data_QRIS['barcode']}";
          isLoading = false;
          update();
        } else {
          print(
              "Gagal insert/update number QRIS di table QRIS ke API bapenda ETAM");
          isLoading = false;
          update();
        }
      } else {
        print("Gagal Create QRIS API Bankaltimtara");
        print(data_QRIS);
        isLoading = false;
        update();
      }
      //---------------------END CREATE QRIS------------------------------
    }
  }

  Future CheckPembayaran() async {
    isLoading = true;
    var url_auth = Uri.parse(
        "${URL_APP}/vaqris_dev/check_auth.php?kategori=${kategoriauth}");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 800000) {
      //jika sudah melewati masa aktif Auth yaitu 15 Menit
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "${username}", "password": "${password}"};
      var url = Uri.parse(
          "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      //memproses check status pembayaran QRIS
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Proses Auth";
        var url_update = Uri.parse(
            "${URL_APP}/vaqris_dev/update.php?kategori=${kategoriauth}");
        var response = await http.post(url_update, body: {
          "username": "${username}",
          "password": "${password}",
          "token": "${data['token']}",
        });
        var data_update = json.decode(response.body);
        if (data_update == "Success") {
          //jika berhasil perbaharui Token di table auth_vaqris Bapenda Rumahweb
          //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['token']}',
          };
          final body = {
            "kd_tagihan": "2024023389",
            "institusi": "${$id_institution_qris}"
          };
          var url = Uri.parse(
              "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/transaction/status");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_QRIS = json.decode(response.body);
          if (data_QRIS['message'] == "success") {
            //jika berhasil GET REPORT STATUS PEMBAYARAN QRIS BPD SUDAH LUNAS
            //Cek status lunas di simpatda
            print("${data_QRIS}");
            DocumentSnapshot snap = await FirebaseFirestore.instance
                .collection("UserTokens")
                .doc(authModel.nik)
                .get();
            String token = snap['token'];
            sendPushMessage(
                token,
                "QRIS telah dibayar",
                "Terima kasih, atas kepercayaan Anda menggunakan Aplikasi Bapenda Etam",
                "bayar_lunas");
            isLoading = false;
            update();
            //Proses Hit Callack
            var headers = {
              'Content-Type': 'application/json',
            };
            final body = {
              "kd_tagihan": "${data_QRIS['kd_tagihan']}",
              "institusi": "230714011",
              "bill_number": "${data_QRIS['bill_number']}",
              "trx_date": "${data_QRIS['trx_date']}",
              "rrn": "${data_QRIS['rrn']}"
            };
            var url = Uri.parse(
                "http://simpatda.bontangkita.id/simpatda/api/qrismpm/transaction/callback");
            //await http.post(url, headers: headers, body: jsonEncode(body));
            var responsecallback =
                await http.post(url, headers: headers, body: jsonEncode(body));
            var data_callback = json.decode(responsecallback.body);
            print(data_callback['message']);
            if (data_callback['message'] == "success") {
              print("success hit callback");
            }
            //End Proses Hit Callack
            print("Pembayaran Lunas");
          } else {
            //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
            print("${data_QRIS}");
            print("Gagal Perbaharui Token ke API bapenda ETAM");
            getDefaultDialog().onFix(
                title: "QRIS Belum dibayar",
                desc:
                    "Jika telah membayar namun status belum dibayar, Mohon menunggu karena Pembayaran Anda sedang dalam proses Antrian",
                kategori: "error");

            isLoading = false;
            update();
            print("Pembayaran Belum dibayar");
          }
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoading = false;
          update();
        }
      } else {
        print("Gagal Auth API Bankaltimtara");
        isLoading = false;
        update();
      }
    } else {
      print("Auth Masih Aktif, Auth Ulang");
      //memproses check status pembayaran QRIS
      print("Get Report Status Pembayaran Bankaltim");
      //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };
      final body = {
        "kd_tagihan": "2024023389",
        "institusi": "${$id_institution_qris}"
      };
      var url = Uri.parse(
          "https://api-dev.bankaltimtara.co.id:8084/api/qrismpm/transaction/status");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data_QRIS = json.decode(response.body);
      if (data_QRIS['message'] == "success") {
        //jika berhasil GET REPORT STATUS PEMBAYARAN QRIS BPD
        //Cek status lunas di simpatda
        print("${data_QRIS}");
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("UserTokens")
            .doc(authModel.nik)
            .get();
        String token = snap['token'];
        sendPushMessage(
            token,
            "QRIS telah dibayar",
            "Terima kasih, atas kepercayaan Anda menggunakan Aplikasi Bapenda Etam",
            "bayar_lunas");
        isLoading = false;
        update();

        //Proses Hit Callback
        var headers = {
          'Content-Type': 'application/json',
        };
        final body = {
          "kd_tagihan": "${data_QRIS['kd_tagihan']}",
          "institusi": "230714011",
          "bill_number": "${data_QRIS['bill_number']}",
          "trx_date": "${data_QRIS['trx_date']}",
          "rrn": "${data_QRIS['rrn']}"
        };
        var url = Uri.parse(
            "http://simpatda.bontangkita.id/simpatda/api/qrismpm/transaction/callback");
        //await http.post(url, headers: headers, body: jsonEncode(body));
        var responsecallback =
            await http.post(url, headers: headers, body: jsonEncode(body));
        var data_callback = json.decode(responsecallback.body);
        print(data_callback['message']);
        if (data_callback['message'] == "success") {
          print("success hit callback");
        }
        //End Proses Hit Callback
        print("Pembayaran Lunas");
      } else {
        //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
        print("${data_QRIS}");
        getDefaultDialog().onFix(
            title: "QRIS Belum dibayar",
            desc:
                "Jika telah membayar namun status belum dibayar, Mohon menunggu karena Pembayaran Anda sedang dalam proses Antrian",
            kategori: "error");

        isLoading = false;
        update();
        print("Pembayaran Belum dibayar");
      }
    }
  }

  final controller = ScreenshotController();
  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/QRIS_BapendaEtam.png');
    image.writeAsBytesSync(bytes);

    final text = "tes";
    await Share.shareFiles([image.path], text: text);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final name = 'QRIS BAPENDA ETAM';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    RawSnackbar_top(
        message: "QRIS telah di download, Lihat di Galeri Foto",
        kategori: "success",
        duration: 2);

    return result['filePath'];
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
