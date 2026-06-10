import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/logic/add_vehicle/add_vehicle_cubit.dart';
import 'package:satha/features/users/user/vehicles/logic/add_vehicle/add_vehicle_state.dart';
import 'package:satha/features/users/user/vehicles/logic/edit_vehicle/edit_vehicle_cubit.dart';

void main() {
  group('AddVehicleCubit', () {
    test('الإرسال بدون صورة يفشل بطلب الصورة', () async {
      final cubit = AddVehicleCubit(MockVehiclesRepository());
      await cubit.submit();
      final failed = cubit.state.maybeWhen(
        failure: (_) => true,
        orElse: () => false,
      );
      expect(failed, isTrue);
      cubit.close();
    });

    test('ضبط القيم يحدّث حالة الكيوبت', () {
      final cubit = AddVehicleCubit(MockVehiclesRepository());
      cubit.setImage(File('x.png'));
      cubit.setBrand('Toyota');
      cubit.setYear(2024);
      cubit.setColor('أبيض');
      cubit.setCategory(VehicleCategory.suv);
      cubit.toggleDefault(true);
      expect(cubit.image, isNotNull);
      expect(cubit.brand, 'Toyota');
      expect(cubit.year, 2024);
      expect(cubit.category, VehicleCategory.suv);
      expect(cubit.isDefault, isTrue);
      cubit.close();
    });
  });

  group('EditVehicleCubit', () {
    test('يملأ الحقول من السيارة الأصلية', () {
      const vehicle = VehicleModel(
        id: 'v9',
        name: 'سيارة اختبار',
        brand: 'Kia',
        model: 'Sportage',
        year: 2020,
        color: 'أحمر',
        plateNumber: 'س ص ع ٤٤٤',
        chassisNumber: 'CHTEST9',
        category: VehicleCategory.hatchback,
        isDefault: true,
      );
      final cubit = EditVehicleCubit(MockVehiclesRepository(), vehicle);
      expect(cubit.nameController.text, 'سيارة اختبار');
      expect(cubit.brand, 'Kia');
      expect(cubit.modelController.text, 'Sportage');
      expect(cubit.year, 2020);
      expect(cubit.color, 'أحمر');
      expect(cubit.plateController.text, 'س ص ع ٤٤٤');
      expect(cubit.chassisController.text, 'CHTEST9');
      expect(cubit.category, VehicleCategory.hatchback);
      expect(cubit.isDefault, isTrue);
      cubit.close();
    });
  });
}
