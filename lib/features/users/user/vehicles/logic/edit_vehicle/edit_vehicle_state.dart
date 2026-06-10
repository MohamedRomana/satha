import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/vehicle_model.dart';

part 'edit_vehicle_state.freezed.dart';

@freezed
class EditVehicleState with _$EditVehicleState {
  const factory EditVehicleState.changed(int tick) = _Changed;
  const factory EditVehicleState.submitting() = _Submitting;
  const factory EditVehicleState.success(VehicleModel vehicle) = _Success;
  const factory EditVehicleState.failure(String message) = _Failure;
}
