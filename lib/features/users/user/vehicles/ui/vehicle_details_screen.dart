import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/vehicle_model.dart';
import '../data/repos/vehicles_repository.dart';
import 'widgets/vehicle_delete_dialog.dart';
import 'widgets/vehicle_image.dart';

/// تفاصيل السيارة.
class VehicleDetailsScreen extends StatefulWidget {
  final VehicleModel vehicle;
  const VehicleDetailsScreen({super.key, required this.vehicle});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  late VehicleModel _vehicle = widget.vehicle;
  bool _busy = false;

  VehiclesRepository get _repo => getIt<VehiclesRepository>();

  Future<void> _setDefault() async {
    setState(() => _busy = true);
    await _repo.setDefault(_vehicle.id);
    if (!mounted) return;
    setState(() {
      _vehicle = _vehicle.copyWith(isDefault: true);
      _busy = false;
    });
    showFlashMessage(
      message: LocaleKeys.defaultVehicleSetMsg.tr(),
      type: FlashMessageType.success,
      context: context,
    );
  }

  Future<void> _delete() async {
    final confirmed = await VehicleDeleteDialog.show(context);
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    await _repo.deleteVehicle(_vehicle.id);
    if (!mounted) return;
    context.pop(true);
  }

  Future<void> _edit() async {
    final updated = await context.pushNamed(
      Routes.editVehicle,
      arguments: {'vehicle': _vehicle},
    );
    if (updated is VehicleModel && mounted) {
      setState(() => _vehicle = updated);
    } else if (updated == true && mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.vehicleDetailsTitle.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _busy ? null : _edit,
            icon: AppSvgIcon(
              assetPath: AppIcons.edit,
              size: 22.w,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: VehicleImage(
              imagePath: _vehicle.imagePath,
              heroTag: 'vehicle_${_vehicle.id}',
              size: 140,
              radius: 28,
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: Text(
              _vehicle.name,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ),
          if (_vehicle.isDefault)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    LocaleKeys.vehDefaultBadge.tr(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.orange,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 22.h),
          _DetailCard(
            rows: [
              (AppIcons.car, LocaleKeys.vehBrand.tr(), _vehicle.brand),
              (AppIcons.car, LocaleKeys.vehModel.tr(), _vehicle.model),
              (AppIcons.car, LocaleKeys.vehYear.tr(), '${_vehicle.year}'),
              (AppIcons.carColor, LocaleKeys.vehColor.tr(), _vehicle.color),
              (AppIcons.carPlate, LocaleKeys.vehPlate.tr(), _vehicle.plateNumber),
              (AppIcons.chassis, LocaleKeys.vehChassis.tr(), _vehicle.chassisNumber),
              (AppIcons.car, LocaleKeys.vehCategory.tr(),
                  _vehicle.category.labelKey.tr()),
              if (_vehicle.notes != null && _vehicle.notes!.isNotEmpty)
                (AppIcons.edit, LocaleKeys.notes.tr(), _vehicle.notes!),
            ],
          ),
          SizedBox(height: 24.h),
          if (!_vehicle.isDefault)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: PrimaryButton(
                text: LocaleKeys.vehSetDefault.tr(),
                icon: Icons.check_circle_outline_rounded,
                loading: _busy,
                onPressed: _setDefault,
              ),
            ),
          OutlinedButton.icon(
            onPressed: _busy ? null : _delete,
            icon: AppSvgIcon(
              assetPath: AppIcons.delete,
              size: 20.w,
              color: AppColors.error,
            ),
            label: Text(
              LocaleKeys.deleteVehicleConfirm.tr(),
              style: TextStyle(
                color: AppColors.error,
                fontSize: 15.sp,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 54.h),
              side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final List<(String, String, String)> rows;
  const _DetailCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, color: AppColors.border),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  AppSvgIcon(
                    assetPath: rows[i].$1,
                    size: 20.w,
                    color: AppColors.orange,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    rows[i].$2,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      rows[i].$3,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        color: AppColors.mainText,
                        fontFamily: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
