import 'dart:convert';
import 'package:bapenda_getx2/app/modules/pick_googlemaps/models/autocomplete_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:bapenda_getx2/core/location_service.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class PickGooglemapsController extends GetxController {
  GoogleMapController? mapController; // Aman dari crash
  final searchController = TextEditingController();

  final markers = <Marker>{}.obs;
  final Rx<LatLng> initialPosition =
      const LatLng(0.13707068955713855, 117.48831067227351).obs;
  final Rx<LatLng> currentCameraPosition =
      const LatLng(0.13707068955713855, 117.48831067227351).obs;
  final suggestions = <AutocompletePrediction>[].obs;

  final RxBool isMapReady = false.obs;

  final LocationService locationService = LocationService();
  final String apiKey =
      "AIzaSyAqNdAdaVAH0nPf6FlD4zr8-Dn1c-3N8"; // Ganti dengan milikmu

  @override
  void onInit() {
    super.onInit();
    // Jangan ambil lokasi di sini, karena mapController belum siap
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setInitialLocation(); // Panggil setelah controller siap
  }

  void updateCameraPosition(LatLng position) {
    currentCameraPosition.value = position;
    logInfo("Camera position updated: $position");
  }

  Future<void> _setInitialLocation() async {
    logInfo("Mulai ambil lokasi...");

    try {
      final userLocation = await locationService.getCurrentLocation();

      if (userLocation == null) {
        logError("Gagal dapatkan lokasi: hasil null");
        isMapReady.value = true;
        return;
      }

      initialPosition.value = LatLng(
        userLocation.latitude,
        userLocation.longitude,
      );

      if (mapController != null) {
        await mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(initialPosition.value, 15),
        );
      } else {
        logError("MapController belum siap saat animasi kamera");
      }

      logInfo("Berhasil dapat lokasi: ${initialPosition.value}");
    } catch (e) {
      logError("Gagal mendapatkan lokasi: $e");
    } finally {
      isMapReady.value = true;
      print("Map siap");
    }
  }

  void _showPermissionDeniedDialog() {
    Get.defaultDialog(
      title: "Izin Lokasi Diperlukan",
      middleText: "Silakan aktifkan izin lokasi secara manual di Pengaturan.",
      textConfirm: "Buka Pengaturan",
      textCancel: "Batal",
      onConfirm: () {
        openAppSettings(); // dari package permission_handler
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  Future<void> fetchSuggestions(String query) async {
    final defaultLocation = const LatLng(
      0.13707068955713855,
      117.48831067227351,
    );
    final searchRadius = 3000;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=${Uri.encodeComponent(query)}'
      '&location=${defaultLocation.latitude},${defaultLocation.longitude}'
      '&radius=$searchRadius'
      '&key=$apiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(jsonEncode(data));
        final predictions = data['predictions'] as List<dynamic>;

        suggestions.value = predictions
            .map((item) => AutocompletePrediction.fromJson(item))
            .toList();
      } else {
        logError("Google Places API error: ${response.statusCode}");
        suggestions.clear();
      }
    } catch (e) {
      logError("Failed to fetch suggestions: $e");
      suggestions.clear();
    }
  }

  Future<void> searchLocation(String query) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/textsearch/json'
      '?query=${Uri.encodeComponent(query)}'
      '&key=$apiKey',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;

        if (results.isNotEmpty) {
          final firstResult = results.first;
          final location = firstResult['geometry']['location'];
          final lat = location['lat'] as double;
          final lng = location['lng'] as double;

          final position = LatLng(lat, lng);
          await mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(position, 15),
          );

          logInfo("Search result: ${firstResult['name']} at $lat, $lng");
        } else {
          logInfo("No results found for query: $query");
        }
      } else {
        logError("Google Text Search API error: ${response.statusCode}");
      }
    } catch (e) {
      logError("Failed to search location: $e");
    }
  }
}
