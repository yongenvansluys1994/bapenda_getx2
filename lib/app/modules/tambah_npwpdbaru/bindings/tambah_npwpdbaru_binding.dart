import 'package:get/get.dart';

import '../controllers/tambah_npwpdbaru_controller.dart';

class TambahNpwpdbaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahNpwpdbaruController>(
      () => TambahNpwpdbaruController(),
    );
  }
}
