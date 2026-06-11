/// سؤال شائع.
class FaqModel {
  final String question;
  final String answer;
  const FaqModel({required this.question, required this.answer});
}

/// بيانات تواصل الدعم.
class SupportContactModel {
  final String phone;
  final String whatsapp;
  final String email;
  const SupportContactModel({
    required this.phone,
    required this.whatsapp,
    required this.email,
  });
}

/// فئة البلاغ.
enum ComplaintCategory {
  driver,
  price,
  delay,
  behavior,
  order,
  technical,
  other,
}

extension ComplaintCategoryX on ComplaintCategory {
  String get labelKey {
    switch (this) {
      case ComplaintCategory.driver:
        return 'complaintDriver';
      case ComplaintCategory.price:
        return 'complaintPrice';
      case ComplaintCategory.delay:
        return 'complaintDelay';
      case ComplaintCategory.behavior:
        return 'complaintBehavior';
      case ComplaintCategory.order:
        return 'complaintOrder';
      case ComplaintCategory.technical:
        return 'complaintTechnical';
      case ComplaintCategory.other:
        return 'complaintOther';
    }
  }
}

/// بلاغ/شكوى.
class ComplaintModel {
  final String? orderId;
  final ComplaintCategory category;
  final String description;
  final List<String> screenshots;

  const ComplaintModel({
    required this.category,
    required this.description,
    this.orderId,
    this.screenshots = const [],
  });
}
