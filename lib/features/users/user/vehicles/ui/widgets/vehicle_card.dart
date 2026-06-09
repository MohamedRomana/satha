import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/vehicle_model.dart';
import 'vehicle_image.dart';

/// بطاقة سيارة في القائمة.
class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback onTap;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: vehicle.isDefault
                ? AppColors.orange.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                VehicleImage(
                  imagePath: vehicle.imagePath,
                  heroTag: 'vehicle_${vehicle.id}',
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              vehicle.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.mainText,
                                fontFamily: FontFamily.tajawalBold,
                              ),
                            ),
                          ),
                          if (vehicle.isDefault) ...[
                            SizedBox(width: 8.w),
                            _DefaultBadge(),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${vehicle.brand} ${vehicle.model} • ${vehicle.year}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          color: AppColors.secondaryText,
                          fontFamily: FontFamily.tajawalRegular,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          AppSvgIcon(
                            assetPath: AppIcons.carPlate,
                            size: 15.w,
                            color: AppColors.secondaryText,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            vehicle.plateNumber,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.mainText,
                              fontFamily: FontFamily.tajawalMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Row(
                children: [
                  if (!vehicle.isDefault)
                    Expanded(
                      child: _ActionButton(
                        icon: AppIcons.checkCircle,
                        label: LocaleKeys.vehSetDefault.tr(),
                        color: AppColors.navy,
                        onTap: onSetDefault,
                      ),
                    )
                  else
                    const Spacer(),
                  SizedBox(width: 10.w),
                  _ActionButton(
                    icon: AppIcons.delete,
                    label: LocaleKeys.delete.tr(),
                    color: AppColors.error,
                    onTap: onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.softOrange,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        LocaleKeys.vehDefaultBadge.tr(),
        style: TextStyle(
          fontSize: 9.5.sp,
          color: AppColors.orange,
          fontFamily: FontFamily.tajawalBold,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgIcon(assetPath: icon, size: 16.w, color: color),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: color,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
