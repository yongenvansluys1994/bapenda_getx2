import 'dart:convert';

import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/panduan/models/model_panduan.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PanduanController extends GetxController {
  late AuthModel authModel;
  var panduans = <PanduanModel>[].obs;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchPanduans();
    update();
  }

  Future<void> fetchPanduans() async {
    try {
      isLoading = true;
      final response = await http
          .get(Uri.parse('https://simpatda.bontangkita.id/api_ver2/panduan/'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        panduans.value = data.map((e) => PanduanModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Gagal mengambil data");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat mengambil data");
    } finally {
      isLoading = false;
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
