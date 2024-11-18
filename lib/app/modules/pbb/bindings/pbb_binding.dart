import 'package:get/get.dart';

import '../controllers/pbb_controller.dart';

class PbbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PbbController>(
      () => PbbController(),
    );
  }
}
