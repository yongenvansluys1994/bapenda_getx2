import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../controllers/pick_googlemaps_controller.dart';

class PickGooglemapsView extends GetView<PickGooglemapsController> {
  const PickGooglemapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Search'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.initialPosition.value,
                zoom: 15,
              ),
              mapType: MapType.normal,
              markers: controller.markers.toSet(),
              onCameraMove: (position) {
                controller.updateCameraPosition(position.target);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            );
          }),

          /// Loading Overlay
          Obx(() {
            return controller.isMapReady.value
                ? SizedBox.shrink()
                : Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            "Sedang memuat lokasi...",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
          // Marker in the center of the screen
          Obx(() {
            // Tampilkan peta hanya jika isMapReady bernilai true
            if (controller.isMapReady.value) {
              return Center(
                child: Transform.translate(
                  offset: const Offset(
                    0,
                    -25,
                  ), // Geser ke atas sebesar 25 piksel
                  child: Icon(Icons.location_pin, size: 50, color: Colors.red),
                ),
              );
            } else {
              // Tampilkan indikator loading sementara
              return Container();
            }
          }),

          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                // Ambil lokasi yang dipilih dari currentCameraPosition
                final selectedLocation = controller.currentCameraPosition.value;

                // Kirim nilai lat dan lng ke screen sebelumnya
                Get.back(
                  result: {
                    'lat': selectedLocation.latitude,
                    'lng': selectedLocation.longitude,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Tetapkan Pilihan Lokasi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          decoration: const InputDecoration(
                            hintText: "Telusuri Alamat",
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.searchLocation(value);
                            }
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              print("Searching for: $value");
                              controller.fetchSuggestions(value);
                            } else {
                              controller.suggestions.clear();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final query = controller.searchController.text;
                          if (query.isNotEmpty) {
                            controller.searchLocation(query);
                            dismissKeyboard();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.suggestions.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.suggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = controller.suggestions[index];
                              return ListTile(
                                title: Text(suggestion.description ?? ""),
                                onTap: () {
                                  controller.searchController.text =
                                      suggestion.description ?? "";
                                  controller.searchLocation(
                                    suggestion.description ?? "",
                                  );
                                  controller.suggestions.clear();
                                  dismissKeyboard();
                                },
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
