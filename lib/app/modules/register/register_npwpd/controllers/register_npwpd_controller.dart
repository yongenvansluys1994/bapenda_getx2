import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/register/register_npwpd/models/modelcheck.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class RegisterNpwpdController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController npwpd = TextEditingController();
  TextEditingController npwpd2 = TextEditingController();
  TextEditingController npwpd3 = TextEditingController();
  bool isLoading = false;
  bool buttoncheck1 = false;
  bool buttoncheck2 = false;
  bool buttoncheck3 = false;
  bool hidebutton1 = false;
  bool hidebutton2 = false;
  bool hidebutton3 = false;
  //NPWPD 1
  String? npwpd_1;
  String? id_wajib_pajak_1;
  String? nama_usaha_1;
  String? alamat_usaha_1;
  String? nama_pemilik_1;
  String? alamat_pemilik_1;
  String? jenispajak_1;
  String? Kelurahan_1;
  String? Kecamatan_1;
  String? KelurahanPemilik_1;
  String? KecamatanPemilik_1;
  //NPWPD 2
  String? npwpd_2 = "";
  String id_wajib_pajak_2 = "0";
  String? nama_usaha_2 = "";
  String? alamat_usaha_2 = "";
  String? nama_pemilik_2 = "";
  String? alamat_pemilik_2 = "";
  String? jenispajak_2 = "";
  String? Kelurahan_2 = "";
  String? Kecamatan_2 = "";
  String? KelurahanPemilik_2 = "";
  String? KecamatanPemilik_2 = "";
  //NPWPD 3
  String? npwpd_3 = "";
  String id_wajib_pajak_3 = "0";
  String? nama_usaha_3 = "";
  String? alamat_usaha_3 = "";
  String? nama_pemilik_3 = "";
  String? alamat_pemilik_3 = "";
  String? jenispajak_3 = "";
  String? Kelurahan_3 = "";
  String? Kecamatan_3 = "";
  String? KelurahanPemilik_3 = "";
  String? KecamatanPemilik_3 = "";
  //TODO: Implement RegisterNpwpdController
  var maskFormatter = new MaskTextInputFormatter(
      mask: 'S.#.#######.##.##',
      filter: {"#": RegExp('[0-9]'), "S": RegExp('[Pp]')},
      type: MaskAutoCompletionType.lazy);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nama.dispose();
    nik.dispose();
    no_hp.dispose();
    password.dispose();
    npwpd.dispose();
    npwpd2.dispose();
    npwpd3.dispose();
  }

  Future<List<ModelCheck>?> checknpwpd(
      {required String buttonberapa,
      required BuildContext context,
      required TextEditingController value}) async {
    if (value.text == "") {
      RawSnackbar_bottom(
          message: "NPWPD Tidak boleh kosong", kategori: "error", duration: 2);
      update();
    } else {
      EasyLoading.show(status: 'Mencari Data...');
      var response = await http.get(Uri.parse(
          "${URL_SIMPATDA}/api_mobile2/GetDataByID/edee9b7c-b723-4990-a674-dfd6da7efdd1/" +
              npwpd.text));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      EasyLoading.dismiss();
      if (data.isEmpty) {
        RawSnackbar_bottom(
            message: "Data NPWPD Tidak ditemukan",
            kategori: "error",
            duration: 2);
        update();
      } else {
        if (buttonberapa == "1") {
          npwpd_1 = data[0]["NPWPD"];
          id_wajib_pajak_1 = data[0]["ID_WAJIB_PAJAK"].toString();
          nama_usaha_1 = data[0]["NAMA_WP"];
          alamat_usaha_1 = data[0]["ALAMAT_WP"];
          nama_pemilik_1 = data[0]["NAMA_PEMILIK"];
          alamat_pemilik_1 = data[0]["ALAMAT_PEMILIK"];
          jenispajak_1 = data[0]["URAIAN"];
          Kelurahan_1 = data[0]["NAMA_KELURAHAN"];
          Kecamatan_1 = data[0]["NAMA_KECAMATAN"];
          KelurahanPemilik_1 = data[0]["KELURAHAN_PEMILIK"];
          KecamatanPemilik_1 = data[0]["KECAMATAN_PEMILIK"];
          print(nama_usaha_1);
          buttoncheck1 = true;
          npwpd.text = data[0]["NPWPD"];
          RawSnackbar_bottom(
              message: "Data NPWPD ditemukan ",
              kategori: "success",
              duration: 2,
              data: data[0]["NAMA_WP"]);
          update();
        } else if (buttonberapa == "2") {
          npwpd_2 = data[0]["NPWPD"];
          id_wajib_pajak_2 = data[0]["ID_WAJIB_PAJAK"].toString();
          nama_usaha_2 = data[0]["NAMA_WP"];
          alamat_usaha_2 = data[0]["ALAMAT_WP"];
          nama_pemilik_2 = data[0]["NAMA_PEMILIK"];
          alamat_pemilik_2 = data[0]["ALAMAT_PEMILIK"];
          jenispajak_2 = data[0]["URAIAN"];
          Kelurahan_2 = data[0]["NAMA_KELURAHAN"];
          Kecamatan_2 = data[0]["NAMA_KECAMATAN"];
          KelurahanPemilik_2 = data[0]["KELURAHAN_PEMILIK"];
          KecamatanPemilik_2 = data[0]["KECAMATAN_PEMILIK"];
          print(nama_usaha_2);
          buttoncheck2 = true;
          npwpd2.text = data[0]["NPWPD"];
          RawSnackbar_bottom(
              message: "Data NPWPD ditemukan ",
              kategori: "success",
              duration: 2,
              data: data[0]["NAMA_WP"]);
          update();
        } else if (buttonberapa == "3") {
          npwpd_3 = data[0]["NPWPD"];
          id_wajib_pajak_3 = data[0]["ID_WAJIB_PAJAK"].toString();
          nama_usaha_3 = data[0]["NAMA_WP"];
          alamat_usaha_3 = data[0]["ALAMAT_WP"];
          nama_pemilik_3 = data[0]["NAMA_PEMILIK"];
          alamat_pemilik_3 = data[0]["ALAMAT_PEMILIK"];
          jenispajak_3 = data[0]["URAIAN"];
          Kelurahan_3 = data[0]["NAMA_KELURAHAN"];
          Kecamatan_3 = data[0]["NAMA_KECAMATAN"];
          KelurahanPemilik_3 = data[0]["KELURAHAN_PEMILIK"];
          KecamatanPemilik_3 = data[0]["KECAMATAN_PEMILIK"];
          print(nama_usaha_3);
          buttoncheck3 = true;
          npwpd3.text = data[0]["NPWPD"];
          RawSnackbar_bottom(
              message: "Data NPWPD ditemukan ",
              kategori: "success",
              duration: 2,
              data: data[0]["NAMA_WP"]);
          update();
        }

        // setState(() {s
        //   Valuejenispajak = data[0]["URAIAN"];
        // });
      }
      return null;
    }
    update();
    return null;
  }

  void btntambah() {
    if (hidebutton1 == false) {
      hidebutton1 = !hidebutton1;
    } else if (hidebutton2 == false) {
      hidebutton2 = !hidebutton2;
    } else if (hidebutton3 == false) {
      hidebutton3 = !hidebutton3;
    }
    update();
  }

  void btnX() {
    if (hidebutton3 == true) {
      hidebutton3 = !hidebutton3;
      npwpd3.clear();
    } else if (hidebutton2 == true) {
      hidebutton2 = !hidebutton2;
      npwpd2.clear();
    } else if (hidebutton1 == true) {
      hidebutton1 = !hidebutton1;
      npwpd.clear();
    }
    update();
  }

  void saveData() async {
    if (formKey.currentState!.validate()) {
      if (npwpd.text.isNotEmpty && buttoncheck1 == false ||
          npwpd2.text.isNotEmpty && buttoncheck2 == false ||
          npwpd3.text.isNotEmpty && buttoncheck3 == false) {
        RawSnackbar_top(
          message:
              "Klik Check NPWPD terlebih dahulu, untuk memastikan NPWPD Tersedia",
          kategori: "Error",
          duration: 2,
        );
      } else {
        if (npwpd.text.isNotEmpty && buttoncheck1 == true) {
          startRegister();
          print("Daftar dengan NPWPD");
        } else {
          getDefaultDialog().onConfirmWithoutIcon(
            title: "Apakah anda yakin tidak memiliki NPWPD?",
            desc:
                "Jika memiliki NPWPD, tambahkan NPWPD lalu klik Daftar kembali",
            handler: () {
              startRegisterNew();
              print("Daftar Baru");
            },
          );
        }
      }
    } else {
      RawSnackbar_bottom(
        message: "Terdapat Form yang belum diisi!",
        kategori: "error",
        duration: 2,
      );
      update();
    }
    update();
  }

  void startRegister() async {
    EasyLoading.show();
    // API disini
    var url = Uri.parse("${baseUrl}/login/register.php");
    var response = await http.post(url, body: {
      "nama": nama.text.toString(),
      "nik": nik.text.toString(),
      "no_hp": no_hp.text.toString(),
      "password": password.text.toString(),
      //npwpd1
      "npwpd_1": npwpd_1,
      "id_wajib_pajak_1": id_wajib_pajak_1,
      "nama_usaha_1": nama_usaha_1,
      "alamat_usaha_1": alamat_usaha_1,
      "nama_pemilik_1": nama_pemilik_1,
      "alamat_pemilik_1": alamat_pemilik_1,
      "jenispajak_1": jenispajak_1,
      "kel_usaha_1": Kelurahan_1,
      "kec_usaha_1": Kecamatan_1,
      "kel_pemilik_1": KelurahanPemilik_1,
      "kec_pemilik_1": KecamatanPemilik_1,
      //npwpd2
      "npwpd_2": npwpd_2,
      "id_wajib_pajak_2": id_wajib_pajak_2,
      "nama_usaha_2": nama_usaha_2,
      "alamat_usaha_2": alamat_usaha_2,
      "nama_pemilik_2": nama_pemilik_2,
      "alamat_pemilik_2": alamat_pemilik_2,
      "jenispajak_2": jenispajak_2,
      "kel_usaha_2": Kelurahan_2,
      "kec_usaha_2": Kecamatan_2,
      "kel_pemilik_2": KelurahanPemilik_2,
      "kec_pemilik_2": KecamatanPemilik_2,
      //npwpd3
      "npwpd_3": npwpd_3,
      "id_wajib_pajak_3": id_wajib_pajak_3,
      "nama_usaha_3": nama_usaha_3,
      "alamat_usaha_3": alamat_usaha_3,
      "nama_pemilik_3": nama_pemilik_3,
      "alamat_pemilik_3": alamat_pemilik_3,
      "jenispajak_3": jenispajak_3,
      "kel_usaha_3": Kelurahan_3,
      "kec_usaha_3": Kecamatan_3,
      "kel_pemilik_3": KelurahanPemilik_3,
      "kec_pemilik_3": KecamatanPemilik_3,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      RawSnackbar_top(
        message: "NIK yang anda daftarkan sudah terdaftar!",
        kategori: "Error",
        duration: 3,
      );
      update();
    } else if (data == "SudahAda") {
      RawSnackbar_top(
        message:
            "NPWPD No.1 yang anda daftarkan telah terdaftar diaplikasi, Silahkan hubungi Admin",
        kategori: "Error",
        duration: 3,
      );
      update();
    } else if (data == "SudahAda_2") {
      RawSnackbar_top(
        message:
            "NPWPD No.2 yang anda daftarkan telah terdaftar diaplikasi, Silahkan hubungi Admin",
        kategori: "Error",
        duration: 3,
      );
      update();
    } else if (data == "SudahAda_3") {
      RawSnackbar_top(
        message:
            "NPWPD No.3 yang anda daftarkan telah terdaftar diaplikasi, Silahkan hubungi Admin",
        kategori: "Error",
        duration: 3,
      );
      update();
    } else {
      RawSnackbar_bottom(
        message: "Registration Successful",
        kategori: "success",
        duration: 3,
      );
      Get.offAllNamed(Routes.LOGIN);
      update();
    }
    EasyLoading.dismiss();
    update();
  }

  void startRegisterNew() async {
    EasyLoading.show();
    // API disini
    var url = Uri.parse("${baseUrl}/login/register.php");
    var response = await http.post(url, body: {
      "nama": nama.text.toString(),
      "nik": nik.text.toString(),
      "no_hp": no_hp.text.toString(),
      "password": password.text.toString(),
    });
    print(json.decode(response.body));
    var data = json.decode(response.body);
    if (data == "Error") {
      RawSnackbar_top(
        message: "NIK yang anda daftarkan sudah terdaftar!",
        kategori: "Error",
        duration: 3,
      );
      update();
    } else {
      RawSnackbar_bottom(
        message: "Registration Successful",
        kategori: "success",
        duration: 3,
      );
      Get.offAllNamed(Routes.LOGIN);
      update();
    }
    EasyLoading.dismiss();
    update();
  }
}
