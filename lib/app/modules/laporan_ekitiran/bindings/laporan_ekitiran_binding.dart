import 'package:get/get.dart';

import '../controllers/laporan_ekitiran_controller.dart';

class LaporanEkitiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanEkitiranController>(
      () => LaporanEkitiranController(),
    );
  }
}
