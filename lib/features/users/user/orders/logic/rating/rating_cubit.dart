import 'package:flutter_bloc/flutter_bloc.dart';

import 'rating_state.dart';

/// كيوبت تقييم السائق (إرسال وهمي).
class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(const RatingState.idle());

  int stars = 0;
  String comment = '';

  void setStars(int value) {
    stars = value;
    if (state is! RatingIdle) emit(const RatingState.idle());
  }

  Future<void> submit() async {
    if (stars <= 0) {
      emit(const RatingState.error('no_stars'));
      return;
    }
    emit(const RatingState.submitting());
    await Future.delayed(const Duration(milliseconds: 700));
    if (isClosed) return;
    emit(const RatingState.success());
  }
}
