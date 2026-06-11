import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/features/users/user/create_order/ui/widgets/location_permission_view.dart';

import '../helpers/test_helpers.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('واجهة إذن الموقع (fallback) تُعرض مع الأزرار', (tester) async {
    var allowed = false;
    var manual = false;
    await pumpApp(
      tester,
      LocationPermissionView(
        message: 'تحتاج إذن الموقع',
        primaryLabel: 'السماح',
        onPrimary: () => allowed = true,
        onManual: () => manual = true,
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(LocationPermissionView), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    // زر "تحديد يدويًا" هو الـ TextButton.
    await tester.tap(find.byType(TextButton));
    expect(manual, isTrue);
    expect(allowed, isFalse);
  });
}
