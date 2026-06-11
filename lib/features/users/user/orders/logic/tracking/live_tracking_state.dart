import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_tracking_state.freezed.dart';

@freezed
class LiveTrackingState with _$LiveTrackingState {
  const factory LiveTrackingState.loading() = LiveTrackingLoading;
  const factory LiveTrackingState.tracking(int tick) = LiveTrackingActive;
  const factory LiveTrackingState.error(String message) = LiveTrackingError;
}
