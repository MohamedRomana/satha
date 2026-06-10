import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../vehicles/data/models/vehicle_model.dart';
import '../../../vehicles/ui/widgets/vehicle_image.dart';

/// بطاقة اختيار سيارة في تدفّق الطلب.
class SelectableVehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final bool selected;
  final VoidCallback onTap;
  const SelectableVehicleCard({
    super.key,
    required this.vehicle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.softOrange.withValues(alpha: 0.6)
              : AppColors.card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.border,
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            VehicleImage(
              imagePath: vehicle.imagePath,
              heroTag: 'order_vehicle_${vehicle.id}',
              size: 56,
              radius: 14,
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
                            fontSize: 14.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                      ),
                      if (vehicle.isDefault) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softOrange,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            LocaleKeys.vehDefaultBadge.tr(),
                            style: TextStyle(
                              fontSize: 8.5.sp,
                              color: AppColors.orange,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${vehicle.brand} ${vehicle.model} • ${vehicle.plateNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedScale(
              scale: selected ? 1 : 0,
              duration: const Duration(milliseconds: 220),
              child: AppSvgIcon(
                assetPath: AppIcons.checkCircle,
                size: 22.w,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
