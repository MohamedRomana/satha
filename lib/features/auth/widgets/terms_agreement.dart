import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/animated_checkbox.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'terms_sheet.dart';

/// صف الموافقة على الشروط: مربع اختيار + جملة، والضغط على "الشروط والأحكام"
/// يفتح bottom sheet بالنص الكامل.
class TermsAgreement extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TermsAgreement({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCheckbox(
      value: value,
      onChanged: onChanged,
      label: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '${LocaleKeys.agreeTermsPrefix.tr()} ',
            style: TextStyle(
              fontSize: 12.5.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
          GestureDetector(
            onTap: () => TermsSheet.show(context),
            child: Text(
              LocaleKeys.termsAndConditions.tr(),
              style: TextStyle(
                fontSize: 12.5.sp,
                color: AppColors.orange,
                fontFamily: FontFamily.tajawalBold,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
