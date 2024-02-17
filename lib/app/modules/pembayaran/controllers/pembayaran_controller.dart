import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  Api api;
  PembayaranController(this.api);

  late AuthModel authModel;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelObjekku> datalist2 = <ModelObjekku>[].obs;
  RxList list_id_wajib_pajak = [].obs;

  RxList<ModelGetpelaporanUser> datalist = <ModelGetpelaporanUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    getPajak().then((value) => fetchSPT());
    update();
  }

  Future<void> getPajak() async {
    try {
      isLoading = true;

      final datauser = await api.getData(authModel.nik);

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        datalist2.addAll(datauser);
        isEmpty = false;
        list_id_wajib_pajak.addAll(datalist2.map((obj) => obj.idWajibPajak));
        print(jsonEncode(list_id_wajib_pajak));
        //print(jsonEncode(list_id_wajib_pajak.reversed.toList()));
      }

      isLoading = false;
      update();
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
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
  }

  Future<void> fetchSPT() async {
    List list_wajibpajak = list_id_wajib_pajak.toList();
    try {
      isLoading = true;

      final data = await api.getSPTPembayaran(list_wajibpajak);

      if (data == null) {
        isFailed = true;
      } else if (data.isEmpty) {
        isEmpty = true;
      } else {
        datalist.addAll(data);
        isEmpty = false;
      }

      isLoading = false;
      update();
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
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
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
