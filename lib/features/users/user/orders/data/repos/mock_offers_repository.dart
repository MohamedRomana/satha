import '../../../create_order/data/models/order_flow_models.dart';
import '../models/driver_public_profile_model.dart';
import '../models/offer_model.dart';
import '../models/order_model.dart';
import '../models/review_model.dart';
import '../models/tow_truck_model.dart';
import 'orders_repository.dart';
import 'offers_repository.dart';

/// مستودع عروض وهمي في الذاكرة.
class MockOffersRepository implements OffersRepository {
  MockOffersRepository(this._ordersRepo);

  final OrdersRepository _ordersRepo;

  /// عروض مخزّنة لكل طلب.
  final Map<String, List<OfferModel>> _byOrder = {};

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 400));

  @override
  Future<List<OfferModel>> getOffers(String orderId) async {
    await _delay();
    _byOrder[orderId] ??= _seedFor(orderId);
    return List.unmodifiable(_byOrder[orderId]!);
  }

  @override
  Future<OfferModel> acceptOffer(String offerId) async {
    await _delay();
    final entry = _locate(offerId);
    final orderId = entry.key;
    final offers = _byOrder[orderId]!;
    OfferModel accepted = offers.first;
    for (var i = 0; i < offers.length; i++) {
      final o = offers[i];
      if (o.id == offerId) {
        accepted = o.copyWith(status: OfferStatus.accepted);
        offers[i] = accepted;
      } else if (o.status == OfferStatus.pending) {
        offers[i] = o.copyWith(status: OfferStatus.rejected);
      }
    }
    // تحديث الطلب.
    final order = await _ordersRepo.getById(orderId);
    if (order != null) {
      await _ordersRepo.updateOrder(
        order.copyWith(
          status: OrderStatus.offerAccepted,
          acceptedPrice: accepted.price,
          driverName: accepted.driver.name,
        ),
      );
    }
    return accepted;
  }

  @override
  Future<void> rejectOffer(String offerId) async {
    await _delay();
    final entry = _locate(offerId);
    final offers = _byOrder[entry.key]!;
    final i = offers.indexWhere((o) => o.id == offerId);
    if (i != -1) {
      offers[i] = offers[i].copyWith(status: OfferStatus.rejected);
    }
  }

  MapEntry<String, OfferModel> _locate(String offerId) {
    for (final e in _byOrder.entries) {
      for (final o in e.value) {
        if (o.id == offerId) return MapEntry(e.key, o);
      }
    }
    throw StateError('offer $offerId not found');
  }

  // ---- توليد عروض وهمية ----
  List<OfferModel> _seedFor(String orderId) {
    final base = DateTime.fromMillisecondsSinceEpoch(0);
    return [
      OfferModel(
        id: '$orderId-of1',
        orderId: orderId,
        driver: _drivers[0],
        price: 150,
        distanceFromCustomerKm: 2.3,
        arrivalEstimateMin: 8,
        note: 'جاهز للوصول إليك حالًا.',
        status: OfferStatus.pending,
        countdownSec: 120,
        createdAt: base,
      ),
      OfferModel(
        id: '$orderId-of2',
        orderId: orderId,
        driver: _drivers[1],
        price: 175,
        distanceFromCustomerKm: 3.8,
        arrivalEstimateMin: 12,
        status: OfferStatus.pending,
        countdownSec: 100,
        createdAt: base,
      ),
      OfferModel(
        id: '$orderId-of3',
        orderId: orderId,
        driver: _drivers[2],
        price: 140,
        distanceFromCustomerKm: 5.1,
        arrivalEstimateMin: 16,
        note: 'سطحة هيدروليك مناسبة للسيارات المنخفضة.',
        status: OfferStatus.pending,
        countdownSec: 90,
        createdAt: base,
      ),
    ];
  }

  static final List<DriverPublicProfileModel> _drivers = [
    DriverPublicProfileModel(
      id: 'd1',
      name: 'خالد العتيبي',
      verified: true,
      rating: 4.9,
      reviewsCount: 312,
      completedTrips: 540,
      platformMonths: 26,
      phone: '0501234567',
      bio: 'سائق سطحة محترف بخبرة واسعة في إنقاذ ونقل السيارات.',
      towTruck: const TowTruckModel(
        type: OrderServiceType.normal,
        name: 'سطحة مرسيدس آكتروس',
        plateNumber: 'ر س ط ٤٥٢١',
      ),
      reviews: [
        ReviewModel(
          id: 'r1',
          customerName: 'سعود',
          rating: 5,
          comment: 'سريع ومحترف، وصل قبل الوقت المتوقع.',
          date: DateTime.fromMillisecondsSinceEpoch(1700000000000),
        ),
        ReviewModel(
          id: 'r2',
          customerName: 'منى',
          rating: 4.5,
          comment: 'تعامل راقٍ وخدمة ممتازة.',
          date: DateTime.fromMillisecondsSinceEpoch(1699000000000),
        ),
      ],
    ),
    const DriverPublicProfileModel(
      id: 'd2',
      name: 'فهد الدوسري',
      verified: true,
      rating: 4.7,
      reviewsCount: 188,
      completedTrips: 301,
      platformMonths: 14,
      phone: '0537654321',
      towTruck: TowTruckModel(
        type: OrderServiceType.normal,
        name: 'سطحة إيسوزو',
        plateNumber: 'ب د و ٧٧١٢',
      ),
      reviews: [],
    ),
    const DriverPublicProfileModel(
      id: 'd3',
      name: 'ماجد القحطاني',
      verified: false,
      rating: 4.5,
      reviewsCount: 96,
      completedTrips: 142,
      platformMonths: 7,
      phone: '0559988776',
      towTruck: TowTruckModel(
        type: OrderServiceType.hydraulic,
        name: 'سطحة هيدروليك فولفو',
        plateNumber: 'ق ح ط ٣٣٤٥',
      ),
      reviews: [],
    ),
  ];
}
