# CLAUDE.md — Project Architecture & Conventions

دليل بناء التطبيق وكتابة الكود. اتبع نفس الـ structure والترتيب ده بالظبط عند إضافة أي feature أو wiring لأي API.

> هذه القواعد مستخرَجة من مشروع شقيق (elsdo) بنفس أسلوب المطوّر. التزم بها حرفياً.

---

## 1. Stack

- **State management:** `flutter_bloc` (Cubit فقط — مش Bloc events)
- **Immutable states/unions:** `freezed` + `freezed_annotation`
- **JSON models:** `json_serializable` + `json_annotation`
- **Networking:** `retrofit` + `dio` (مع `pretty_dio_logger`)
- **DI:** `get_it`
- **Responsive:** `flutter_screenutil` (`.w` / `.h` / `.r` / `.sp`)
- **Localization:** `easy_localization` + مفاتيح مولّدة `LocaleKeys`
- **Images:** `cached_network_image` (عبر `AppCachedImage`)
- **Animations:** `flutter_staggered_animations`, `lottie`, `shimmer`, `gif`
- **Maps:** `google_maps_flutter` + `geolocator` + `geocoding`

---

## 2. Folder Structure

```
lib/
├── main.dart
├── core/                         # كل المشترك بين الـ features
│   ├── cache/                    # CacheHelper (SharedPreferences)
│   ├── constants/                # colors.dart (AppColors), app_constants.dart ...
│   ├── di/                       # dependancy_injection.dart  (getIt + setUpGetIt)
│   ├── helper/                   # extentions.dart + helpers/features مشتركة
│   ├── map/                      # location_helper, location_picker_sheet, map cubit
│   ├── networking/               # api_constants, api_result, api_error_model, dio_factory, bloc_observer
│   ├── routing/                  # app_router.dart, routes.dart
│   └── widgets/                  # ويدجتس عامة (AppText, AppInput, AppButton, AppCachedImage, ...)
├── features/
│   ├── auth/<feature>/           # login, register, otp, forget_pass, reset_pass ...
│   ├── start/<feature>/          # splash, on_boarding
│   └── users/
│       ├── user/<feature>/       # شاشات العميل
│       └── provider/<feature>/   # شاشات المزوّد/المتجر
├── gen/                          # assets.gen.dart, fonts.gen.dart (flutter_gen)
└── generated/                    # codegen_loader.g.dart, locale_keys.g.dart (easy_localization)
```

---

## 3. بنية الـ Feature (Clean Architecture)

كل feature تتقسّم 3 طبقات داخل فولدر الـ feature:

```
features/users/user/<feature>/
├── data/
│   ├── apis/      <feature>_api_service.dart      (Retrofit @RestApi)
│   ├── models/    <feature>_body_model.dart       (request body)
│   │              <feature>_response_model.dart   (response)
│   └── repos/     <feature>_repo.dart             (يلفّ الـ api في ApiResult)
├── logic/
│   ├── <feature>_cubit.dart
│   └── <feature>_state.dart                       (freezed union)
└── ui/
    ├── <feature>.dart                             (الشاشة = composition فقط)
    └── widgets/                                   (كل جزء UI = كلاس widget مستقل)
```

**قاعدة حاكمة:** الشاشة الرئيسية تجميع (composition) فقط. أي جزء UI متكرر أو كبير = **كلاس widget حقيقي في ملف مستقل** داخل `ui/widgets/`. **ممنوع** استخدام `Widget _buildX()` helper methods أو كلاسات `_Private` جوّه ملف الشاشة.

---

## 4. Networking

### api_constants.dart
كل الـ endpoints ثوابت في `ApiConstants`:
```dart
class ApiConstants {
  static const String baseUrl = "https://.../";
  static const String login = "api/login";
  static const String showCart = 'api/show-cart';
}
```

### ApiResult — union النتيجة
```dart
@Freezed()
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.error(ApiErrorModel error) = Failure<T>;
}
```
> **مهم:** استخدام `response.when(success:, error:)` يتطلب استيراد `core/networking/api_result.dart` صراحةً في الـ cubit، وإلا يطلع خطأ `method 'when' isn't defined`.

### API Service (Retrofit)
```dart
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class XApiService {
  factory XApiService(Dio dio, {String baseUrl}) = _XApiService;

  // JSON body → مرّر موديل بـ @Body (الأسلوب المفضّل)
  @POST(ApiConstants.showCart)
  Future<XResponseModel> getX(@Body() XBodyModel body);

  // form fields بسيطة → @Field
  @POST(ApiConstants.allProviderSections)
  Future<YResponseModel> getY({@Field('lang') String? lang});

  // رفع صور / multipart → @MultiPart + @Part / @Part('images[]') List<MultipartFile>
  @MultiPart()
  @POST(ApiConstants.storeProductService)
  Future<ZResponseModel> store({
    @Part(name: 'title_ar') String? titleAr,
    @Part(name: 'images[]') List<MultipartFile>? images,
  });

  // arrays متداخلة (مثل dates[date][]) أو تحكّم كامل → ابعت FormData جاهز عبر @Body
  @POST(ApiConstants.storeProductService)
  Future<ZResponseModel> storeForm(@Body() FormData body);
}
```

### Repo — يلفّ الـ apiService دايماً في try/catch ويرجّع ApiResult
```dart
class XRepo {
  final XApiService _apiService;
  XRepo(this._apiService);

  Future<ApiResult<XResponseModel>> getX(XBodyModel body) async {
    try {
      final response = await _apiService.getX(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorModel(message: error.toString()));
    }
  }
}
```

---

## 5. Models & Codegen

- **Body models** و**Response models** منفصلين، بـ `@JsonSerializable()` و `part '...g.dart';`.
- المفاتيح snake_case عبر `@JsonKey(name: 'user_id')`.
- الحقول كلها nullable (`String?`, `int?`, `num?`, `List<X>?`) في الـ response.
- لو حقل بيرجع نوع مختلف أحياناً (int مرة وString مرة) استخدم `fromJson` converter:
  ```dart
  String? _fromJson(dynamic v) => v?.toString();
  @JsonKey(name: 'cart_count', fromJson: _fromJson) final String? cartCount;
  ```
- لو عايز تشيل القيم الـ null من الـ body: `@JsonSerializable(includeIfNull: false)`.

### أوامر التوليد (build_runner)
```bash
dart run build_runner build --delete-conflicting-outputs
# للملفات المحددة:
dart run build_runner build --delete-conflicting-outputs --build-filter="lib/features/.../**"
```
> **مشكلة الكاش:** أحياناً build_runner يسيب ملف `.g.dart`/`.freezed.dart` قديم. الحل: احذف الملف المولّد المعني ثم اعمل build كامل.

---

## 6. Dependency Injection (get_it)

في `core/di/dependancy_injection.dart` — سجّل كل ApiService و Repo كـ `registerLazySingleton`:
```dart
getIt.registerLazySingleton<XApiService>(() => XApiService(dio));
getIt.registerLazySingleton<XRepo>(() => XRepo(getIt()));
```
- **الـ Cubits مش بتتسجّل في DI** — بتتعمل في الـ route عبر `getIt()` للـ repo.
- `setUpGetIt()` بتتنده في `main()` قبل `runApp`.

---

## 7. Routing

- `routes.dart`: ثوابت أسماء المسارات (`static const String x = '/x';`).
- `app_router.dart`: `onGenerateRoute` = `switch (settings.name)`، وكل route بترجع `_fadeRoute(builder: ...)` (transition موحّد fade/slide).
- الـ Cubit يتعمل جوّه الـ route مع تشغيل أول fetch:
```dart
case Routes.x:
  final arg = settings.arguments as XArg;
  return _fadeRoute(
    builder: (_) => BlocProvider(
      create: (context) => XCubit(getIt())..getX(),
      child: XScreen(arg: arg),
    ),
  );
```
- شاشة محتاجة أكتر من cubit → `MultiBlocProvider`.
- تمرير البيانات بين الشاشات عبر `settings.arguments` (موديل/Map/String).

---

## 8. State (Cubit + freezed)

```dart
@freezed
class XState with _$XState {
  const factory XState.initial() = _Initial;
  const factory XState.loading() = XLoading;
  const factory XState.success(XResponseModel response) = XSuccess;
  const factory XState.error(ApiErrorModel error) = XError;
  // أكشن جانبي مايخفيش الليست:
  const factory XState.actionLoading(String action) = XActionLoading;
  const factory XState.actionSuccess(String message) = XActionSuccess;
  const factory XState.actionError(String message) = XActionError;
}
```
```dart
class XCubit extends Cubit<XState> {
  final XRepo _repo;
  XCubit(this._repo) : super(const XState.initial());

  List<Item> items = [];

  void getX({bool silent = false}) async {
    if (!silent) emit(const XState.loading());
    final response = await _repo.getX(XBodyModel(
      lang: CacheHelper.getLang(), userId: CacheHelper.getUserId(),
    ));
    if (isClosed) return;                         // دايماً اتشيّك قبل emit بعد await
    response.when(
      success: (res) {
        if (res.status == 1) { items = res.data ?? []; emit(XState.success(res)); }
        else { emit(XState.error(ApiErrorModel(message: res.message, status: res.status))); }
      },
      error: (error) { if (isClosed) return; emit(XState.error(error)); },
    );
  }
}
```
ملاحظات:
- بعد أي عملية نجاح (add/delete/update) نادِ `getX(silent: true)` عشان الليست تتحدّث من غير شيمر.
- خلّي الـ UI يقرأ الداتا من حقل في الـ cubit (`cubit.items`/`cubit.data`) مش من payload حالة النجاح — عشان حالات الأكشن المؤقتة ماتخفيش الليست.
- لو الحالة `const` بدون حقول مش هتعيد الـ emit لو مساوية للحالية — ضيف باراميتر مميّز لو محتاج إعادة بناء.

---

## 9. UI Conventions

- استخدم `flutter_screenutil` لكل الأبعاد: `16.w`, `16.h`, `15.r`, `14.sp`.
- الويدجتس العامة في `core/widgets/`: `AppText`, `AppInput`, `AppButton`, `AppCachedImage`, `CustomAppBar`, `CustomBottomNav`, `CustomShimmer`, `PageShimmer`, `EmptyDataWidget`, `FadeSlideIn`, `flash_message` (`showFlashMessage`), `AppPicker` (date/time بألوان التطبيق).
- الألوان من `AppColors` فقط (primary, secondray, borderColor, ...). مفيش ألوان hardcoded إلا للحالات الخاصة.
- **استخراج الويدجتس:** أي قسم UI = كلاس مستقل في `ui/widgets/`. ممنوع `_buildX()`.
- **حالات الشاشة الموحّدة** (List/Detail):
  - **loading** → `PageShimmer` / شيمر مخصص (`CustomShimmer`).
  - **error** → `EmptyDataWidget(lottieName: Assets.img.error, message: ...)`.
  - **empty** → `EmptyDataWidget(message: LocaleKeys.no_x.tr())`.
  - **data** → القائمة/المحتوى مع `AnimationLimiter` + `SlideAnimation`/`FadeInAnimation`.
- زر فيه عملية شبكة: لفّه بـ `BlocConsumer`، أظهر `CircularProgressIndicator` أثناء الـ loading، و`showFlashMessage` للنجاح/الخطأ.
- شيتس/ديالوجات قابلة لإعادة الاستخدام بـ callbacks: `LocationPickerSheet(onConfirm: (lat,lng,address){})`, `ConfirmDeleteDialog.show(context, onConfirm: ...)`, `RejectOfferSheet(onSubmit: (reason){})`.
- بعد الإضافة/التعديل ارجع بـ `pop(true)` ونفّذ reload في الشاشة الأصلية:
  ```dart
  final added = await context.pushNamed(Routes.addX);
  if (added == true) cubit.getX();
  ```

---

## 10. Validation

- الفورمات بـ `Form(key: cubit.formKey)` + `validate:` على `AppInput`، والزرار يعمل `cubit.formKey.currentState!.validate()` قبل الإرسال.
- التحقق من غير الفورم (صورة مطلوبة، عنصر مختار) داخل دالة الإرسال في الـ cubit → emit حالة error برسالة (تظهر flash).

---

## 11. Localization

- النصوص كلها مفاتيح: `LocaleKeys.x.tr()`. ممنوع نصوص ثابتة في الـ UI.
- ملفات اللغة: `assets/Lang/ar.json` و `assets/Lang/en.json`.
- بعد إضافة مفتاح، أعد التوليد:
```bash
dart run easy_localization:generate -S assets/Lang -O lib/generated -o codegen_loader.g.dart
dart run easy_localization:generate -S assets/Lang -O lib/generated -o locale_keys.g.dart -f keys
```

---

## 12. Cache & Location

- `CacheHelper` (SharedPreferences) static: `getLang()`, `getUserId()`, `getUserType()`, `getAddress()/setAddress()`, `getLat/Lng`. للقيم اللي محتاجة تحديث فوري في الـ UI استخدم `ValueNotifier` + `ValueListenableBuilder` (زي `addressNotifier`).
- صلاحية الموقع تُطلب أول ما التطبيق يفتح (`LocationHelper.ensurePermission()` في `main`/`initState` بعد أول frame) مش في نص الاستخدام.

---

## 13. Naming Conventions

- ملفات: `snake_case.dart`.
- Cubit/State/Repo/ApiService/Model: `PascalCase` بنفس بادئة الـ feature (`XCubit`, `XState`, `XRepo`, `XApiService`, `XBodyModel`, `XResponseModel`).
- مسمّيات المسارات camelCase في `Routes`.
- مشاركة موديل بين features عبر import مباشر (زي استيراد `ServiceItem` من helper) مقبول.

---

## 14. خطوات إضافة feature/API جديد (Checklist)

1. ضيف الـ endpoint في `ApiConstants`.
2. اعمل `data/models/` (body + response) بـ json_serializable.
3. اعمل `data/apis/<x>_api_service.dart` (Retrofit) و `data/repos/<x>_repo.dart`.
4. اعمل `logic/<x>_state.dart` (freezed) و `logic/<x>_cubit.dart`.
5. سجّل ApiService + Repo في `dependancy_injection.dart`.
6. اعمل `ui/<x>.dart` + الويدجتس في `ui/widgets/`.
7. ضيف الـ route في `routes.dart` + `app_router.dart` (BlocProvider + getIt + أول fetch).
8. ضيف مفاتيح اللغة + regenerate.
9. شغّل build_runner، ثم `flutter analyze` على فولدر الـ feature لحد ما يبقى **No issues found**.
