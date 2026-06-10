import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/data/repos/vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/logic/add_vehicle/add_vehicle_cubit.dart';
import 'package:satha/features/users/user/vehicles/ui/add_vehicle_screen.dart';
import 'package:satha/features/users/user/vehicles/ui/customer_vehicles_screen.dart';
import 'package:satha/features/users/user/vehicles/ui/edit_vehicle_screen.dart';
import 'package:satha/features/users/user/vehicles/ui/widgets/vehicle_card.dart';
import 'package:satha/features/users/user/vehicles/ui/widgets/vehicle_form_fields.dart';

import '../helpers/test_helpers.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    if (!getIt.isRegistered<VehiclesRepository>()) {
      getIt.registerLazySingleton<VehiclesRepository>(
        () => MockVehiclesRepository(),
      );
    }
  });

  testWidgets('شاشة السيارات تعرض بطاقات السيارات', (tester) async {
    await pumpApp(tester, const CustomerVehiclesScreen());
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(VehicleCard), findsNWidgets(3));
  });

  testWidgets('فورم التعديل يملأ البيانات مسبقًا', (tester) async {
    const vehicle = VehicleModel(
      id: 'v9',
      name: 'سيارة اختبار',
      brand: 'Kia',
      model: 'Sportage',
      year: 2020,
      color: 'أحمر',
      plateNumber: 'PLATE-9',
      chassisNumber: 'CHASSIS-9',
      category: VehicleCategory.hatchback,
    );
    await pumpApp(tester, const EditVehicleScreen(vehicle: vehicle));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('سيارة اختبار'), findsWidgets);
    expect(find.text('PLATE-9'), findsWidgets);
    expect(find.text('CHASSIS-9'), findsWidgets);
  });

  testWidgets('فورم الإضافة يُظهر أخطاء التحقق', (tester) async {
    await pumpApp(tester, const AddVehicleScreen());
    await tester.pump(const Duration(milliseconds: 200));
    // ضبط صورة لتجاوز فحص الصورة ثم تشغيل التحقق على الحقول مباشرة.
    final ctx = tester.element(find.byType(VehicleFormFields));
    final cubit = ctx.read<AddVehicleCubit>();
    cubit.setImage(File('x.png'));
    await tester.pump();
    cubit.submit();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text(LocaleKeys.vehNameRequired.tr()), findsWidgets);
  });
}
