import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/create_order/logic/create_order_cubit.dart';
import 'package:satha/features/users/user/create_order/ui/create_order_flow.dart';
import 'package:satha/features/users/user/create_order/ui/widgets/problem_option_card.dart';
import 'package:satha/features/users/user/create_order/ui/widgets/selectable_service_card.dart';
import 'package:satha/features/users/user/create_order/ui/widgets/step_problem.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import 'package:satha/features/users/user/vehicles/data/repos/vehicles_repository.dart';

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

  testWidgets('الخطوة 1 تعرض بطاقتي الخدمة', (tester) async {
    await pumpApp(tester, const CreateOrderFlowScreen());
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(SelectableServiceCard), findsNWidgets(2));
    expect(find.text(LocaleKeys.chooseTowType.tr()), findsOneWidget);
  });

  testWidgets('اختيار الخدمة ثم التالي ينتقل لخطوة السيارة', (tester) async {
    await pumpApp(tester, const CreateOrderFlowScreen());
    await tester.pump(const Duration(milliseconds: 700));
    await tester.tap(find.byType(SelectableServiceCard).first);
    await tester.pump();
    await tester.tap(find.text(LocaleKeys.next.tr()));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text(LocaleKeys.chooseVehicleTitle.tr()), findsOneWidget);
  });

  testWidgets('خطوة المشكلة تعرض الخيارات والاختيار يعمل', (tester) async {
    final cubit = CreateOrderCubit(getIt());
    addTearDown(cubit.close);
    await pumpApp(tester, Scaffold(body: StepProblem(cubit: cubit)));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(ProblemOptionCard), findsNWidgets(8));
    await tester.tap(find.byType(ProblemOptionCard).first);
    await tester.pump();
    expect(cubit.problem, isNotNull);
  });
}
