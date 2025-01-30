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

  Future<void> FetchData() async {
    try {
      isLoading = true;
      EasyLoading.show(status: "Mencari Data");

      final datauser = await get_PBB(nop.text); // Fetch data from API

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        // Now no need for the '!' operator since dataInformasi is always initialized
        EasyLoading.dismiss();
        if (datauser["isError"]) {
          isError = datauser["isError"];
          message = datauser["message"];
          datalist.clear();
          getDefaultDialog().onFix(
              title: message,
              desc: "Isi kembali kolom pencarian NOP dengan benar",
              kategori: "warning");
        } else {
          EasyLoading.showSuccess("Data NOP ditemukan!");
          isError = datauser["isError"];
          message = datauser["message"];
          dataInformasi.value = datauser["informasi"] as ModelPbbInformasi;

          datalist.clear();
          datalist.addAll(datauser["sppt"] as List<ModelPbbSppt>);

          isEmpty = false;
        }
      }

      isLoading = false;
      update(); // Notify GetX to update UI
    } on DioError catch (ex) {
      var errorMessage = "";
      if (ex.type == DioErrorType.connectionTimeout ||
          ex.type == DioErrorType.connectionError ||
          ex.type == DioErrorType.receiveTimeout ||
          ex.type == DioErrorType.sendTimeout) {
        errorMessage = "Limit Connection, Koneksi anda bermasalah";
      } else {
        errorMessage = "$ex";
      }
      update(); // Update the UI with error state
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
