import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/home_models.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded(HomeData data) = _Loaded;
}
