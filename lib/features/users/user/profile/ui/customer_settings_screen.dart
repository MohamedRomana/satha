import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/theme/theme_cubit.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/profile_menu_item.dart';

/// شاشة إعدادات العميل.
class CustomerSettingsScreen extends StatefulWidget {
  const CustomerSettingsScreen({super.key});

  @override
  State<CustomerSettingsScreen> createState() => _CustomerSettingsScreenState();
}

class _CustomerSettingsScreenState extends State<CustomerSettingsScreen> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.settingsMenu.tr(),
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
            _card([
              ProfileMenuItem(
                icon: Icons.language_rounded,
                label: LocaleKeys.language.tr(),
                onTap: () => context.pushNamed(Routes.language),
              ),
            ]),
            SizedBox(height: 14.h),
            _card([
              _switchRow(
                icon: Icons.dark_mode_outlined,
                label: LocaleKeys.darkMode.tr(),
                value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                onChanged: (_) => context.read<ThemeCubit>().toggle(
                  context.read<ThemeCubit>().state == ThemeMode.dark,
                ),
              ),
              _switchRow(
                icon: Icons.notifications_active_outlined,
                label: LocaleKeys.receive_notifications.tr(),
                value: _notifications,
                onChanged: (v) => setState(() => _notifications = v),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _switchRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.navy.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColors.navy, size: 22.w),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.orange,
          ),
        ],
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
