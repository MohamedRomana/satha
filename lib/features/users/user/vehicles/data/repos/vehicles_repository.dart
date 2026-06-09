import '../models/vehicle_model.dart';

/// واجهة مستودع السيارات — تُستبدل بالـ API الحقيقي لاحقًا.
abstract class VehiclesRepository {
  Future<List<VehicleModel>> getVehicles();
  Future<VehicleModel> addVehicle(VehicleModel vehicle);
  Future<VehicleModel> updateVehicle(VehicleModel vehicle);
  Future<void> deleteVehicle(String id);
  Future<void> setDefault(String id);
}
