import 'package:flutter/widgets.dart';

/// عنصر صفحة في الأونبوردنق (عنوان + وصف + مشهد متحرّك).
class OnboardingItem {
  final String title;
  final String description;
  final Widget scene;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.scene,
  });
}
