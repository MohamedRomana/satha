import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/features/users/user/create_order/data/models/location_models.dart';
import 'package:satha/features/users/user/create_order/data/models/order_flow_models.dart';
import 'package:satha/features/users/user/orders/data/models/order_model.dart';
import 'package:satha/features/users/user/orders/ui/order_created_success_screen.dart';
import 'package:satha/features/users/user/orders/ui/order_summary_screen.dart';
import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/generated/locale_keys.g.dart';

import '../helpers/test_helpers.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  final draft = OrderModel(
    id: '',
    orderNumber: '',
    status: OrderStatus.draft,
    service: OrderServiceType.normal,
    vehicle: const VehicleModel(
      id: 'v1',
      name: 'سيارتي',
      brand: 'Toyota',
      model: 'Camry',
      year: 2023,
      color: 'أبيض',
      plateNumber: 'أ ب ج ١٢٣٤',
      chassisNumber: 'CH1',
      category: VehicleCategory.sedan,
    ),
    problem: OrderProblemType.battery,
    pickup: const LocationModel(
      lat: 24.7136,
      lng: 46.6753,
      address: 'الرياض - العليا',
    ),
    destination: const LocationModel(
      lat: 24.6877,
      lng: 46.7219,
      address: 'الرياض - الملز',
    ),
    route: const RouteInfoModel(
      distanceKm: 7.4,
      durationMin: 15,
      polyline: [LatLng(24.7136, 46.6753), LatLng(24.6877, 46.7219)],
    ),
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  testWidgets('شاشة الملخّص تعرض بيانات الطلب وزر الإرسال', (tester) async {
    await pumpApp(tester, OrderSummaryScreen(draft: draft));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(LocaleKeys.orderSummaryTitle.tr()), findsOneWidget);
    expect(find.text('سيارتي'), findsOneWidget);
    expect(find.text(LocaleKeys.confirmSendOrder.tr()), findsOneWidget);
    expect(find.text(LocaleKeys.payCash.tr()), findsOneWidget);
  });

  testWidgets('الضغط على الإرسال يفتح ديالوج التأكيد', (tester) async {
    await pumpApp(tester, OrderSummaryScreen(draft: draft));
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.text(LocaleKeys.confirmSendOrder.tr()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(LocaleKeys.sendOrderDialogTitle.tr()), findsOneWidget);
    expect(find.text(LocaleKeys.sendOrderBtn.tr()), findsOneWidget);
    expect(find.text(LocaleKeys.reviewOrderBtn.tr()), findsOneWidget);
  });

  testWidgets('شاشة النجاح تعرض رقم الطلب وأزرار المتابعة', (tester) async {
    final created = draft.copyWith(status: OrderStatus.searchingDrivers);
    final order = OrderModel(
      id: 'o1',
      orderNumber: 'ST-10251',
      status: created.status,
      service: created.service,
      vehicle: created.vehicle,
      problem: created.problem,
      pickup: created.pickup,
      destination: created.destination,
      route: created.route,
      createdAt: created.createdAt,
    );
    await pumpApp(tester, OrderCreatedSuccessScreen(order: order));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text(LocaleKeys.orderSentTitle.tr()), findsOneWidget);
    expect(find.textContaining('ST-10251'), findsOneWidget);
    expect(find.text(LocaleKeys.trackOrderBtn.tr()), findsOneWidget);
    expect(find.text(LocaleKeys.backToHomeBtn.tr()), findsOneWidget);
  });
}
