import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/offer_model.dart';

part 'offers_state.freezed.dart';

@freezed
class OffersState with _$OffersState {
  const factory OffersState.loading() = OffersLoading;
  const factory OffersState.loaded(int tick) = OffersLoaded;
  const factory OffersState.error(String message) = OffersError;
  const factory OffersState.accepting() = OffersAccepting;
  const factory OffersState.accepted(OfferModel offer) = OffersAccepted;
  const factory OffersState.actionError(String message) = OffersActionError;
}
