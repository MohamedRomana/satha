import 'user_role.dart';

/// كيان المستخدم المستخدم داخل طبقة الـ logic والـ UI
/// (نسخة نظيفة بعيدة عن تفاصيل الـ JSON).
class AppUser {
  final String id;
  final String name;
  final String phone;
  final String email;
  final UserRole role;
  final DriverApprovalStatus? approvalStatus; // للسائق فقط
  final String? image;

  const AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    this.approvalStatus,
    this.image,
  });
}
