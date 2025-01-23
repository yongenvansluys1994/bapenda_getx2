import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EkitiranController extends GetxController {
  late AuthModel authModel;
  final TextEditingController userrt_kecamatan = TextEditingController();
  final TextEditingController userrt_kelurahan = TextEditingController();
  final TextEditingController userrt_rt = TextEditingController();

  final List<String> kecamatanList = [
    'Bontang Utara',
    'Bontang Selatan',
    'Bontang Barat',
  ];
  List<String> availableKelurahan =
      []; // Kelurahan yang tersedia berdasarkan Kecamatan
  final Map<String, List<String>> kelurahanByKecamatan = {
    'Bontang Barat': [
      'Belimbing',
      'Kanaan',
      'Telihan',
    ],
    'Bontang Selatan': [
      'Berbas Pantai',
      'Berbas Tengah',
      'Bontang Lestari',
      'Satimpo',
      'Tanjung Laut',
      'Tanjung Laut Indah',
    ],
    'Bontang Utara': [
      'Api-Api',
      'Bontang Baru',
      'Bontang Kuala',
      'Guntung',
      'Gunung Elai',
      'Lok Tuan',
    ],
  };

  @override
  void onInit() {
    super.onInit();
    availableKelurahan = []; // Awalnya kosong
    authModel = Get.arguments;
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

  void ProsesData() async {
    EasyLoading.show();
    // API disini
    var url = Uri.parse("${URL_APPSIMPATDA}/ekitiran/user_rt_input.php");
    var response = await http.post(url, body: {
      "id_userwp": "${authModel.idUserwp}",
      "kecamatan": "${userrt_kecamatan.text}",
      "kelurahan": "${userrt_kelurahan.text}",
      "rt": "${userrt_rt.text}",
    });

    var data = json.decode(response.body);

    if (data['success'] != null) {
      RawSnackbar_bottom(
        message: "${data['success']}",
        kategori: "success",
        duration: 3,
      );
      update();
    } else {
      RawSnackbar_top(
        message: "Gagal, terjadi gangguin di jaringan.",
        kategori: "Error",
        duration: 3,
      );
      update();
    }
    EasyLoading.dismiss();
    update();
  }

  void changeValue_userrt_kecamatan(String? newValue) {
    userrt_kecamatan.text = newValue!;
    availableKelurahan = kelurahanByKecamatan[newValue] ?? [];
    userrt_kelurahan.text = "";
    userrt_rt.text = "";
    update();
  }

  void changeValue_userrt_kelurahan(String? newValue) {
    userrt_kelurahan.text = newValue!;
    update();
  }

  void changeValue_userrt_rt(String? newValue) {
    userrt_rt.text = newValue!;
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
