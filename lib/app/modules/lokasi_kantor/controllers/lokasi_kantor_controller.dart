import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorController extends GetxController {
  late AuthModel authModel;
  final double lat = 0.136855982849828;
  final double lng = 117.48833025663617;
  Set<Marker> markers = <Marker>{};

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
  }

  void addMarkers() {
    var latm = double.parse('${lat}');
    var longm = double.parse('${lng}');
    markers = <Marker>{
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latm, longm),
      ),
    };
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
