import 'package:get/get.dart';

import '../controllers/parkir_app_controller.dart';

class ParkirAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParkirAppController>(
      () => ParkirAppController(),
    );
  }
}
