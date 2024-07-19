import 'package:get/get.dart';

import '../controllers/objekku_detail_controller.dart';

class ObjekkuDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjekkuDetailController>(
      () => ObjekkuDetailController(),
    );
  }
}
