import 'dart:ui';

import 'package:flutter/foundation.dart';

/// ألوان هوية سطحة — Navy / Orange palette.
///
/// ألوان الـ brand الثابتة (orange/navy/...) تبقى `const`. أما ألوان الأسطح
/// (الخلفية/الكارت/النص/الحدود) فهي getters تتبدّل حسب الثيم عبر [isDark].
/// تغيير [isDark] يُخطر [darkNotifier] فتُعيد كل الشاشات (الملفوفة بـ
/// ValueListenableBuilder في الراوتر) بناء نفسها فورًا بألوان الثيم الجديد.
abstract class AppColors {
  /// مُخطِر يتغيّر مع وضع الثيم — تستمع إليه الشاشات لإعادة البناء الفوري.
  static final ValueNotifier<bool> darkNotifier = ValueNotifier<bool>(false);

  static bool get isDark => darkNotifier.value;
  static set isDark(bool value) {
    if (darkNotifier.value != value) darkNotifier.value = value;
  }

  // ---- Brand (ثابتة) ----
  static const Color navy = Color(0xff071B33); // Primary Navy
  static const Color navy2 = Color(0xff0D2C52); // Secondary Navy
  static const Color deepBg = Color(0xff051426); // Deep Background

  static const Color orange = Color(0xffFF7A00); // Primary Orange
  static const Color orange2 = Color(0xffFF9D2E); // Secondary Orange

  static const Color success = Color(0xff16A36A);
  static const Color warning = Color(0xffF2B134);
  static const Color error = Color(0xffD94A4A);

  // ---- أسطح متبدّلة حسب الثيم ----
  static Color get lightBg => isDark ? deepBg : const Color(0xffF7F9FC);
  static Color get card =>
      isDark ? const Color(0xff0E2748) : const Color(0xffFFFFFF);
  static Color get mainText =>
      isDark ? const Color(0xffEAF1FB) : const Color(0xff0C1C2D);
  static Color get secondaryText =>
      isDark ? const Color(0xff93A4BC) : const Color(0xff627083);
  static Color get border =>
      isDark ? const Color(0xff1E3A5F) : const Color(0xffE6EBF2);
  static Color get softOrange =>
      isDark ? const Color(0x33FF7A00) : const Color(0xffFFF0E0);

  // ---- Legacy aliases (تُستخدم في core widgets المشتركة) ----
  static const Color primary = orange;
  static const Color secondray = navy;
  static Color get textColor => mainText;
  static Color get textColor2 => secondaryText;
  static Color get backColor => lightBg;
  static const Color darkRed = error;
  static Color get borderColor => border;
  static const Color thirdColor = navy;
  static Color get fourthColor => lightBg;
}
