import 'review_model.dart';
import 'tow_truck_model.dart';

/// الملف العام للسائق (يُعرض للعميل).
class DriverPublicProfileModel {
  final String id;
  final String name;
  final String? imagePath;
  final bool verified;
  final double rating;
  final int reviewsCount;
  final int completedTrips;
  final int platformMonths; // مدة وجوده على المنصّة بالأشهر
  final String phone;
  final TowTruckModel towTruck;
  final String? bio;
  final List<ReviewModel> reviews;

  const DriverPublicProfileModel({
    required this.id,
    required this.name,
    required this.verified,
    required this.rating,
    required this.reviewsCount,
    required this.completedTrips,
    required this.platformMonths,
    required this.phone,
    required this.towTruck,
    this.imagePath,
    this.bio,
    this.reviews = const [],
  });
}
