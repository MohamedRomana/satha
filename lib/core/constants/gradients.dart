import 'package:flutter/material.dart';
import 'colors.dart';

/// تدرّجات هوية سطحة — تُستخدم في الخلفيات والأزرار والشعار.
abstract class AppGradients {
  /// تدرّج الـ Navy الأساسي (للخلفيات الداكنة والـ Splash/Auth).
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.navy, AppColors.navy2],
  );

  /// تدرّج داكن أعمق للـ Splash (الوضع الداكن).
  static const LinearGradient deep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.deepBg, AppColors.navy, AppColors.navy2],
  );

  /// تدرّج فاتح لخلفيات الشاشات في الوضع الفاتح (قيم ثابتة فاتحة).
  static const LinearGradient light = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xffFFFFFF), Color(0xffF7F9FC), Color(0xffFFF0E0)],
  );

  /// تدرّج البرتقالي للـ CTA والعناصر المميزة.
  static const LinearGradient orange = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.orange, AppColors.orange2],
  );
}

/// ظلال موحّدة للبطاقات والأزرار.
abstract class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.navy.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> orangeGlow = [
    BoxShadow(
      color: AppColors.orange.withValues(alpha: 0.35),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];
}
