import 'package:geolocator/geolocator.dart';

/// نتيجة طلب إذن الموقع.
enum LocationPermissionStatus { granted, denied, deniedForever, servicesDisabled }

/// خدمة إدارة إذن الموقع (geolocator).
class LocationPermissionService {
  Future<LocationPermissionStatus> ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionStatus.servicesDisabled;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionStatus.deniedForever;
    }
    if (permission == LocationPermission.denied) {
      return LocationPermissionStatus.denied;
    }
    return LocationPermissionStatus.granted;
  }

  Future<bool> openAppSettings() => Geolocator.openAppSettings();
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}
