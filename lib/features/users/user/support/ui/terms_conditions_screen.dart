import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/static_content_view.dart';

/// شاشة الشروط والأحكام.
class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticContentView(
      title: LocaleKeys.terms_conditions.tr(),
      content: LocaleKeys.termsContent.tr(),
    );
  }
}
