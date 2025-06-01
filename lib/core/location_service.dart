import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<UserLocation?> getCurrentLocation() async {
    try {
      // Pastikan layanan lokasi aktif
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          print("❌ Layanan lokasi tidak diaktifkan.");
          return null;
        }
      }

      // Cek dan minta izin
      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
      }

      if (permission != PermissionStatus.granted) {
        print("❌ Izin lokasi tidak diberikan.");
        return null;
      }

      // Ambil lokasi dengan timeout agar tidak hang selamanya
      final locationData = await _location.getLocation().timeout(
        Duration(seconds: 8),
        onTimeout: () {
          throw Exception("Timeout ambil lokasi.");
        },
      );

      if (locationData.latitude == null || locationData.longitude == null) {
        print("❌ Lokasi null.");
        return null;
      }

      return UserLocation(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
    } catch (e) {
      print("❌ Error getLocation: $e");
      return null;
    }
  }
}

class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation({required this.latitude, required this.longitude});
}
