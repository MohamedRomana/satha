# سطحة (Sat7a) — المرحلة الأولى

تطبيق Flutter لخدمات إنقاذ ونقل السيارات (السطحات). هذه **المرحلة الأولى** تشمل
الأساس الاحترافي للمشروع: Splash متحرّك، Onboarding، اختيار الدور، ومنظومة مصادقة
كاملة لثلاثة أدوار (عميل / سائق / مسؤول إدارة) — كلها تعمل ببيانات وهمية (Mock)
بدون باك إند، مع بنية جاهزة للربط بالـ API لاحقًا.

> الصفحات الرئيسية، الطلبات، الخرائط، المحادثات، ولوحة تحكم الإدارة **ليست** ضمن هذه
> المرحلة — يتم استبدالها مؤقتًا بشاشات وجهة نظيفة توضّح نجاح الدخول حسب الدور.

---

## 1) نظرة عامة

- **البراند:** Navy / Orange، خط Tajawal، شعار شفّاف، أنميشن premium بطابع automotive.
- **اللغة الافتراضية:** العربية مع دعم RTL كامل + ملفات إنجليزية جاهزة (LTR).
- **المعمارية:** Feature-First + Cubit (BLoC) + حالات Freezed، حسب conventions مشروع
  `delivery (Get Go)`.

## 2) المميزات المنفّذة في هذه المرحلة

- شاشة **Splash** متحرّكة متعددة المراحل (شعار + خط طريق برتقالي + نبضة ضوء + توهّج +
  مؤشّر تحميل) ثم توجيه تلقائي للوجهة المناسبة.
- **Onboarding** من 3 صفحات بمشاهد متحرّكة (سطحة على الطريق، اختيار نوع السطحة، تتبّع
  المسار) + مؤشّر صفحات متحرّك + تخطّي/التالي/ابدأ الآن.
- **اختيار الدور** ببطاقات متحرّكة (عميل / سائق) + رابط دخول الإدارة.
- **مصادقة العميل:** تسجيل دخول، إنشاء حساب (مع صورة اختيارية ومؤشّر قوة كلمة المرور
  والموافقة على الشروط)، نسيان كلمة المرور، OTP، إعادة تعيين كلمة المرور.
- **مصادقة السائق:** تسجيل دخول + تسجيل **متعدد الخطوات** (بيانات شخصية، بيانات السطحة،
  رفع المستندات، مراجعة) + شاشة "قيد المراجعة". السائق لا يدخل إلا بعد الموافقة.
- **مصادقة الإدارة:** شاشة دخول رسمية (إيميل + كلمة مرور).
- **حُرّاس مسارات (Route Guards):** كل دور لا يصل لشاشة دور آخر؛ الجلسة المخزّنة تعيد
  التوجيه التلقائي عند إعادة التشغيل؛ الخروج يمسح الجلسة ويمنع الرجوع للشاشات المحمية.

## 3) متطلّبات الـ SDK

- Flutter **3.38.x** (مُختبر على 3.38.5) — Dart **3.10.x**.
- Material 3 + Null safety.

## 4) بنية المجلدات

```
lib/
├── main.dart                      # نقطة الدخول (EasyLocalization + ScreenUtil + AppRouter)
├── core/
│   ├── cache/cache_helper.dart    # تخزين الجلسة/الأونبوردنق (SharedPreferences)
│   ├── constants/                 # colors.dart · gradients.dart · app_constants.dart
│   ├── di/dependancy_injection.dart
│   ├── helper/                    # extentions.dart · validators.dart
│   ├── networking/                # dio_factory · api_result(Freezed) · api_error_model · ...
│   ├── routing/                   # routes.dart · app_router.dart (راوتر مركزي)
│   └── widgets/                   # AppLogo · PrimaryButton · SathaField · PasswordField · OTP ...
├── features/                      # البنية حسب CLAUDE.md (start / auth subfeatures / users)
│   ├── start/                     # splash · on_boarding · role_selection
│   ├── auth/
│   │   ├── data/                  # apis (Retrofit) · models (JsonSerializable) · datasources (mock) · repos · auth_session  (مشترك)
│   │   ├── widgets/               # widgets مشتركة (auth_scaffold, otp_input, terms_sheet, ...)
│   │   ├── login/                 # logic (Cubit+Freezed) + ui
│   │   ├── customer_register/     # logic + ui
│   │   ├── driver_register/       # logic + ui (+ ui/widgets خطوات التسجيل)
│   │   ├── forgot_password/ · otp/ · reset_password/
│   │   ├── admin_login/ui · driver_register_pending/ui
│   └── users/                     # user/ (عميل) · provider/ (سائق) · admin/ · shared/  (شاشات الوجهة)
├── gen/                           # flutter_gen (assets/fonts)
└── generated/                     # easy_localization codegen (locale_keys + codegen_loader)
```

## 5) إضافة الشعار الشفّاف

الشعار مُستخدم من `assets/img/logo.png` (PNG شفّاف بدون خلفية بيضاء). لاستبداله:
ضع شعارك في نفس المسار `assets/img/logo.png` ثم شغّل توليد الأصول:

```bash
dart run build_runner build --delete-conflicting-outputs
```

(يُولّد `lib/gen/assets.gen.dart` → يُستخدم عبر `Assets.img.logo`.)

## 6) تثبيت الحِزم والتشغيل

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

> **ملاحظة عن build_runner و Dart 3.10:** الحزمة الانتقالية `objective_c` (تأتي مع
> `path_provider_foundation` لأجهزة Apple) تضيف `hook/build.dart` يكسر مولّد الكود على
> Dart 3.10. لذلك يوجد `dependency_overrides: objective_c: 7.1.0` في `pubspec.yaml`
> **لأغراض توليد الكود فقط** — لا يؤثّر على تشغيل التطبيق على Android، ويُزال عند البناء
> لـ iOS أو عند إصلاح هذا الخلل في الأدوات.

## 7) كيف يعمل الدخول الوهمي (Mock)

عند `AppConstants.useMockData = true` (الافتراضي) يستخدم التطبيق `MockAuthDataSource`
بدل السيرفر، مع تأخير وهمي لإظهار حالات التحميل. رمز الـ OTP الثابت: **123456**.

### بيانات الدخول التجريبية

| الدور | الجوال | الإيميل | كلمة المرور | الحالة |
|------|--------|---------|-------------|--------|
| عميل | `0500000001` | `customer@sat7a.app` | `Customer@123` | — |
| سائق (معتمد) | `0500000002` | `driver@sat7a.app` | `Driver@123` | approved |
| سائق (قيد المراجعة) | `0500000003` | `pending@sat7a.app` | `Driver@123` | pending → يُمنع الدخول |
| مسؤول إدارة | — | `admin@sat7a.app` | `Admin@123` | — |

## 8) التحويل من Mock إلى API لاحقًا

1. غيّر `AppConstants.useMockData` إلى `false`.
2. اضبط `ApiConstants.baseUrl` + مسارات `auth/...` على السيرفر الحقيقي.
3. `AuthRepo` يستدعي تلقائيًا `AuthApiService` (Retrofit) بدل الـ mock — لا تغيير في
   طبقة الـ Cubit أو الـ UI.
4. (اختياري) فعّل التوكن في `DioFactory` وانقل تخزين التوكن إلى `flutter_secure_storage`
   بتعديل `AuthSession` فقط.

## 9) كيف تعمل حُرّاس المسارات

- **عند الإقلاع:** `SplashScreen` يقرأ `CacheHelper` → إن لم يكتمل الأونبوردنق ⇐
  Onboarding، وإلا إن لم تُسجّل الدخول ⇐ اختيار الدور، وإلا ⇐ الوجهة حسب الدور المخزّن.
- **حارس الدور:** كل شاشة وجهة (`TemporaryHomeView`) تتحقق أن الدور المخزّن يطابق دورها،
  وإلا تعيد التوجيه لاختيار الدور.
- **السائق قيد المراجعة:** لا تُحفظ له جلسة أصلًا (يُمنع الدخول برسالة عربية واضحة).
- **الخروج:** يمسح الجلسة، ويعيد لاختيار الدور مع منع الرجوع (`pushNamedAndRemoveUntil`).

## 10) كيف تُخزَّن الحالة

- **اكتمال الأونبوردنق:** `CacheHelper.setShowIntro(true)` (SharedPreferences).
- **التوكن + الدور + الاسم + حالة السائق:** عبر `AuthSession` فوق `CacheHelper`
  (`userId/token`, `type`, `userName`, `driverStatus`). جاهز للاستبدال بـ
  `flutter_secure_storage` لاحقًا.
- **اللغة:** `easy_localization` (`saveLocale: true`) + `CacheHelper.setLang`.

## 11) الاختبارات

```bash
flutter test
```

- **Unit:** دخول العميل (نجاح/فشل)، السائق المعتمد، منع السائق قيد المراجعة، دخول
  الإدارة، OTP صحيح/خاطئ، مسح الجلسة عند الخروج، تخزين الأونبوردنق، تنقّل خطوات السائق،
  cubit الأونبوردنق، والـ Validators.
- **Widget:** عرض الشعار في Splash، بطاقتا اختيار الدور، تحقّق دخول العميل، شاشة الإدارة،
  انتقال صفحات الأونبوردنق، وحقل OTP بستّ خانات.

النتيجة الحالية: **`flutter analyze` → No issues found** · **`flutter test` → All tests passed (21)**.

## 12) الحِزم الأساسية

`flutter_bloc` · `freezed` · `dio` + `retrofit` · `json_serializable` · `get_it` ·
`easy_localization` · `flutter_screenutil` · `flutter_svg` · `image_picker` ·
`pin_code_fields` · `flutter_staggered_animations` · `shared_preferences`.

## 13) تحسينات مقترحة للمرحلة القادمة

- نقل تخزين التوكن إلى `flutter_secure_storage` + interceptor فعلي للتوكن.
- الصفحة الرئيسية للعميل + الخريطة وطلب السطحة.
- واجهة السائق (استقبال الطلبات + تقديم العروض).
- لوحة تحكم الإدارة (مراجعة/قبول السائقين).
- ربط الـ Push Notifications (Firebase) لإشعار السائق بقبول حسابه.
