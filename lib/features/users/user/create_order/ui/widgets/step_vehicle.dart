import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../logic/create_order_cubit.dart';
import 'order_step_header.dart';
import 'selectable_vehicle_card.dart';

/// الخطوة 2: اختيار السيارة.
class StepVehicle extends StatelessWidget {
  final CreateOrderCubit cubit;
  final VoidCallback onAddVehicle;
  const StepVehicle({
    super.key,
    required this.cubit,
    required this.onAddVehicle,
  });

  @override
  Widget build(BuildContext context) {
    if (cubit.loadingVehicles) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.orange),
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      children: [
        OrderStepHeader(
          title: LocaleKeys.chooseVehicleTitle.tr(),
          description: LocaleKeys.chooseVehicleDesc.tr(),
        ),
        if (cubit.vehicles.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              LocaleKeys.addNoVehicleHint.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalRegular,
              ),
            ),
          )
        else
          for (final v in cubit.vehicles) ...[
            SelectableVehicleCard(
              vehicle: v,
              selected: cubit.vehicle?.id == v.id,
              onTap: () => cubit.selectVehicle(v),
            ),
            SizedBox(height: 12.h),
          ],
        SizedBox(height: 6.h),
        _AddVehicleButton(onTap: onAddVehicle),
      ],
    );
  }
}

class _AddVehicleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddVehicleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.orange.withValues(alpha: 0.5),
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgIcon(
              assetPath: AppIcons.add,
              size: 20.w,
              color: AppColors.orange,
            ),
            SizedBox(width: 8.w),
            Text(
              LocaleKeys.addNewVehicle.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.orange,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
