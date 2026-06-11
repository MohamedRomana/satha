import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_locations_state.freezed.dart';

@freezed
class SelectLocationsState with _$SelectLocationsState {
  const factory SelectLocationsState.loading() = _Loading;
  const factory SelectLocationsState.permissionDenied(bool forever) =
      _PermissionDenied;
  const factory SelectLocationsState.servicesDisabled() = _ServicesDisabled;
  const factory SelectLocationsState.ready(int tick) = _Ready;
  const factory SelectLocationsState.error(String message) = _Error;
}
