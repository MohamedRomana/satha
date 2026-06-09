import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/helper/validators.dart';
import 'package:satha/core/widgets/satha_dropdown.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';
import 'package:satha/features/auth/widgets/profile_image_picker.dart';

/// الخطوة 2 من تسجيل السائق — بيانات السطحة.
class DriverStepTow extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const DriverStepTow({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.step2FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ProfileImagePicker(
              image: cubit.vehicleImage,
              onTap: cubit.pickVehicleImage,
              label: LocaleKeys.vehicleImage.tr(),
            ),
          ),
          SizedBox(height: 18.h),
          SathaField(
            controller: cubit.towNameController,
            label: LocaleKeys.towTruckName.tr(),
            prefixIcon: Icons.local_shipping_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.towTruckNameRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaDropdown<String>(
            label: LocaleKeys.towTruckType.tr(),
            hint: LocaleKeys.towTruckType.tr(),
            value: cubit.towType,
            prefixIcon: Icons.category_outlined,
            items: [
              DropdownMenuItem(
                value: 'normal',
                child: Text(LocaleKeys.normalTow.tr()),
              ),
              DropdownMenuItem(
                value: 'hydraulic',
                child: Text(LocaleKeys.hydraulicTow.tr()),
              ),
            ],
            onChanged: cubit.selectTowType,
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.plateController,
            label: LocaleKeys.plateNumber.tr(),
            prefixIcon: Icons.confirmation_number_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.plateNumberRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.vehicleModelController,
            label: LocaleKeys.vehicleModelField.tr(),
            prefixIcon: Icons.directions_car_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.vehicleModelRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.vehicleColorController,
            label: LocaleKeys.vehicleColor.tr(),
            prefixIcon: Icons.palette_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.vehicleColorRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.maxWeightController,
            label: LocaleKeys.maxWeight.tr(),
            prefixIcon: Icons.scale_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
