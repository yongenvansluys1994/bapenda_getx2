import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LupaPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController no_hp = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool isLoading = false;
  bool buttonKirim = true;
  bool show_newPassword = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> lupaPassword() async {
    //Awal Loading Disini-------------------------------
    EasyLoading.show(status: 'Mencari Data...');
    var response =
        await http.post(Uri.parse("${URL_APP}/login/lupa_password.php"), body: {
      "nik": nik.text.toString(),
      "no_hp": no_hp.text.toString(),
    });
    var data = json.decode(response.body);
    EasyLoading.dismiss();
    if (data == "nik_tidakada") {
      getDefaultDialog().onFix(
          title: "NIK Tidak ditemukan pada akun manapun",
          desc: "Pastikan anda mengisi NIK dengan benar, atau hubungi Admin",
          kategori: "error");

      update();
    } else if (data == "data_tidakcocok") {
      getDefaultDialog().onFix(
          title: "NIK & No.HP Tidak cocok",
          desc:
              "NIK & No.HP Tidak cocok seperti data saat pendaftaran, atau hubungi Admin",
          kategori: "error");
      update();
    } else {
      getDefaultDialog().onFix(
          title: "NIK & No.hp Anda sesuai",
          desc:
              "Silahkan membuat Password Baru untuk masuk kedalam Bapenda Etam",
          kategori: "success");
      buttonKirim = false;
      show_newPassword = true;

      update();
    }
  }

  Future<void> simpanNewPassword() async {
    if (formKey.currentState!.validate()) {
      //Awal Loading Disini-------------------------------
      EasyLoading.show();
      var response = await http
          .post(Uri.parse("${URL_APP}/login/new_password.php"), body: {
        "nik": '${nik.text}',
        "newpassword": '${newPassword.text}',
      });
      print(response.body);
      var data = json.decode(response.body);
      EasyLoading.dismiss();
      if (data == "Success") {
        RawSnackbar_bottom(
          message: "Berhasil menyimpan password baru",
          kategori: "success",
          duration: 3,
        );
        Get.offAllNamed(Routes.LOGIN);
        update();
      } else {
        RawSnackbar_bottom(
          message: "Gagal menyimpan password baru",
          kategori: "error",
          duration: 3,
        );

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
