import 'driver_public_profile_model.dart';

/// حالة عرض السعر المقدّم من سائق.
enum OfferStatus { pending, accepted, rejected, expired, withdrawn }

/// عرض سعر مقدّم من سائق على طلب.
class OfferModel {
  final String id;
  final String orderId;
  final DriverPublicProfileModel driver;
  final num price;
  final double distanceFromCustomerKm;
  final int arrivalEstimateMin;
  final String? note;
  final OfferStatus status;
  final int countdownSec; // العدّاد التنازلي لصلاحية العرض
  final DateTime createdAt;

  const OfferModel({
    required this.id,
    required this.orderId,
    required this.driver,
    required this.price,
    required this.distanceFromCustomerKm,
    required this.arrivalEstimateMin,
    required this.status,
    required this.countdownSec,
    required this.createdAt,
    this.note,
  });

  OfferModel copyWith({OfferStatus? status}) => OfferModel(
    id: id,
    orderId: orderId,
    driver: driver,
    price: price,
    distanceFromCustomerKm: distanceFromCustomerKm,
    arrivalEstimateMin: arrivalEstimateMin,
    note: note,
    status: status ?? this.status,
    countdownSec: countdownSec,
    createdAt: createdAt,
  );
}
