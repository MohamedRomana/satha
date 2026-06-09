/// ثوابت عامة لتطبيق سطحة + إعدادات الـ mock authentication.
class AppConstants {
  AppConstants._();

  /// لو true التطبيق يشتغل ببيانات وهمية (mock) من غير باك إند.
  /// غيّرها لـ false لما يجهز الـ API الحقيقي عشان يبدأ يكلّم السيرفر.
  static const bool useMockData = true;

  /// تأخير وهمي لمحاكاة الـ network وإظهار حالات التحميل.
  static const Duration mockDelay = Duration(milliseconds: 1200);

  /// رمز التحقق الثابت في وضع الـ mock.
  static const String mockOtp = '123456';

  /// مدة إعادة إرسال رمز التحقق (ثواني).
  static const int otpResendSeconds = 60;

  /// الحد الأدنى لطول كلمة المرور.
  static const int minPasswordLength = 8;

  /// مدن متاحة للاختيار في تسجيل السائق.
  static const List<String> cities = [
    'الرياض',
    'جدة',
    'مكة المكرمة',
    'المدينة المنورة',
    'الدمام',
    'الخبر',
    'الطائف',
    'تبوك',
    'بريدة',
    'أبها',
  ];
}
