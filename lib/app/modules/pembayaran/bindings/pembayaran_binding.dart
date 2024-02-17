import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/pembayaran_controller.dart';

class PembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranController>(
      () => PembayaranController(Get.find<Api>()),
    );
  }
}
