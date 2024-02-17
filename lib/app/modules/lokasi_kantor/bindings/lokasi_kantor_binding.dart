import 'package:get/get.dart';

import '../controllers/lokasi_kantor_controller.dart';

class LokasiKantorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LokasiKantorController>(
      () => LokasiKantorController(),
    );
  }
}
