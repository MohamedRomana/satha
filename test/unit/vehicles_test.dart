import 'package:flutter_test/flutter_test.dart';

import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/logic/vehicles/vehicles_cubit.dart';

void main() {
  group('MockVehiclesRepository CRUD', () {
    test('يبدأ بثلاث سيارات والافتراضية أولاً', () async {
      final repo = MockVehiclesRepository();
      final list = await repo.getVehicles();
      expect(list.length, 3);
      expect(list.first.isDefault, isTrue);
    });

    test('إضافة سيارة تزيد العدد', () async {
      final repo = MockVehiclesRepository();
      await repo.addVehicle(
        const VehicleModel(
          id: '',
          name: 'جديدة',
          brand: 'Kia',
          model: 'Sportage',
          year: 2024,
          color: 'أزرق',
          plateNumber: 'ل م ن ١١١',
          chassisNumber: 'CH0001',
          category: VehicleCategory.suv,
        ),
      );
      final list = await repo.getVehicles();
      expect(list.length, 4);
    });

    test('حذف سيارة يعمل', () async {
      final repo = MockVehiclesRepository();
      await repo.deleteVehicle('v2');
      final list = await repo.getVehicles();
      expect(list.length, 2);
      expect(list.any((v) => v.id == 'v2'), isFalse);
    });

    test('تعيين سيارة افتراضية يعمل', () async {
      final repo = MockVehiclesRepository();
      await repo.setDefault('v2');
      final list = await repo.getVehicles();
      final def = list.firstWhere((v) => v.isDefault);
      expect(def.id, 'v2');
      expect(list.where((v) => v.isDefault).length, 1);
    });

    test('حذف الافتراضية يعيّن أخرى افتراضية', () async {
      final repo = MockVehiclesRepository();
      await repo.deleteVehicle('v1'); // v1 هي الافتراضية
      final list = await repo.getVehicles();
      expect(list.where((v) => v.isDefault).length, 1);
    });
  });

  group('VehiclesCubit', () {
    test('load يملأ القائمة', () async {
      final cubit = VehiclesCubit(MockVehiclesRepository());
      await cubit.load();
      expect(cubit.vehicles.length, 3);
      cubit.close();
    });

    test('deleteVehicle ينقص القائمة', () async {
      final cubit = VehiclesCubit(MockVehiclesRepository());
      await cubit.load();
      await cubit.deleteVehicle('v3');
      expect(cubit.vehicles.length, 2);
      cubit.close();
    });

    test('setDefault يغيّر الافتراضية', () async {
      final cubit = VehiclesCubit(MockVehiclesRepository());
      await cubit.load();
      await cubit.setDefault('v2');
      expect(cubit.vehicles.firstWhere((v) => v.isDefault).id, 'v2');
      cubit.close();
    });
  });
}
