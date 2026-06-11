import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/repos/support_repository.dart';

/// شاشة الدعم.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _launch(BuildContext context, Uri uri) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) _failed(context);
    } catch (_) {
      if (context.mounted) _failed(context);
    }
  }

  void _failed(BuildContext context) => showFlashMessage(
    message: LocaleKeys.cannotOpenApp.tr(),
    type: FlashMessageType.warning,
    context: context,
  );

  @override
  Widget build(BuildContext context) {
    final contact = getIt<SupportRepository>().getContact();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.support.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
        child: Column(
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                color: AppColors.softOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.headset_mic_rounded,
                  color: AppColors.orange, size: 46.w),
            ),
            SizedBox(height: 14.h),
            Text(
              LocaleKeys.supportCardTitle.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              LocaleKeys.supportCardDesc.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.5,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalRegular,
              ),
            ),
            SizedBox(height: 24.h),
            _action(
              icon: Icons.call_rounded,
              color: AppColors.success,
              label: LocaleKeys.call_support.tr(),
              onTap: () => _launch(context, Uri.parse('tel:${contact.phone}')),
            ),
            _action(
              icon: Icons.chat_rounded,
              color: const Color(0xff25D366),
              label: LocaleKeys.whatsapp_support.tr(),
              onTap: () => _launch(
                context,
                Uri.parse('https://wa.me/${contact.whatsapp}'),
              ),
            ),
            _action(
              icon: Icons.mail_outline_rounded,
              color: AppColors.navy,
              label: LocaleKeys.send_message.tr(),
              onTap: () => context.pushNamed(Routes.contactUs),
            ),
            _action(
              icon: Icons.help_outline_rounded,
              color: AppColors.orange,
              label: LocaleKeys.faq.tr(),
              onTap: () => context.pushNamed(Routes.qa),
            ),
          ],
        ),
      ),
    );
  }

  Widget _action({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 22.w),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
            Icon(Icons.chevron_left_rounded,
                color: AppColors.secondaryText),
          ],
        ),
      ),
    );
  }
}
