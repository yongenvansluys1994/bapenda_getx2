import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  Location? location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location!.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location!.onLocationChanged.listen((locationData) {
          _locationStreamController.add(UserLocation(
              latitude: locationData.latitude!.toDouble(),
              longitude: locationData.longitude!.toDouble()));
        });
      }
    });
    void dispose() => _locationStreamController.close();
  }
}

class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation({required this.latitude, required this.longitude});
}
