import 'package:google_maps_flutter/google_maps_flutter.dart';

/// نقطة موقع (إحداثيات + عنوان نصّي).
class LocationModel {
  final double lat;
  final double lng;
  final String address;

  const LocationModel({
    required this.lat,
    required this.lng,
    required this.address,
  });

  LatLng get latLng => LatLng(lat, lng);

  LocationModel copyWith({double? lat, double? lng, String? address}) =>
      LocationModel(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        address: address ?? this.address,
      );
}

/// معلومات المسار بين نقطتين (mock).
class RouteInfoModel {
  final double distanceKm;
  final int durationMin;
  final List<LatLng> polyline;

  const RouteInfoModel({
    required this.distanceKm,
    required this.durationMin,
    required this.polyline,
  });
}

/// مواقع وهمية حديثة للاختيار السريع.
class RecentLocations {
  RecentLocations._();
  static const List<LocationModel> items = [
    LocationModel(lat: 24.7136, lng: 46.6753, address: 'الرياض - العليا'),
    LocationModel(lat: 24.6877, lng: 46.7219, address: 'الرياض - الملز'),
    LocationModel(lat: 21.5433, lng: 39.1728, address: 'جدة - الكورنيش'),
    LocationModel(lat: 26.4207, lng: 50.0888, address: 'الدمام - الكورنيش'),
  ];
}
