import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache/cache_helper.dart';
import '../constants/colors.dart';

/// كيوبت إدارة وضع الثيم (دارك/لايت/تبع النظام) مع حفظه محليًا.
///
/// يضبط [AppColors.isDark] **قبل** الـ emit، فتقرأ كل الشاشات اللون الصحيح فور
/// إعادة بنائها (بدون الحاجة لـ hot restart).
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_fromCache()) {
    _applyBrightness(state);
  }

  static ThemeMode _fromCache() {
    switch (CacheHelper.getThemeMode()) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  /// يحسب السطوع الفعّال للوضع ويضبط [AppColors.isDark].
  static void _applyBrightness(ThemeMode mode) {
    final systemDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
    AppColors.isDark =
        mode == ThemeMode.dark || (mode == ThemeMode.system && systemDark);
  }

  void setMode(ThemeMode mode) {
    CacheHelper.setThemeMode(mode.name);
    _applyBrightness(mode);
    emit(mode);
  }

  /// تبديل بين الداكن والفاتح اعتمادًا على السطوع الحالي الفعّال.
  void toggle(bool currentlyDark) {
    setMode(currentlyDark ? ThemeMode.light : ThemeMode.dark);
  }
}
