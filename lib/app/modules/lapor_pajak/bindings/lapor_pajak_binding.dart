import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/lapor_pajak_controller.dart';

class LaporPajakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporPajakController>(
      () => LaporPajakController(Get.find<Api>()),
    );
  }
}
