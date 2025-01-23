import 'package:get/get.dart';

import '../controllers/ekitiran_controller.dart';

class EkitiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EkitiranController>(
      () => EkitiranController(),
    );
  }
}
