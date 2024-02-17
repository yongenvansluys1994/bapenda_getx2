import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/ppid_controller.dart';

class PpidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PpidController>(
      () => PpidController(Get.find<Api>()),
    );
  }
}
