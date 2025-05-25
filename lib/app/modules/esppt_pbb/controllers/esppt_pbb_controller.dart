import 'dart:convert';

import 'package:bapenda_getx2/app/modules/pbb/models/model_pbb.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:get/get.dart';

class EspptPbbController extends GetxController {
  late ModelPbbSppt dataArgument;
  var spptItem = <ModelPbbSppt>[].obs;
  String? nomor_pembayaran;
  int? totalpajak;
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    dataArgument = arguments[0] as ModelPbbSppt;
    nomor_pembayaran = dataArgument.nopthn;
    totalpajak = int.parse(dataArgument.jumlahHarusBayar);
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
