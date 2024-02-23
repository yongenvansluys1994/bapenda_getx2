import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Controller_Template extends GetxController {
  String ket_loading = "Sedang Memproses VA";
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  RxList<ModelObjekku> datalist = <ModelObjekku>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    FetchData();
  }

  Future<void> FetchData() async {
    try {
      isLoading = true;

      final datauser = await getData("123");

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        datalist.addAll(datauser);
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

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 25),
      receiveTimeout: Duration(seconds: 25),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<ModelObjekku>?> getData(nik) async {
    var response = await dio.get("/objekku/$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelObjekku.fromJson(e)).toList();
    } else {
      return null;
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
