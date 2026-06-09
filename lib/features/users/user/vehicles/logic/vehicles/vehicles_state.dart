import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_state.freezed.dart';

@freezed
class VehiclesState with _$VehiclesState {
  const factory VehiclesState.loading() = _Loading;
  const factory VehiclesState.loaded() = _Loaded;
  const factory VehiclesState.actionLoading() = _ActionLoading;
  const factory VehiclesState.actionSuccess(String message) = _ActionSuccess;
  const factory VehiclesState.error(String message) = _Error;
}
