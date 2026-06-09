import 'dart:ui';

/// ألوان هوية سطحة — Navy / Orange palette.
/// الأسماء القديمة (primary / secondray / ...) متسابقة عشان core widgets
/// المبنية على الـ delivery conventions تفضل شغّالة من غير تعديل.
abstract class AppColors {
  // ---- Brand (satha) ----
  static const Color navy = Color(0xff071B33); // Primary Navy
  static const Color navy2 = Color(0xff0D2C52); // Secondary Navy
  static const Color deepBg = Color(0xff051426); // Deep Background

  static const Color orange = Color(0xffFF7A00); // Primary Orange
  static const Color orange2 = Color(0xffFF9D2E); // Secondary Orange
  static const Color softOrange = Color(0xffFFF0E0); // Soft Orange

  static const Color lightBg = Color(0xffF7F9FC); // Light Background
  static const Color card = Color(0xffFFFFFF); // Card Background
  static const Color mainText = Color(0xff0C1C2D); // Main Text
  static const Color secondaryText = Color(0xff627083); // Secondary Text

  static const Color success = Color(0xff16A36A);
  static const Color warning = Color(0xffF2B134);
  static const Color error = Color(0xffD94A4A);
  static const Color border = Color(0xffE6EBF2);

  // ---- Legacy aliases (used by shared core widgets) ----
  static const Color primary = orange;
  static const Color secondray = navy;
  static const Color textColor = mainText;
  static const Color textColor2 = secondaryText;
  static const Color backColor = lightBg;
  static const Color darkRed = error;
  static const Color borderColor = border;
  static const Color thirdColor = navy;
  static const Color fourthColor = lightBg;
}
