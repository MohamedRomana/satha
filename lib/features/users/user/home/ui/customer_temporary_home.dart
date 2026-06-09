import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/users/shared/temporary_home_view.dart';

/// وجهة مؤقتة للعميل بعد تسجيل الدخول.
class CustomerTemporaryHomeScreen extends StatelessWidget {
  const CustomerTemporaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryHomeView(
      role: UserRole.customer,
      icon: Icons.directions_car_filled_rounded,
      title: LocaleKeys.welcomeSatha.tr(),
      message: LocaleKeys.loggedInCustomer.tr(),
      subMessage: LocaleKeys.homeNextPhase.tr(),
    );
  }
}
