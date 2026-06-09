import 'package:satha/core/cache/cache_helper.dart';
import 'models/app_user.dart';
import 'models/user_role.dart';

/// إدارة جلسة الدخول المخزّنة محليًا (token + role + بيانات أساسية).
/// مبنية على [CacheHelper] حسب conventions المشروع — يمكن استبدالها لاحقًا
/// بـ flutter_secure_storage بتغيير هذا الملف فقط.
class AuthSession {
  AuthSession._();

  /// حفظ جلسة المستخدم بعد نجاح الدخول/التحقق.
  static Future<void> save({
    required AppUser user,
    required String token,
  }) async {
    await CacheHelper.setUserId(token.isEmpty ? user.id : token);
    await CacheHelper.setUserType(user.role.key);
    await CacheHelper.setUserName(user.name);
    await CacheHelper.setDriverStatus(user.approvalStatus?.key);
  }

  /// مسح الجلسة عند تسجيل الخروج.
  static Future<void> clear() async {
    await CacheHelper.setUserId('');
    await CacheHelper.setUserType('');
    await CacheHelper.setUserName('');
    await CacheHelper.setDriverStatus('');
  }

  static bool get isLoggedIn => CacheHelper.getUserId().isNotEmpty;

  static UserRole get role => UserRoleX.fromKey(CacheHelper.getUserType());
}
