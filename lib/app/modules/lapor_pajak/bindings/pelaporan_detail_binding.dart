import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/pelaporan_history_controller.dart';
import 'package:get/get.dart';

import '../controllers/pelaporan_detail_controller.dart';

class PelaporanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PelaporanDetailController>(
      () => PelaporanDetailController(Get.find<Api>()),
    );
    Get.lazyPut<PelaporanHistoryController>(
      () => PelaporanHistoryController(Get.find<Api>()),
    );
  }
}
