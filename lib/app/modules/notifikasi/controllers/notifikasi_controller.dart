import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/notifikasi/models/model_notifikasi.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotifikasiController extends GetxController {
  late AuthModel authModel;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelListNotifikasi> datalist = <ModelListNotifikasi>[].obs;
  bool hasMore = true;
  int page = 1;
  final controllerScroll = ScrollController();
  bool showFullDescription = false;

  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetch();
    controllerScroll.addListener(() {
      if (controllerScroll.position.maxScrollExtent ==
          controllerScroll.offset) {
        fetch();
        update();
      }
    });
  }

  Future fetch() async {
    if (isLoading) return;
    const limit = 10;
    final url = Uri.parse(
        '${URL_APP}/notifikasi/riwayat_notifikasi.php?nik=${authModel.nik}&page=$page&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List newItems =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      final list = newItems.map<ModelListNotifikasi>(
          (json) => ModelListNotifikasi.fromJson(json));
      page++;
      isLoading = false;

      if (newItems.length < limit) {
        hasMore = false;
        update();
      }
      datalist.addAll(list);
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
