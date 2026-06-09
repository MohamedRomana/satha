import '../models/vehicle_model.dart';
import 'vehicles_repository.dart';

/// مستودع سيارات وهمي في الذاكرة (mock) — يحاكي CRUD بتأخير بسيط.
class MockVehiclesRepository implements VehiclesRepository {
  final List<VehicleModel> _vehicles = [
    const VehicleModel(
      id: 'v1',
      name: 'سيارتي الأساسية',
      brand: 'Toyota',
      model: 'Camry',
      year: 2023,
      color: 'أبيض',
      plateNumber: 'أ ب ج ١٢٣٤',
      chassisNumber: 'JTNB11HK1P3000001',
      category: VehicleCategory.sedan,
      isDefault: true,
    ),
    const VehicleModel(
      id: 'v2',
      name: 'سيارة العائلة',
      brand: 'Hyundai',
      model: 'Santa Fe',
      year: 2022,
      color: 'أسود',
      plateNumber: 'د هـ و ٥٦٧٨',
      chassisNumber: 'KM8SRDHF7NU000002',
      category: VehicleCategory.suv,
    ),
    const VehicleModel(
      id: 'v3',
      name: 'سيارة العمل',
      brand: 'Ford',
      model: 'Ranger',
      year: 2021,
      color: 'رمادي',
      plateNumber: 'ط ي ك ٩٨٧٦',
      chassisNumber: 'MNCUMFF50MW000003',
      category: VehicleCategory.pickup,
    ),
  ];

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 500));

  int _counter = 100;

  @override
  Future<List<VehicleModel>> getVehicles() async {
    await _delay();
    // الافتراضية أولاً.
    final list = [..._vehicles];
    list.sort((a, b) => (b.isDefault ? 1 : 0) - (a.isDefault ? 1 : 0));
    return list;
  }

  @override
  Future<VehicleModel> addVehicle(VehicleModel vehicle) async {
    await _delay();
    final created = vehicle.copyWith(id: 'v${_counter++}');
    if (created.isDefault || _vehicles.isEmpty) {
      _setDefaultInternal(created.id, addIfMissing: created);
    } else {
      _vehicles.add(created);
    }
    return created;
  }

  @override
  Future<VehicleModel> updateVehicle(VehicleModel vehicle) async {
    await _delay();
    final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) _vehicles[index] = vehicle;
    if (vehicle.isDefault) _setDefaultInternal(vehicle.id);
    return vehicle;
  }

  @override
  Future<void> deleteVehicle(String id) async {
    await _delay();
    final wasDefault = _vehicles.any((v) => v.id == id && v.isDefault);
    _vehicles.removeWhere((v) => v.id == id);
    // لو حذفنا الافتراضية نعيّن الأولى افتراضية.
    if (wasDefault && _vehicles.isNotEmpty) {
      _setDefaultInternal(_vehicles.first.id);
    }
  }

  @override
  Future<void> setDefault(String id) async {
    await _delay();
    _setDefaultInternal(id);
  }

  void _setDefaultInternal(String id, {VehicleModel? addIfMissing}) {
    for (var i = 0; i < _vehicles.length; i++) {
      _vehicles[i] = _vehicles[i].copyWith(isDefault: _vehicles[i].id == id);
    }
    if (addIfMissing != null && !_vehicles.any((v) => v.id == id)) {
      _vehicles.add(addIfMissing.copyWith(isDefault: true));
    }
  }
}
