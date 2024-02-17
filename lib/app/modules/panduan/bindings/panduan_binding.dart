import 'package:get/get.dart';

import '../controllers/panduan_controller.dart';

class PanduanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanduanController>(
      () => PanduanController(),
    );
  }
}
