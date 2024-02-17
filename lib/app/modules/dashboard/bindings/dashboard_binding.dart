import 'package:bapenda_getx2/app/core/api/api.dart';

import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/modules/dashboard/services/dashboard_services.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(DashboardServices(
        Get.find<Api>(),
      )),
    );
  }
}
