import 'package:get/get.dart';

import '../controllers/qrispbb_controller.dart';

class QrispbbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrispbbController>(
      () => QrispbbController(),
    );
  }
}
