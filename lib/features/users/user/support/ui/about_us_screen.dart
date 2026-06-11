import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/static_content_view.dart';

/// شاشة "من نحن".
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticContentView(
      title: LocaleKeys.about_us.tr(),
      content: LocaleKeys.aboutUsContent.tr(),
    );
  }
}
