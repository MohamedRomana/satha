import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satha/generated/codegen_loader.g.dart';

/// يلفّ الـ widget تحت اختبار بـ EasyLocalization + ScreenUtil + MaterialApp.
/// نستخدم pump (وليس pumpAndSettle) لأن بعض الشاشات فيها أنميشن لا نهائي.
class _TestApp extends StatelessWidget {
  final Widget child;
  const _TestApp(this.child);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: (settings) =>
            MaterialPageRoute(builder: (_) => const Scaffold()),
        home: child,
      ),
    );
  }
}

Future<void> pumpApp(WidgetTester tester, Widget child) async {
  // مقاس شاشة هاتف قريب من الـ designSize عشان ScreenUtil ما يكبّر العناصر.
  tester.view.physicalSize = const Size(1125, 2436);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
  // التخلّص من الشجرة في النهاية يلغي مؤقّتات الأنميشن اللانهائي (repeat).
  addTearDown(() => tester.pumpWidget(const SizedBox.shrink()));

  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/Lang',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      saveLocale: false,
      assetLoader: const CodegenLoader(),
      child: _TestApp(child),
    ),
  );
  // إعطاء فرصة لتحميل الترجمات وبدء الأنميشن.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 150));
}
