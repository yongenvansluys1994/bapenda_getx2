import 'package:get/get.dart';

import '../controllers/ads_detail_controller.dart';

class AdsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdsDetailController>(
      () => AdsDetailController(),
    );
  }
}
