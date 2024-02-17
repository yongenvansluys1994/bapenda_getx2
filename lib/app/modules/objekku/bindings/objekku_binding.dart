import 'package:get/get.dart';

import '../controllers/objekku_controller.dart';

class ObjekkuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjekkuController>(
      () => ObjekkuController(),
    );
  }
}
