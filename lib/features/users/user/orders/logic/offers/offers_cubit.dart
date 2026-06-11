import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/offer_model.dart';
import '../../data/models/order_model.dart';
import '../../data/repos/offers_repository.dart';
import '../../data/repos/orders_repository.dart';
import 'offers_state.dart';

/// كيوبت شاشة العروض — يحمّل العروض ويدير العدّاد التنازلي والقبول/الرفض.
class OffersCubit extends Cubit<OffersState> {
  final OffersRepository _offersRepo;
  final OrdersRepository _ordersRepo;
  final String orderId;

  OffersCubit(this._offersRepo, this._ordersRepo, this.orderId)
    : super(const OffersState.loading());

  OrderModel? order;
  List<OfferModel> offers = [];
  final Map<String, int> _remaining = {};
  Timer? _timer;
  int _tick = 0;

  /// العروض المعروضة (المعلّقة وغير المنتهية فقط).
  List<OfferModel> get visibleOffers => offers
      .where((o) => o.status == OfferStatus.pending && remainingFor(o.id) > 0)
      .toList();

  int remainingFor(String offerId) => _remaining[offerId] ?? 0;

  Future<void> load() async {
    emit(const OffersState.loading());
    try {
      order = await _ordersRepo.getById(orderId);
      offers = await _offersRepo.getOffers(orderId);
      for (final o in offers) {
        _remaining[o.id] = o.countdownSec;
      }
      if (isClosed) return;
      emit(OffersState.loaded(_tick++));
      _startTimer();
    } catch (e) {
      if (isClosed) return;
      emit(OffersState.error(e.toString()));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      var changed = false;
      for (final o in offers) {
        if (o.status != OfferStatus.pending) continue;
        final r = _remaining[o.id] ?? 0;
        if (r > 0) {
          _remaining[o.id] = r - 1;
          changed = true;
        }
      }
      if (changed && !isClosed) emit(OffersState.loaded(_tick++));
    });
  }

  Future<void> acceptOffer(String offerId) async {
    emit(const OffersState.accepting());
    try {
      final accepted = await _offersRepo.acceptOffer(offerId);
      offers = await _offersRepo.getOffers(orderId);
      _timer?.cancel();
      if (isClosed) return;
      emit(OffersState.accepted(accepted));
    } catch (e) {
      if (isClosed) return;
      emit(OffersState.actionError(e.toString()));
      emit(OffersState.loaded(_tick++));
    }
  }

  Future<void> rejectOffer(String offerId) async {
    try {
      await _offersRepo.rejectOffer(offerId);
      offers = await _offersRepo.getOffers(orderId);
      if (isClosed) return;
      emit(OffersState.loaded(_tick++));
    } catch (e) {
      if (isClosed) return;
      emit(OffersState.actionError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
