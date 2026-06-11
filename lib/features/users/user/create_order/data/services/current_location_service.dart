import 'package:geolocator/geolocator.dart';

import '../models/location_models.dart';
import 'geocoding_service.dart';

/// خدمة جلب الموقع الحالي للعميل.
class CurrentLocationService {
  final GeocodingService _geocoding;
  CurrentLocationService(this._geocoding);

  Future<LocationModel> getCurrent() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final address = await _geocoding.addressFor(
      position.latitude,
      position.longitude,
    );
    return LocationModel(
      lat: position.latitude,
      lng: position.longitude,
      address: address,
    );
  }
}
