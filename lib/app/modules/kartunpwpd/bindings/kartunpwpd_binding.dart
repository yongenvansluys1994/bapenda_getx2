import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/kartunpwpd_controller.dart';

class KartunpwpdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KartunpwpdController>(
      () => KartunpwpdController(Get.find<Api>()),
    );
  }
}
