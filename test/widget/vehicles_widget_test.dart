import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/data/repos/vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/ui/customer_vehicles_screen.dart';
import 'package:satha/features/users/user/vehicles/ui/widgets/vehicle_card.dart';

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
    // انتظار تحميل القائمة (mock delay 500ms).
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(VehicleCard), findsNWidgets(3));
  });
}
