import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../../gen/fonts.gen.dart';

/// ثيمات سطحة — Light و Dark، كلاهما بهوية Navy / Orange وخط Tajawal.
abstract class AppTheme {
  static const _fontFamily = FontFamily.tajawalRegular;

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
      primary: AppColors.orange,
      secondary: AppColors.navy,
      error: AppColors.error,
      surface: AppColors.card,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.lightBg,
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.dark,
      primary: AppColors.orange,
      secondary: AppColors.orange2,
      error: AppColors.error,
      surface: AppColors.navy2,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.deepBg,
    );
  }

  static ThemeData _base(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      fontFamily: _fontFamily,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.orange,
        selectionColor: AppColors.orange.withValues(alpha: 0.3),
        selectionHandleColor: AppColors.orange,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
