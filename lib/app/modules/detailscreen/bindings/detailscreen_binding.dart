import 'package:get/get.dart';

import '../controllers/detailscreen_controller.dart';

class DetailscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailscreenController>(
      () => DetailscreenController(),
    );
  }
}
