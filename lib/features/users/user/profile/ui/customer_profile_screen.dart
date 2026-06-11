import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/profile_menu_item.dart';

/// شاشة الملف الشخصي للعميل (قائمة).
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
        title: Text(
          LocaleKeys.logout.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        content: Text(
          LocaleKeys.logOutSubtitle.tr(),
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.secondaryText,
            fontFamily: FontFamily.tajawalRegular,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              LocaleKeys.cancel.tr(),
              style: const TextStyle(color: AppColors.navy),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              LocaleKeys.logout.tr(),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await CacheHelper.clearData();
      if (context.mounted) {
        context.pushNamedAndRemoveUntil(
          Routes.roleSelection,
          predicate: (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = CacheHelper.getUserName();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.navAccount.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.navy, AppColors.navy2],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_rounded,
                        color: Colors.white, size: 34.w),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isEmpty ? LocaleKeys.customer.tr() : name,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          LocaleKeys.loginAsCustomer.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _card([
              ProfileMenuItem(
                icon: Icons.person_outline_rounded,
                label: LocaleKeys.editProfileMenu.tr(),
                onTap: () => context.pushNamed(Routes.editProfile),
              ),
              ProfileMenuItem(
                icon: Icons.lock_outline_rounded,
                label: LocaleKeys.changePasswordMenu.tr(),
                onTap: () => context.pushNamed(Routes.changePassword),
              ),
              ProfileMenuItem(
                icon: Icons.notifications_outlined,
                label: LocaleKeys.notifications.tr(),
                onTap: () => context.pushNamed(Routes.notifications),
              ),
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                label: LocaleKeys.settingsMenu.tr(),
                onTap: () => context.pushNamed(Routes.customerSettings),
              ),
            ]),
            SizedBox(height: 14.h),
            _card([
              ProfileMenuItem(
                icon: Icons.info_outline_rounded,
                label: LocaleKeys.about_us.tr(),
                onTap: () => context.pushNamed(Routes.aboutUs),
              ),
              ProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                label: LocaleKeys.privacy_policy.tr(),
                onTap: () => context.pushNamed(Routes.privacyPolicy),
              ),
              ProfileMenuItem(
                icon: Icons.description_outlined,
                label: LocaleKeys.terms_conditions.tr(),
                onTap: () => context.pushNamed(Routes.termsConditions),
              ),
              ProfileMenuItem(
                icon: Icons.help_outline_rounded,
                label: LocaleKeys.faq.tr(),
                onTap: () => context.pushNamed(Routes.qa),
              ),
            ]),
            SizedBox(height: 14.h),
            _card([
              ProfileMenuItem(
                icon: Icons.headset_mic_outlined,
                label: LocaleKeys.support.tr(),
                onTap: () => context.pushNamed(Routes.support),
              ),
              ProfileMenuItem(
                icon: Icons.mail_outline_rounded,
                label: LocaleKeys.contact_us.tr(),
                onTap: () => context.pushNamed(Routes.contactUs),
              ),
              ProfileMenuItem(
                icon: Icons.flag_outlined,
                label: LocaleKeys.reportIssue.tr(),
                onTap: () => context.pushNamed(Routes.reportIssue),
              ),
            ]),
            SizedBox(height: 14.h),
            _card([
              ProfileMenuItem(
                icon: Icons.logout_rounded,
                label: LocaleKeys.logout.tr(),
                color: AppColors.error,
                showChevron: false,
                onTap: () => _logout(context),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(children: children),
  );
}
