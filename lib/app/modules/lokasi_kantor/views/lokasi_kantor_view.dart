import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/lokasi_kantor_controller.dart';

class LokasiKantorView extends GetView<LokasiKantorController> {
  const LokasiKantorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: "Lokasi Kantor", leading: true, isLogin: true),
      body: GetBuilder<LokasiKantorController>(
        init: LokasiKantorController(),
        builder: (controller) {
          return Container(
            height: 720.h,
            color: Colors.white,
            child: GoogleMap(
              markers: controller.markers,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(controller.lat, controller.lng),
                zoom: 19,
              ),
              onMapCreated: (GoogleMapController controllers) {
                controller.addMarkers();
              },
            ),
          );
        },
      ),
    );
  }
}
