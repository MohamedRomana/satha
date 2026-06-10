import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/vehicle_model.dart';

part 'add_vehicle_state.freezed.dart';

@freezed
class AddVehicleState with _$AddVehicleState {
  const factory AddVehicleState.changed(int tick) = _Changed;
  const factory AddVehicleState.submitting() = _Submitting;
  const factory AddVehicleState.success(VehicleModel vehicle) = _Success;
  const factory AddVehicleState.failure(String message) = _Failure;
}
