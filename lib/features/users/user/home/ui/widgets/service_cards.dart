import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/features/users/user/home/data/models/home_models.dart';

/// قسم خدمات السطحة (بطاقتان) مع أنميشن ضغط.
class ServiceCards extends StatelessWidget {
  final List<CustomerServiceItem> services;
  final void Function(CustomerServiceType type) onSelect;
  const ServiceCards({super.key, required this.services, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < services.length; i++) ...[
          if (i > 0) SizedBox(width: 12.w),
          Expanded(
            child: _ServiceCard(
              item: services[i],
              onTap: () => onSelect(services[i].type),
            ),
          ),
        ],
      ],
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final CustomerServiceItem item;
  final VoidCallback onTap;
  const _ServiceCard({required this.item, required this.onTap});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 130),
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.softOrange,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: AppSvgIcon(
                    assetPath: widget.item.icon,
                    size: 28.w,
                    color: AppColors.orange,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                widget.item.titleKey.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                widget.item.descKey.tr(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  height: 1.5,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
