import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_constants.dart';
import 'package:satha/core/helper/validators.dart';
import 'package:satha/core/widgets/password_field.dart';
import 'package:satha/core/widgets/password_strength_bar.dart';
import 'package:satha/core/widgets/satha_dropdown.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';
import 'package:satha/features/auth/widgets/profile_image_picker.dart';

/// الخطوة 1 من تسجيل السائق — البيانات الشخصية.
class DriverStepPersonal extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const DriverStepPersonal({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ProfileImagePicker(
              image: cubit.profileImage,
              onTap: cubit.pickProfileImage,
              label: LocaleKeys.profile_image.tr(),
            ),
          ),
          SizedBox(height: 18.h),
          SathaField(
            controller: cubit.nameController,
            label: LocaleKeys.fullName.tr(),
            prefixIcon: Icons.person_outline_rounded,
            validator: Validators.fullName,
          ),
          SizedBox(height: 14.h),
          SathaPhoneField(
            controller: cubit.phoneController,
            label: LocaleKeys.phone.tr(),
            validator: Validators.phone,
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.emailController,
            label: LocaleKeys.email.tr(),
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          SizedBox(height: 14.h),
          SathaPasswordField(
            controller: cubit.passwordController,
            label: LocaleKeys.password.tr(),
            validator: Validators.password,
            onChanged: cubit.onPasswordChanged,
          ),
          PasswordStrengthBar(password: cubit.passwordController.text),
          SizedBox(height: 14.h),
          SathaPasswordField(
            controller: cubit.confirmController,
            label: LocaleKeys.confirmPassword.tr(),
            validator: (v) =>
                Validators.confirmPassword(v, cubit.passwordController.text),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.nationalIdController,
            label: LocaleKeys.nationalIdNumber.tr(),
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.nationalIdRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaDropdown<String>(
            label: LocaleKeys.city.tr(),
            hint: LocaleKeys.selectCity.tr(),
            value: cubit.city,
            prefixIcon: Icons.location_city_rounded,
            items: [
              for (final c in AppConstants.cities)
                DropdownMenuItem(value: c, child: Text(c)),
            ],
            onChanged: cubit.selectCity,
          ),
        ],
      ),
    );
  }
}
