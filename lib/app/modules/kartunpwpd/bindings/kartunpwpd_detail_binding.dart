import 'package:get/get.dart';

import '../controllers/kartunpwpd_detail_controller.dart';

class KartunpwpdDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KartunpwpdDetailController>(
      () => KartunpwpdDetailController(),
    );
  }
}
