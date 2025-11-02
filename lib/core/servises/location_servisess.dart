import 'package:location/location.dart';

class LocationServisess {
  Location location = Location();

  // chackEnableLocationAndService
  Future<void> _chackEnableLocationAndService() async {
    var isLocationEnabled = await location.serviceEnabled();

    if (!isLocationEnabled) {
      isLocationEnabled = await location.requestService();
      if (!isLocationEnabled) {
        throw LocationServisessException("Location is not enabled");
      }
    }
  }

  // chackEnablePermission

  Future<void> _chackEnablePermission() async {
    var permessionStatus = await location.hasPermission();
    if (permessionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException(
        "Location permission is permanently denied, we cannot request permissions.",
      );
    }

    if (permessionStatus == PermissionStatus.denied) {
      permessionStatus = await location.requestPermission();
      if (permessionStatus != PermissionStatus.granted) {
        throw LocationPermissionException("Location permission is denied");
      }
    }
  }

  Future<LocationData> getlocation() async {
    await _chackEnableLocationAndService();
    await _chackEnablePermission();
    return await location.getLocation();
  }
}

class LocationServisessException implements Exception {
  final String message;
  LocationServisessException(this.message);

  @override
  String toString() => message;
}

class LocationPermissionException implements Exception {
  final String message;
  LocationPermissionException(this.message);

  @override
  String toString() => message;
}
