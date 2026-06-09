import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/vehicle_model.dart';
import '../../data/repos/vehicles_repository.dart';
import 'vehicles_state.dart';

/// كيوبت قائمة السيارات — تحميل/حذف/تعيين افتراضية.
class VehiclesCubit extends Cubit<VehiclesState> {
  final VehiclesRepository _repo;
  VehiclesCubit(this._repo) : super(const VehiclesState.loading());

  List<VehicleModel> vehicles = [];

  Future<void> load({bool silent = false}) async {
    if (!silent) emit(const VehiclesState.loading());
    try {
      vehicles = await _repo.getVehicles();
      if (isClosed) return;
      emit(const VehiclesState.loaded());
    } catch (e) {
      if (isClosed) return;
      emit(VehiclesState.error(e.toString()));
    }
  }

  Future<void> deleteVehicle(String id) async {
    try {
      await _repo.deleteVehicle(id);
      vehicles = await _repo.getVehicles();
      if (isClosed) return;
      emit(const VehiclesState.actionSuccess(LocaleKeys.vehicleDeletedMsg));
      emit(const VehiclesState.loaded());
    } catch (e) {
      if (isClosed) return;
      emit(VehiclesState.error(e.toString()));
    }
  }

  Future<void> setDefault(String id) async {
    try {
      await _repo.setDefault(id);
      vehicles = await _repo.getVehicles();
      if (isClosed) return;
      emit(const VehiclesState.actionSuccess(LocaleKeys.defaultVehicleSetMsg));
      emit(const VehiclesState.loaded());
    } catch (e) {
      if (isClosed) return;
      emit(VehiclesState.error(e.toString()));
    }
  }
}
