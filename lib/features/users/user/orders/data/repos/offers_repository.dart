import '../models/offer_model.dart';

/// واجهة مستودع العروض.
abstract class OffersRepository {
  /// عروض طلب معيّن (تُولَّد عند أول طلب إن لم تكن موجودة).
  Future<List<OfferModel>> getOffers(String orderId);

  /// قبول عرض: يُعلَّم مقبولًا، وتُرفض باقي العروض، ويُحدَّث الطلب.
  Future<OfferModel> acceptOffer(String offerId);

  /// رفض عرض واحد.
  Future<void> rejectOffer(String offerId);
}
