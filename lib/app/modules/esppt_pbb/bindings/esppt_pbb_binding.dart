import 'package:get/get.dart';

import '../controllers/esppt_pbb_controller.dart';

class EspptPbbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EspptPbbController>(
      () => EspptPbbController(),
    );
  }
}
