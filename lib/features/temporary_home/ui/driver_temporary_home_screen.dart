import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../auth/data/models/user_role.dart';
import 'widgets/temporary_home_view.dart';

/// وجهة مؤقتة للسائق بعد تسجيل الدخول.
class DriverTemporaryHomeScreen extends StatelessWidget {
  const DriverTemporaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryHomeView(
      role: UserRole.driver,
      icon: Icons.local_shipping_rounded,
      title: LocaleKeys.welcomeSatha.tr(),
      message: LocaleKeys.loggedInDriver.tr(),
      subMessage: LocaleKeys.driverNextPhase.tr(),
    );
  }
}
