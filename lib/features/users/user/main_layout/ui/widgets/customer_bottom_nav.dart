import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

class _NavItem {
  final String icon;
  final String labelKey;
  const _NavItem(this.icon, this.labelKey);
}

/// شريط تنقّل سفلي متحرّك بأيقونات SVG (5 تبويبات).
class CustomerBottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const CustomerBottomNav({
    super.key,
    required this.current,
    required this.onTap,
  });

  static const _items = [
    _NavItem(AppIcons.home, LocaleKeys.navHome),
    _NavItem(AppIcons.orders, LocaleKeys.navOrders),
    _NavItem(AppIcons.vehicles, LocaleKeys.navVehicles),
    _NavItem(AppIcons.chat, LocaleKeys.navChats),
    _NavItem(AppIcons.profile, LocaleKeys.navAccount),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < _items.length; i++)
                _NavButton(
                  item: _items[i],
                  active: i == current,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTap(i);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool active;
  final VoidCallback onTap;
  const _NavButton({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.orange : AppColors.secondaryText;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active ? AppColors.softOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvgIcon(assetPath: item.icon, size: 23.w, color: color),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: active
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(start: 6.w),
                      child: Text(
                        item.labelKey.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.orange,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
