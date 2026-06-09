/// أدوار المستخدمين في تطبيق سطحة.
enum UserRole { customer, driver, admin }

/// حالة موافقة حساب السائق من الإدارة.
enum DriverApprovalStatus { pending, approved, rejected, suspended }

extension UserRoleX on UserRole {
  /// المفتاح النصّي المستخدم في الـ cache والـ API.
  String get key {
    switch (this) {
      case UserRole.customer:
        return 'customer';
      case UserRole.driver:
        return 'driver';
      case UserRole.admin:
        return 'admin';
    }
  }

  static UserRole fromKey(String? value) {
    switch (value) {
      case 'driver':
        return UserRole.driver;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.customer;
    }
  }
}

extension DriverApprovalStatusX on DriverApprovalStatus {
  String get key {
    switch (this) {
      case DriverApprovalStatus.pending:
        return 'pending';
      case DriverApprovalStatus.approved:
        return 'approved';
      case DriverApprovalStatus.rejected:
        return 'rejected';
      case DriverApprovalStatus.suspended:
        return 'suspended';
    }
  }

  static DriverApprovalStatus fromKey(String? value) {
    switch (value) {
      case 'approved':
        return DriverApprovalStatus.approved;
      case 'rejected':
        return DriverApprovalStatus.rejected;
      case 'suspended':
        return DriverApprovalStatus.suspended;
      default:
        return DriverApprovalStatus.pending;
    }
  }
}
