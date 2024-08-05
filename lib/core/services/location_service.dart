import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxController {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      return Future.error('Location services are disabled.');
    }

    // 2. Request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 3. Get current location

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      _currentPosition = position;
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location.');
      print('Error getting location: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distanceInKm =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
    return distanceInKm;
  }
}
