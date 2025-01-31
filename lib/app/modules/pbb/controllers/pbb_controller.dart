import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/pbb/models/model_pbb.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class PbbController extends GetxController {
  String ket_loading = "Sedang Memproses";
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  TextEditingController nop = TextEditingController();
  Rx<ModelPbbInformasi> dataInformasi = ModelPbbInformasi(
    namaWp: '',
    alamatWp: '',
    kelurahanWp: '',
    kecamatanOp: '',
    kelurahanOp: '',
    alamatOp: '',
  ).obs;
  bool isError = false;
  String message = "";
  RxList<ModelPbbSppt> datalist = <ModelPbbSppt>[].obs;

  var maskFormatter = MaskTextInputFormatter(
    mask: '##.##.###.###.###.####.#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading = true;
    isError = false;
    update();

    final String url =
        'https://dev-b.invinicsoft.com/sismiop/api/informasi/piutang/${nop.text}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (!jsonData['is_error']) {
          dataInformasi.value =
              ModelPbbInformasi.fromJson(jsonData['data']['informasi']);

          List<ModelPbbSppt> tempList = (jsonData['data']['sppt'] as List)
              .map((sppt) => ModelPbbSppt.fromJson(sppt))
              .toList();

          datalist.value = tempList;
          message = jsonData['message'];
        } else {
          isError = true;
          message = jsonData['message'] ?? "Terjadi kesalahan.";
        }
      } else {
        isError = true;
        message = "Gagal terhubung ke server. Kode: ${response.statusCode}";
      }
    } catch (e) {
      isError = true;
      message = "Kesalahan koneksi: $e";
    } finally {
      isLoading = false;
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
