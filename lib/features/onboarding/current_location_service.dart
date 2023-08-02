import 'package:geolocator/geolocator.dart';

class CurrentLocationService {
  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }

    try {
      Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return currentLocation;
    } catch (e) {
      print('Failed to get current location: $e');
      return null;
    }
  }

  Future<LocationPermission> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }
}
