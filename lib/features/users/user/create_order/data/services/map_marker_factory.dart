import 'package:google_maps_flutter/google_maps_flutter.dart';

/// مصنع علامات الخريطة (بداية برتقالي / وصول navy / الموقع الحالي أزرق).
class MapMarkerFactory {
  MapMarkerFactory._();

  static Marker pickup(LatLng position) => Marker(
    markerId: const MarkerId('pickup'),
    position: position,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    infoWindow: const InfoWindow(title: 'نقطة البداية'),
  );

  static Marker destination(LatLng position) => Marker(
    markerId: const MarkerId('destination'),
    position: position,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: const InfoWindow(title: 'نقطة الوصول'),
  );

  static Marker current(LatLng position) => Marker(
    markerId: const MarkerId('current'),
    position: position,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );
}
