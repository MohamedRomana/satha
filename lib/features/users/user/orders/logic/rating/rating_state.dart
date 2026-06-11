import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_state.freezed.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState.idle() = RatingIdle;
  const factory RatingState.submitting() = RatingSubmitting;
  const factory RatingState.success() = RatingSuccess;
  const factory RatingState.error(String message) = RatingError;
}
