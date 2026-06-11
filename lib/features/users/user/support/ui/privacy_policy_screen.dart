import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/static_content_view.dart';

/// شاشة سياسة الخصوصية.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticContentView(
      title: LocaleKeys.privacy_policy.tr(),
      content: LocaleKeys.privacyContent.tr(),
    );
  }
}
