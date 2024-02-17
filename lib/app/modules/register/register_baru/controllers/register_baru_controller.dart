import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterBaruController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

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
  }

  void saveData() async {
    if (formKey.currentState!.validate()) {
      startRegister();
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
    });
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
