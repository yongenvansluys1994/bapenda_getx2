import 'dart:async';
import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/pelaporan_history_controller.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class VaPageController extends GetxController {
  //final pelaporanHistoryC = Get.find<PelaporanHistoryController>();
  Api api;
  VaPageController(this.api);
  late AuthModel authModel;
  late ModelGetpelaporanUser dataArgument;
  int? totalpajak;
  String $id_institution_va =
      "0292"; //4 digit id_institution khusus VA dari BPD
  Timer? countdownTimer;
  Rx<Duration> myDuration = Duration(seconds: 0).obs;
  int? detik_countdown;
  String strDigits(int n) => n.toString().padLeft(2, '0');
  String? hours;
  String? minutes;
  String? seconds;
  bool isLoading = false;
  String ket_loading = "Sedang Memproses VA";
  String virtual_account = "0";
  int maxNamaWP = 25;

  @override
  void onInit() {
    final box = GetStorage();
    var user = box.read(STORAGE_LOGIN_USER_DATA);

    authModel = AuthModel.fromJson(user);
    super.onInit();
    List<dynamic> arguments = Get.arguments;
    dataArgument = arguments[0]; //data SPT
    totalpajak = arguments[1]; //pajak
    startTimer();
    CheckVA();

    update();
  }

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

  Future CheckVA() async {
    isLoading = true;
    //fetch API CHECK VA RUMAHWEB
    var url_update = Uri.parse("${URL_APP}/vaqris/check_va.php");
    var response = await http.post(url_update, body: {
      "nomor_kohir": "${dataArgument.nomorKohir}",
    });
    List data = json.decode(response.body);
    if (data[0]["message"] == "null") {
      //jika VA belum ada/belum pernah di generate untuk nomor_kohir ini
      //Auth Untuk pertama kali
      print("VA belum ada, GO fetch AuthApiVA");
      AuthApiVA();
      update();
    } else {
      //jika no kohir sudah pernah ada di generate jadi VA
      DateTime waktuva1 = DateTime.parse(data[0]["created_at"]);
      DateTime waktuva2 = DateTime.now();
      var selisih_waktuva =
          waktuva2.millisecondsSinceEpoch - waktuva1.millisecondsSinceEpoch;
      final batas_aktif_va = waktuva1.add(const Duration(days: 1));
      int seconds_batas_va = batas_aktif_va.difference(waktuva2).inSeconds;
      myDuration.value = Duration(seconds: seconds_batas_va);

      if (selisih_waktuva > 86400000) {
        //jika sudah melewati masa aktif VA yaitu 24 Jam
        //Auth Ulang Kembali
        print(
            "VA sudah tidak aktif karena melebihi 24 jam, Go Fetch AuthApiVA");
        AuthUpdateVA();
        update();
      } else {
        //jika VA sudah ada dan masih aktif
        print("VA berhasil ditampilkan");
        virtual_account = data[0]["va"];
        isLoading = false;
        update();
      }
      update();
    }
  }

  Future AuthApiVA() async {
    isLoading = true;
    var url_auth = Uri.parse("${URL_APP}/vaqris/check_auth.php?kategori=va");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 86400000) {
      //jika sudah melewati masa aktif Auth yaitu 24 Jam
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "btgpdl23", "password": "ByrPjkBtg#23!"};
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Generate Virtual Account";
        var url_update = Uri.parse("${URL_APP}/vaqris/update.php?kategori=va");
        var response = await http.post(url_update, body: {
          "username": "btgpdl23",
          "password": "ByrPjkBtg#23!",
          "token": "${data['token']}", //token dari response Auth
        });
        var data_update = json.decode(response.body);
        if (data_update == "Success") {
          //jika berhasil perbaharui Token di table auth_vaqris Bapenda Rumahweb
          print(
              "Sukses Perbaharui Token Auth di db table auth_vaqris Bapenda ETAM");
          //create New VA
          //-------------------CREATE VA------------------------------------
          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['token']}', //token dari hasil Auth
          };
          final body = {
            "number": "${$id_institution_va}00000${dataArgument.nomorKohir}",
            "name":
                "${dataArgument.namaUsaha.length > maxNamaWP ? dataArgument.namaUsaha.substring(0, maxNamaWP) : dataArgument.namaUsaha}",
            "amount": "${totalpajak}",
            "description": "BAYAR PDL BAPENDA ETAM"
          };
          var url = Uri.parse(
              "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/create");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_VA = json.decode(response.body);
          if (data_VA['message'] == "success") {
            //jika berhasil create VA
            //insert/update number VA di table VA
            print("${data['token']}");
            print("VA berhasil dibuat di API Bankaltim1");
            ket_loading = "VA Berhasil dibuat, Mohon menunggu sebentar lagi";
            var url_update = Uri.parse("${URL_APP}/vaqris/create_va.php");
            var response = await http.post(url_update, body: {
              "nomor_kohir": "${dataArgument.nomorKohir}",
              "va": "${$id_institution_va}00000${dataArgument.nomorKohir}",
              "name":
                  "${dataArgument.namaUsaha.length > maxNamaWP ? dataArgument.namaUsaha.substring(0, maxNamaWP) : dataArgument.namaUsaha}",
              "amount": "${totalpajak}",
              "description": "BAYAR PDL BAPENDA ETAM"
            });
            var data_numberVA = json.decode(response.body);
            if (data_numberVA == "Success") {
              //jika berhasil insert/update number VA di table VA rumahweb
              print("berhasil insert/update number VA di table VA rumahweb");
              final batas_aktif_va =
                  DateTime.now().add(const Duration(days: 1));
              int seconds_batas_va =
                  batas_aktif_va.difference(DateTime.now()).inSeconds;
              myDuration.value = Duration(seconds: seconds_batas_va);
              virtual_account =
                  "${$id_institution_va}00000${dataArgument.nomorKohir}";
              isLoading = false;
              update();
            } else {
              print(
                  "Gagal insert/update number VA di table VA ke API bapenda ETAM");
              isLoading = false;
              update();
            }
            update();
          } else {
            print("Gagal Create VA API Bankaltimtara");
            print(data_VA);
            isLoading = false;
            update();
          }
          //---------------------END CREATE VA------------------------------
          update();
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoading = false;
          update();
        }
        update();
      } else {
        print(data['message']);
        print("Gagal Auth API Bankaltimtara");
        isLoading = false;
        update();
      }
      update();
    } else {
      //jika token Auth masih aktif
      print("Auth masih aktif, langsung create VA");
      ket_loading = "Sedang Generate Virtual Account";
      //-------------------CREATE VA------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${data_auth[0]["token"]}', //token dari hasil Auth
      };
      final body = {
        "number":
            "${$id_institution_va}00000${dataArgument.nomorKohir}", //10 number terakhir adalah Nomor Kohir SPT dr Bapenda
        "name":
            "${dataArgument.namaUsaha.length > maxNamaWP ? dataArgument.namaUsaha.substring(0, maxNamaWP) : dataArgument.namaUsaha}", // nama usaha dari SPT Bapenda
        "amount": "${totalpajak}", // amout/jumlah pajak dari SPT Bapenda
        "description": "BAYAR PDL BAPENDA ETAM" // description
      };
      print('${$id_institution_va}00000${dataArgument.nomorKohir}');
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/create"); //Url Create VA bankaltim
      var response = await http.post(url,
          headers: headers, body: jsonEncode(body)); //hit create api VA
      var data_VA = json
          .decode(response.body); //memanggil response hasil dari hit create VA
      if (data_VA['message'] == "success") {
        //jika berhasil create VA
        //insert/update number VA di table VA
        print(data_VA);
        print("VA berhasil dibuat di API Bankaltim");
        ket_loading = "VA Berhasil dibuat, Mohon menunggu sebentar lagi";
        var url_update = Uri.parse("${URL_APP}/vaqris/create_va.php");
        var response = await http.post(url_update, body: {
          "nomor_kohir": "${dataArgument.nomorKohir}",
          "va": "${$id_institution_va}00000${dataArgument.nomorKohir}",
          "name":
              "${dataArgument.namaUsaha.length > maxNamaWP ? dataArgument.namaUsaha.substring(0, maxNamaWP) : dataArgument.namaUsaha}",
          "amount": "${totalpajak}",
          "description": "BAYAR PDL BAPENDA ETAM"
        });
        var data_numberVA = json.decode(response.body);
        if (data_numberVA == "Success") {
          //jika berhasil insert/update number VA di table VA
          print("Berhasil insert/update number VA di table VA rumahweb");
          final batas_aktif_va = DateTime.now().add(const Duration(days: 1));
          int seconds_batas_va =
              batas_aktif_va.difference(DateTime.now()).inSeconds;
          myDuration.value = Duration(seconds: seconds_batas_va);
          virtual_account =
              "${$id_institution_va}00000${dataArgument.nomorKohir}";
          isLoading = false;
          update();
        } else {
          print(
              "Gagal insert/update number VA di table VA ke API bapenda ETAM");
          isLoading = false;
          update();
        }
        update();
      } else {
        print("Gagal Create VA API Bankaltimtara");
        print(data_VA);
        isLoading = false;
        update();
      }
      //---------------------END CREATE VA------------------------------
      update();
    }
  }

  Future AuthUpdateVA() async {
    isLoading = true;
    var url_auth = Uri.parse("${URL_APP}/vaqris/check_auth.php?kategori=va");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 86400000) {
      //jika sudah melewati masa aktif Auth yaitu 24 Jam
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "btgpdl23", "password": "ByrPjkBtg#23!"};
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Generate Virtual Account";
        var url_update = Uri.parse("${URL_APP}/vaqris/update.php?kategori=va");
        var response = await http.post(url_update, body: {
          "username": "btgpdl23",
          "password": "ByrPjkBtg#23!",
          "token": "${data['token']}", //token dari response Auth
        });

        var data_update = json.decode(response.body);
        if (data_update == "Success") {
          //jika berhasil perbaharui Token di table auth_vaqris Bapenda Rumahweb
          print(
              "Sukses Perbaharui Token Auth di db table auth_vaqris Bapenda ETAM");
          //create New VA
          //-------------------CREATE VA------------------------------------
          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['token']}', //token dari hasil Auth
          };
          final body = {
            "number": "${$id_institution_va}00000${dataArgument.nomorKohir}",
            "amount": "${totalpajak}"
          };
          var url = Uri.parse(
              "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/update");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_VA = json.decode(response.body);
          if (data_VA['message'] == "success") {
            //jika berhasil create VA
            //insert/update number VA di table VA
            print("${data['token']}");
            print("VA berhasil dibuat di API Bankaltim1");
            ket_loading = "VA Berhasil dibuat, Mohon menunggu sebentar lagi";
            var url_update = Uri.parse("${URL_APP}/vaqris/update_va.php");
            var response = await http.post(url_update, body: {
              "nomor_kohir": "${dataArgument.nomorKohir}",
              "va": "${$id_institution_va}00000${dataArgument.nomorKohir}",
              "amount": "${totalpajak}"
            });
            print(json.encode(response.body));
            var data_numberVA = json.decode(response.body);
            if (data_numberVA == "Success") {
              //jika berhasil insert/update number VA di table VA rumahweb
              print("berhasil insert/update number VA di table VA rumahweb");
              final batas_aktif_va =
                  DateTime.now().add(const Duration(days: 1));
              int seconds_batas_va =
                  batas_aktif_va.difference(DateTime.now()).inSeconds;
              myDuration.value = Duration(seconds: seconds_batas_va);
              virtual_account =
                  "${$id_institution_va}00000${dataArgument.nomorKohir}";
              isLoading = false;
              update();
            } else {
              print(
                  "Gagal insert/update number VA di table VA ke API bapenda ETAM");
              isLoading = false;
              update();
            }
            update();
          } else {
            print("Gagal Create VA API Bankaltimtara");
            print(data_VA);
            isLoading = false;
            update();
          }
          //---------------------END CREATE VA------------------------------
          update();
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoading = false;
          update();
        }
      } else {
        print(data['message']);
        print("Gagal Auth API Bankaltimtara");
        isLoading = false;
        update();
      }
      update();
    } else {
      //jika token Auth masih aktif
      print("Auth masih aktif, langsung Update VA");
      ket_loading = "Sedang Generate Virtual Account";
      //-------------------CREATE VA------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${data_auth[0]["token"]}', //token dari hasil Auth
      };
      final body = {
        "number":
            "${$id_institution_va}00000${dataArgument.nomorKohir}", //10 number terakhir adalah Nomor Kohir SPT dr Bapenda
        "amount": "${totalpajak}" // amout/jumlah pajak dari SPT Bapenda
      };
      print('${$id_institution_va}00000${dataArgument.nomorKohir}');
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/update"); //Url Create VA bankaltim
      var response = await http.post(url,
          headers: headers, body: jsonEncode(body)); //hit create api VA
      var data_VA = json
          .decode(response.body); //memanggil response hasil dari hit create VA
      if (data_VA['message'] == "success") {
        //jika berhasil create VA
        //insert/update number VA di table VA
        print(data_VA);
        print("VA berhasil di Update di API Bankaltim");
        print(dataArgument.nomorKohir);
        print("${$id_institution_va}00000${dataArgument.nomorKohir}");
        print(totalpajak);
        ket_loading = "VA Berhasil dibuat, Mohon menunggu sebentar lagi";
        var url_update = Uri.parse("${URL_APP}/vaqris/update_va.php");
        var response = await http.post(url_update, body: {
          "nomor_kohir": "${dataArgument.nomorKohir}",
          "va": "${$id_institution_va}00000${dataArgument.nomorKohir}",
          "amount": "${totalpajak}"
        });
        print(json.encode(response.body));

        var data_numberVA = json.decode(response.body);
        if (data_numberVA == "Success") {
          //jika berhasil insert/update number VA di table VA
          print("Berhasil update number VA di table VA rumahweb");
          final batas_aktif_va = DateTime.now().add(const Duration(days: 1));
          int seconds_batas_va =
              batas_aktif_va.difference(DateTime.now()).inSeconds;
          myDuration.value = Duration(seconds: seconds_batas_va);
          virtual_account =
              "${$id_institution_va}00000${dataArgument.nomorKohir}";
          isLoading = false;
          update();
        } else {
          print(
              "Gagal insert/update number VA di table VA ke API bapenda ETAM");
          isLoading = false;
          update();
        }
        update();
      } else {
        print("Gagal Create VA API Bankaltimtara");
        print(data_VA);
        isLoading = false;
        update();
      }
      //---------------------END CREATE VA------------------------------
      update();
    }
  }

  Future CheckPembayaran() async {
    isLoading = true;
    var url_auth = Uri.parse("${URL_APP}/vaqris/check_auth.php?kategori=va");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 86400000) {
      //jika sudah melewati masa aktif Auth yaitu 1 Jam
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "btgpdl23", "password": "ByrPjkBtg#23!"};
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      //memproses check status pembayaran QRIS
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Proses Auth";
        var url_update = Uri.parse("${URL_APP}/vaqris/update.php?kategori=va");
        var response = await http.post(url_update, body: {
          "username": "btgpdl23",
          "password": "ByrPjkBtg#23!",
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

          var url = Uri.parse(
              "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/nova/${$id_institution_va}00000${dataArgument.nomorKohir}");
          var response = await http.get(url, headers: headers);
          var data_VA = json.decode(response.body);
          if (data_VA['message'] == "success") {
            //jika berhasil GET REPORT STATUS PEMBAYARAN VA BPD
            //Cek status lunas di simpatda
            print("${data_VA}");
            print("GET report berhasil di API Bankaltim");
            ket_loading = "Tunggu sebentar lagi";

            DocumentSnapshot snap = await FirebaseFirestore.instance
                .collection("UserTokens")
                .doc(authModel.nik)
                .get();
            String token = snap['token'];
            sendPushMessage(
                token,
                "No. Virtual Account telah dibayar",
                "Terima kasih, atas kepercayaan Anda menggunakan Aplikasi Bapenda Etam",
                "bayar_lunas");
            isLoading = false;
            update();
            print("check status lunas di simpatda");

            //Proses Hit Callack
            var headers = {
              'Content-Type': 'application/json',
            };
            final body = {
              "number": "${data_VA['data']['number']}",
              "inst_id": "0292",
              "amount": "${data_VA['data']['amount']}",
              "date": "12121"
            };
            var url = Uri.parse(
                "http://simpatda.bontangkita.id/simpatda/api/va/transaction/callback");
            //await http.post(url, headers: headers, body: jsonEncode(body));
            var responsecallback =
                await http.post(url, headers: headers, body: jsonEncode(body));
            var data_callback = json.decode(responsecallback.body);
            print(data_callback['message']);
            if (data_callback['message'] == "success") {
              print("success hit callback");
            }
            //End Proses Hit Callback
          } else {
            getDefaultDialog().onFix(
                title: "No. Virtual Account Belum dibayar",
                desc:
                    "Jika telah membayar namun status belum dibayar, Mohon menunggu karena Pembayaran Anda sedang dalam proses Antrian",
                kategori: "error");
            isLoading = false;
            update();
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
      //memproses check status pembayaran QRIS
      print("Get Report Status Pembayaran Bankaltim");
      //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };

      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/nova/${$id_institution_va}00000${dataArgument.nomorKohir}");
      var response = await http.get(url, headers: headers);
      print(jsonEncode(response.body));
      var data_VA = json.decode(response.body);
      if (data_VA['message'] == "success") {
        //jika berhasil GET REPORT STATUS PEMBAYARAN VA BPD
        //Cek status lunas di simpatda
        //print("${data_VA}");
        print("GET report berhasil di API Bankaltim");
        ket_loading = "Tunggu sebentar lagi";
        isLoading = false;

        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("UserTokens")
            .doc(authModel.nik)
            .get();
        String token = snap['token'];
        sendPushMessage(
            token,
            "No. Virtual Account telah dibayar",
            "Terima kasih, atas kepercayaan Anda menggunakan Aplikasi Bapenda Etam",
            "bayar_lunas");
        update();
        print("lanjut check status lunas di simpatda2");

        //Proses Hit Callback
        var headers = {
          'Content-Type': 'application/json',
        };
        final body = {
          "number": "${data_VA['data']['number']}",
          "inst_id": "0292",
          "amount": "${data_VA['data']['amount']}",
          "date": "12121"
        };
        var url = Uri.parse(
            "http://simpatda.bontangkita.id/simpatda/api/va/transaction/callback");
        var responsecallback =
            await http.post(url, headers: headers, body: jsonEncode(body));
        var data_callback = json.decode(responsecallback.body);
        print(data_callback['message']);
        if (data_callback['message'] == "success") {
          print("success hit callback");
        }
        //End Proses Hit Callack
      } else {
        print("Gagal get status pembayaran BPD");
        print("${data_VA}");
        getDefaultDialog().onFix(
            title: "No. Virtual Account Belum dibayar",
            desc:
                "Jika telah membayar namun status belum dibayar, Mohon menunggu karena Pembayaran Anda sedang dalam proses Antrian",
            kategori: "error");
        isLoading = false;
        update();
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
