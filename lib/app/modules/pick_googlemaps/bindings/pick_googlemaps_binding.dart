import 'package:get/get.dart';

import '../controllers/pick_googlemaps_controller.dart';

class PickGooglemapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickGooglemapsController>(
      () => PickGooglemapsController(),
    );
  }
}
