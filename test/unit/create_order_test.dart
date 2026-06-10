import 'package:flutter_test/flutter_test.dart';

import 'package:satha/features/users/user/create_order/data/models/order_flow_models.dart';
import 'package:satha/features/users/user/create_order/logic/create_order_cubit.dart';
import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';

void main() {
  const sampleVehicle = VehicleModel(
    id: 'v1',
    name: 'سيارة',
    brand: 'Toyota',
    model: 'Camry',
    year: 2023,
    color: 'أبيض',
    plateNumber: 'أ ب ج',
    chassisNumber: 'CH1',
    category: VehicleCategory.sedan,
  );

  group('CreateOrderCubit draft & validation', () {
    test('لا يمكن المتابعة بدون اختيار الخدمة', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      expect(cubit.canProceed(0), isFalse);
      cubit.selectService(OrderServiceType.normal);
      expect(cubit.canProceed(0), isTrue);
      cubit.close();
    });

    test('لا يمكن المتابعة بدون اختيار السيارة', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      cubit.vehicle = null; // تجاوز الاختيار التلقائي
      expect(cubit.canProceed(1), isFalse);
      cubit.selectVehicle(sampleVehicle);
      expect(cubit.canProceed(1), isTrue);
      cubit.close();
    });

    test('لا يمكن المتابعة بدون اختيار المشكلة، ويتم حفظ الاختيار', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      expect(cubit.canProceed(2), isFalse);
      cubit.selectProblem(OrderProblemType.accident);
      expect(cubit.canProceed(2), isTrue);
      expect(cubit.problem, OrderProblemType.accident);
      cubit.close();
    });

    test('المسودّة محفوظة عبر الاختيارات', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      cubit.selectService(OrderServiceType.hydraulic);
      cubit.selectVehicle(sampleVehicle);
      cubit.selectProblem(OrderProblemType.tire);
      expect(cubit.service, OrderServiceType.hydraulic);
      expect(cubit.vehicle?.id, 'v1');
      expect(cubit.problem, OrderProblemType.tire);
      cubit.close();
    });

    test('إضافة صور المشكلة محدودة بأربعة', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      expect(cubit.problemImages, isEmpty);
      cubit.close();
    });
  });
}
