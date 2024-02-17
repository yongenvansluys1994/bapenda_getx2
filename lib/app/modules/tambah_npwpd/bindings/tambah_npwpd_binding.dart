import 'package:get/get.dart';

import '../controllers/tambah_npwpd_controller.dart';

class TambahNpwpdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahNpwpdController>(
      () => TambahNpwpdController(),
    );
  }
}
