import 'dart:convert';

import 'package:bapenda_getx2/core/location_service.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:get/get.dart';

class PickGooglemapsController extends GetxController {
  late GoogleMapController mapController;
  final searchController = TextEditingController();
  final googlePlace = GooglePlace(
      "AIzaSyAqNdAdaVAH0nPf6FlD4zr8-Dn1D1c-3N8"); // Replace with your API key
  final markers = <Marker>{}.obs;
  final Rx<LatLng> initialPosition =
      const LatLng(0.13707068955713855, 117.48831067227351).obs;
  final suggestions = <AutocompletePrediction>[].obs;

  // Reactive variable to track the camera's position
  final currentCameraPosition =
      const LatLng(0.13707068955713855, 117.48831067227351).obs;

  final LocationService locationService = LocationService();
  final RxBool isMapReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setInitialLocation();
  }

  void _setInitialLocation() async {
    try {
      final userLocation = await locationService.locationStream.first;
      logInfo(
          "User location: ${userLocation.latitude}, ${userLocation.longitude}");
      // Set the initial position to the user's location
      initialPosition.value =
          LatLng(userLocation.latitude, userLocation.longitude);

      // Pindahkan kamera ke lokasi pengguna
      await mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(userLocation.latitude, userLocation.longitude), 15));

      // Tandai bahwa peta siap ditampilkan
      isMapReady.value = true;
    } catch (e) {
      logError("Failed to get location: $e");
      isMapReady.value = true; // Tetap tampilkan peta meskipun gagal
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void updateCameraPosition(LatLng position) {
    currentCameraPosition.value = position;
    logInfo("Lat: ${currentCameraPosition.value.latitude}, ");
    logInfo("Lng: ${currentCameraPosition.value.longitude}, ");
  }

  Future<void> searchLocation(String query) async {
    final result = await googlePlace.search.getTextSearch(query);

    // Log specific fields instead of the entire object
    if (result != null && result.results != null) {
      logInfo("Search results: ${result.results!.map((e) => e.name).toList()}");
    } else {
      logInfo("No results found for query: $query");
    }

    if (result != null &&
        result.results != null &&
        result.results!.isNotEmpty) {
      final firstResult = result.results!.first;
      final lat = firstResult.geometry?.location?.lat;
      final lng = firstResult.geometry?.location?.lng;

      if (lat != null && lng != null) {
        final position = LatLng(lat, lng);
        mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 15));

        // Remove this line to prevent adding a marker
        // markers.add(Marker(markerId: MarkerId("search"), position: position));
      }
    }
  }

  Future<void> fetchSuggestions(String query) async {
    // Koordinat default manual (misalnya, lokasi tertentu)
    LatLng defaultLocation = LatLng(
        0.13707068955713855, 117.48831067227351); // Ganti dengan koordinat Anda
    int searchRadius = 3000; // Radius pencarian dalam meter (5 km)

    final result = await googlePlace.autocomplete.get(
      query,
      location: LatLon(defaultLocation.latitude, defaultLocation.longitude),
      radius: searchRadius, // atau sesuai kebutuhan, misalnya 5000 untuk 5 km
    );

    if (result != null && result.predictions != null) {
      suggestions.value = result.predictions!;
    } else {
      suggestions.clear();
    }
  }

  void zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }
}
