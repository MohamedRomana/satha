import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/shared/coming_soon_view.dart';

/// تبويب السيارات المؤقّت (يُستبدل في المرحلة 2).
class CustomerVehiclesPlaceholderScreen extends StatelessWidget {
  const CustomerVehiclesPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonView(
      title: LocaleKeys.navVehicles.tr(),
      icon: AppIcons.vehicles,
    );
  }
}
