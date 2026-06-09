import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/users/shared/temporary_home_view.dart';

/// وجهة مؤقتة لمسؤول الإدارة بعد تسجيل الدخول.
class AdminTemporaryHomeScreen extends StatelessWidget {
  const AdminTemporaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryHomeView(
      role: UserRole.admin,
      icon: Icons.admin_panel_settings_rounded,
      title: LocaleKeys.welcomeAdminPanel.tr(),
      message: LocaleKeys.loggedInAdmin.tr(),
      subMessage: LocaleKeys.adminNextPhase.tr(),
    );
  }
}
