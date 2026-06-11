import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شريط التنقّل أسفل تسجيل السائق (السابق + التالي/تأكيد).
class DriverRegisterNavBar extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool loading;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const DriverRegisterNavBar({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.loading,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(0, 54.h),
                side: BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                LocaleKeys.previous.tr(),
                style: TextStyle(
                  color: AppColors.navy,
                  fontFamily: FontFamily.tajawalBold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: PrimaryButton(
              text: isLast
                  ? LocaleKeys.confirmAndSubmit.tr()
                  : LocaleKeys.next.tr(),
              loading: loading,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
