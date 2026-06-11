import 'package:geocoding/geocoding.dart';

/// تحويل الإحداثيات إلى عنوان نصّي (مع fallback آمن).
class GeocodingService {
  Future<String> addressFor(double lat, double lng) async {
    try {
      // مهلة حتى لا تتعلّق العملية لو خدمة الـ geocoding بطيئة/غير متاحة.
      final placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      ).timeout(const Duration(seconds: 5));
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [p.street, p.subLocality, p.locality, p.administrativeArea]
            .where((e) => e != null && e.trim().isNotEmpty)
            .cast<String>()
            .toList();
        if (parts.isNotEmpty) return parts.take(3).join('، ');
      }
    } catch (_) {
      // تجاهل — نرجّع الإحداثيات كـ fallback.
    }
    return '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
  }
}
