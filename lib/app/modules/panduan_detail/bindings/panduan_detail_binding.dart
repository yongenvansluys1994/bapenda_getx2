import 'package:get/get.dart';

import '../controllers/panduan_detail_controller.dart';

class PanduanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanduanDetailController>(
      () => PanduanDetailController(),
    );
  }
}
