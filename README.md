# سطحة (Sat7a)

تطبيق Flutter لخدمات إنقاذ ونقل السيارات (السطحات). يشمل المشروع الأساس الاحترافي
(Splash + Onboarding + اختيار الدور + مصادقة 3 أدوار)، بالإضافة إلى **جانب العميل
الكامل**: الرئيسية، إدارة السيارات، تدفّق إنشاء الطلب على خرائط Google، العروض
والتتبّع المباشر وتأكيد OTP والتقييم والفاتورة، المحادثات والإشعارات والملف الشخصي
والإعدادات والدعم — كلها تعمل ببيانات وهمية (Mock) بدون باك إند، مع بنية جاهزة للربط
بالـ API و socket لاحقًا.

> واجهة السائق ولوحة تحكم الإدارة ما زالتا بشاشات وجهة مؤقتة توضّح نجاح الدخول حسب الدور.

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

## 2.1) جانب العميل المنفّذ بالكامل

- **الهيكل الرئيسي:** `CustomerMainLayout` (IndexedStack + Bottom Nav) — الرئيسية /
  الطلبات / سياراتي / المحادثات / حسابي.
- **الرئيسية:** سلايدرات عروض، الخدمات، إنقاذ سريع، معاينة آخر الطلبات، بطاقة الدعم.
- **السيارات (CRUD):** قائمة + تفاصيل + إضافة/تعديل (image picker) + حذف + تعيين افتراضية.
- **إنشاء الطلب (5 خطوات):** الخدمة (عادية/هيدروليك) → السيارة → المشكلة (+صور) →
  تحديد المواقع على **خرائط Google** → ملخّص الطلب → تأكيد وإرسال → شاشة نجاح.
- **الطلبات:** 3 تبويبات (الحالية/السابقة/الملغاة)، تفاصيل الطلب (رأس حالة متحرّك +
  خط زمني + إلغاء عند السماح + إبلاغ + فاتورة عند الاكتمال).
- **العروض:** خريطة + بوتوم شيت متحرّك + بطاقات عروض (تقييم/مسافة/سعر/عدّاد تنازلي) +
  ملف السائق العام + قبول/رفض (قبول عرض يرفض الباقي تلقائيًا ويبدأ التتبّع).
- **التتبّع المباشر:** تحريك علامة السائق على polyline وهمي + ETA/المسافة المتبقية +
  أزرار اتصال/محادثة/إبلاغ/إعادة توسيط، مع أحداث socket جاهزة.
- **OTP تأكيد:** بوتوم شيت 6 خانات لتأكيد وصول السائق وإتمام الرحلة (الرمز **123456**).
- **التقييم:** خمس نجوم متحرّكة + تعليق اختياري.
- **الفاتورة:** رقم/تاريخ/عميل/سائق/سيارة/خدمة/مسافة/مدة/سعر/خصم/إجمالي/حالة الدفع.
- **المحادثات:** قائمة + تفاصيل (رسائل نصّ/صورة/موقع + أنميشن دخول + إرسال وهمي) +
  أحداث socket جاهزة.
- **الإشعارات:** مقروء/غير مقروء + عدّاد + تعليم الكل + حذف (Dismissible) + فتح الطلب.
- **الملف الشخصي والإعدادات:** تعديل الملف، تغيير كلمة المرور، اللغة، الثيم، الإشعارات.
- **الصفحات الثابتة والدعم:** من نحن، الخصوصية، الشروط، الأسئلة الشائعة (بطاقات قابلة
  للطي)، تواصل معنا، الدعم (اتصال/واتساب)، والإبلاغ عن مشكلة (فئة + وصف + صور).

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

## 6.1) إعداد خرائط Google (Google Maps)

تدفّق إنشاء الطلب وشاشتا العروض/التتبّع تستخدم `google_maps_flutter`. تحتاج مفتاح API
واحد لكل منصّة:

- **أين يوضع المفتاح (`MAPS_API_KEY`):**
  - **Android:** داخل `android/app/src/main/AndroidManifest.xml` ضمن وسم
    `<meta-data android:name="com.google.android.geo.API_KEY" android:value="..."/>`
    داخل `<application>`.
  - **iOS:** في `ios/Runner/AppDelegate.swift` عبر
    `GMSServices.provideAPIKey("...")`، أو كمفتاح `GMSApiKey` في `Info.plist`.
- فعّل في Google Cloud Console: **Maps SDK for Android** و **Maps SDK for iOS**
  (و**Directions API** عند تفعيل المسار الحقيقي لاحقًا).

**إعداد Android:** أذونات الموقع (`ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION`)
مضافة في `AndroidManifest.xml`، و`minSdkVersion` متوافق مع الخرائط.

**إعداد iOS:** أوصاف الإذن `NSLocationWhenInUseUsageDescription` مضافة في
`ios/Runner/Info.plist`.

**سلوك المسار الوهمي (Mock route):** `RouteService` له تنفيذان: `MockRouteService`
(الافتراضي، يحسب المسافة بـ `Geolocator.distanceBetween` ويُولّد polyline مُستوفى +
زمن قيادة تقديري) و`RemoteRouteService` (جاهز للربط بـ Directions API). التتبّع المباشر
عبر `MockLiveTrackingService` يحرّك السائق عبر نقاط المسار ويحدّث ETA/المسافة والحالة.

## 6.2) بنية أيقونات الـ SVG

أيقونات الواجهة من نوع SVG (عبر `flutter_svg`) ومنظّمة في `assets/icons/` حسب الفئة،
مع ثوابت المسارات في `core/constants/app_icons.dart` وتُعرض عبر `AppSvgIcon`
(يدعم اللون والحجم وأنميشن لون انتقالي):

```
assets/icons/
├── navigation/   # home · orders · vehicles · chat · profile
├── services/     # tow_truck_normal · tow_truck_hydraulic · quick_rescue
├── common/       # notification · support · arrow_left · edit · delete · camera ...
├── vehicles/     # car · car_plate · car_color · chassis
└── orders/       # breakdown · accident · car_not_working · tire · battery · fuel ...
```

## 7) كيف يعمل الدخول الوهمي (Mock)

عند `AppConstants.useMockData = true` (الافتراضي) يستخدم التطبيق `MockAuthDataSource`
بدل السيرفر، مع تأخير وهمي لإظهار حالات التحميل. رمز الـ OTP الثابت: **123456**
(يُستخدم لتأكيد دخول المصادقة، وكذلك لتأكيد وصول السائق وإتمام الرحلة).

كل بيانات جانب العميل وهمية في الذاكرة عبر مستودعات Mock (`MockOrdersRepository` /
`MockOffersRepository` / `MockChatsRepository` / `MockNotificationsRepository` /
`MockSupportRepository`) — جاهزة للاستبدال بتنفيذ Retrofit دون تعديل الـ Cubit/UI.

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

## 9.1) الثيمات (Light / Dark) واللوجو

- ثيمان كاملان في `core/theme/app_theme.dart` (`AppTheme.light` / `AppTheme.dark`)،
  يُداران عبر `ThemeCubit` (محفوظ في `CacheHelper`، الافتراضي تَبَع النظام).
- زر تبديل الثيم `ThemeToggle` موجود في شاشات البداية والمصادقة بجوار زر اللغة.
- **اللوجو يتغيّر تلقائيًا مع الثيم:** الوضع الداكن ⇐ `logo_white.png`، الوضع الفاتح ⇐
  `logo.png` (الـ navy) — عبر `AppLogo` الذي يقرأ `Theme.of(context).brightness`.
- خلفيات شاشات الـ brand (Splash/Onboarding/Role/Auth/Home المؤقتة) تتبع الثيم أيضًا
  (`context.brandGradient` + `context.onBrand`) فيظهر اللوجو والنص بوضوح في الحالتين.

## 10) كيف تُخزَّن الحالة

- **اكتمال الأونبوردنق:** `CacheHelper.setShowIntro(true)` (SharedPreferences).
- **التوكن + الدور + الاسم + حالة السائق:** عبر `AuthSession` فوق `CacheHelper`
  (`userId/token`, `type`, `userName`, `driverStatus`). جاهز للاستبدال بـ
  `flutter_secure_storage` لاحقًا.
- **اللغة:** `easy_localization` (`saveLocale: true`) + `CacheHelper.setLang`.

### تبديل اللغة

- زر اللغة في شاشات البداية/المصادقة (`LangToggle`) أو شاشة **اللغة** داخل الإعدادات.
- يستدعي `context.setLocale(Locale('ar'|'en'))` + `CacheHelper.setLang` فيُعاد بناء
  التطبيق بالكامل (عبر مفتاح `MaterialApp`) مع اتجاه RTL/LTR الصحيح.
- النصوص كلها مفاتيح `LocaleKeys.x.tr()` في `assets/Lang/ar.json` و`en.json`. بعد إضافة
  مفتاح أعد التوليد:

```bash
dart run easy_localization:generate -S assets/Lang -O lib/generated
dart run easy_localization:generate -S assets/Lang -O lib/generated -f keys -o locale_keys.g.dart
```

## 11) الاختبارات

```bash
flutter test
```

- **Auth:** دخول العميل (نجاح/فشل)، السائق المعتمد، منع السائق قيد المراجعة، دخول
  الإدارة، OTP صحيح/خاطئ، مسح الجلسة عند الخروج، تخزين الأونبوردنق، تنقّل خطوات السائق.
- **السيارات والطلب:** تحقّق خطوات الطلب، إضافة/تعديل سيارة، اختيار المواقع وبناء المسودّة،
  مستودع الطلبات (إنشاء/جلب)، وخدمة المسار الوهمية.
- **العروض والتتبّع:** قبول عرض يرفض الباقي، اختفاء العرض المرفوض، تحديث حالة الطلب،
  بثّ مواقع التتبّع، OTP صحيح/خاطئ، وإرسال التقييم.
- **المحادثات والإشعارات والدعم:** إرسال رسالة، قراءة/حذف الإشعارات والعدّاد، تحقّق
  الإبلاغ عن مشكلة، والأسئلة الشائعة.
- **Widget:** الشعار في Splash، بطاقتا الدور، دخول العميل، شاشة الإدارة، الأونبوردنق،
  حقل OTP، الخرائط، وملخّص/نجاح الطلب.

النتيجة الحالية: **`flutter analyze` → No issues found** · **`flutter test` → All tests passed (74)**.

## 12) الحِزم الأساسية

`flutter_bloc` · `freezed` · `dio` + `retrofit` · `json_serializable` · `get_it` ·
`easy_localization` · `flutter_screenutil` · `flutter_svg` · `image_picker` ·
`pin_code_fields` · `flutter_staggered_animations` · `shared_preferences` ·
`google_maps_flutter` · `geolocator` · `geocoding` · `url_launcher` ·
`cached_network_image` · `lottie` · `shimmer`.

## 13) تحسينات مقترحة للمرحلة القادمة

- نقل تخزين التوكن إلى `flutter_secure_storage` + interceptor فعلي للتوكن.
- ربط مستودعات الـ Mock بتنفيذ Retrofit حقيقي + Directions API للمسار الفعلي.
- ربط الـ socket لأحداث التتبّع والمحادثة (`OrderSocketEvents` / `ChatSocketEvents`).
- واجهة السائق (استقبال الطلبات + تقديم العروض).
- لوحة تحكم الإدارة (مراجعة/قبول السائقين).
- ربط الـ Push Notifications (Firebase).
