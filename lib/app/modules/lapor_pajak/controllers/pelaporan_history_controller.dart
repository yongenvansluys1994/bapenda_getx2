import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class PelaporanHistoryController extends GetxController {
  Api api;
  PelaporanHistoryController(this.api);

  List<int> tahunhistory = [];
  late String jenispajak;
  late String nmassets;
  late ModelObjekku dataArgument;
  DateTime? selectedDate;

  bool isLoading = false;
  bool isEmpty = false;
  bool isEmpty2 = false;
  bool isEmpty3 = false;
  bool isEmpty4 = false;
  bool isEmpty5 = false;
  bool isFailed = false;
  RxList<ModelGetpelaporanUser> datalist = <ModelGetpelaporanUser>[].obs;
  RxList<ModelGetpelaporanUser> datalist2 = <ModelGetpelaporanUser>[].obs;
  RxList<ModelGetpelaporanUser> datalist3 = <ModelGetpelaporanUser>[].obs;
  RxList<ModelGetpelaporanUser> datalist4 = <ModelGetpelaporanUser>[].obs;
  RxList<ModelGetpelaporanUser> datalist5 = <ModelGetpelaporanUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
    jenispajak = Get.parameters['jenispajak'].toString();
    nmassets = Get.parameters['nmassets'].toString();
    int tahunSekarang = DateTime.now().year;
    for (int i = 0; i < 5; i++) {
      tahunhistory.add(
          tahunSekarang - i); //mengisi list tahunhistory 5 tahun kebelakang
    }
    init();
    update();
  }

  Future init() async {
    GetHistoryPajak(tahunhistory[0], false);
    GetHistoryPajak2(tahunhistory[1]);
    GetHistoryPajak3(tahunhistory[2]);
    GetHistoryPajak4(tahunhistory[3]);
    GetHistoryPajak5(tahunhistory[4]);

    update();
  }

  Future<void> GetHistoryPajak(int tahun, bool notiflunas) async {
    notiflunas == false
        ? EasyLoading.show(
            status: "Sedang membuat data", maskType: EasyLoadingMaskType.black)
        : null;

    try {
      isLoading = true;
      datalist
          .clear(); //dikosongkan terlebih dahulu untuk menghindari data terdouble di refresh function

      final data_mentah = await api.getPelaporanHistory(
          id_wajib_pajak: dataArgument.idWajibPajak,
          tahun: tahun,
          jenispajak:
              jenispajak); //untuk tahun 2023 //dan jenis pajak tergantung modul yg diklik
      //print(data_mentah);
      if (data_mentah == null) {
        isFailed = true;
        update();
      } else if (data_mentah.isEmpty) {
        isEmpty = true;
        update();
      } else {
        datalist.addAll(data_mentah);
        isEmpty = false;
      }

      EasyLoading.dismiss();
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
      notiflunas == false ? EasyLoading.dismiss() : null;
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
    update();
  }

  Future<void> GetHistoryPajak2(int tahun) async {
    final data_mentah = await api.getPelaporanHistory(
        id_wajib_pajak: dataArgument.idWajibPajak,
        tahun: tahun,
        jenispajak: jenispajak); //untuk tahun 2022
    if (data_mentah!.isEmpty) {
      isEmpty2 = true;
      update();
    } else {
      datalist2.addAll(data_mentah);
      update();
    }
    //print(data_mentah);

    update();
  }

  Future<void> GetHistoryPajak3(int tahun) async {
    final data_mentah = await api.getPelaporanHistory(
        id_wajib_pajak: dataArgument.idWajibPajak,
        tahun: tahun,
        jenispajak: jenispajak); //untuk tahun 2021

    if (data_mentah!.isEmpty) {
      isEmpty3 = true;
      update();
    } else {
      datalist3.addAll(data_mentah);
      update();
    }
    //print(data_mentah);

    update();
  }

  Future<void> GetHistoryPajak4(int tahun) async {
    final data_mentah = await api.getPelaporanHistory(
        id_wajib_pajak: dataArgument.idWajibPajak,
        tahun: tahun,
        jenispajak: jenispajak); //untuk tahun 2020
    //print(data_mentah);
    if (data_mentah!.isEmpty) {
      isEmpty4 = true;
      update();
    } else {
      datalist4.addAll(data_mentah);
      update();
    }
    update();
  }

  Future<void> GetHistoryPajak5(int tahun) async {
    final data_mentah = await api.getPelaporanHistory(
        id_wajib_pajak: dataArgument.idWajibPajak,
        tahun: tahun,
        jenispajak: jenispajak); //untuk tahun 2019
    //print(data_mentah);
    if (data_mentah!.isEmpty) {
      isEmpty5 = true;
      update();
    } else {
      datalist5.addAll(data_mentah);
      update();
    }
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
