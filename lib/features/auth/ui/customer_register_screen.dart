import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helper/extentions.dart';
import '../../../core/helper/validators.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/animated_checkbox.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/password_strength_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/satha_field.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../logic/customer_register/customer_register_cubit.dart';
import '../logic/customer_register/customer_register_state.dart';
import '../logic/otp/otp_cubit.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/profile_image_picker.dart';

/// شاشة إنشاء حساب عميل.
class CustomerRegisterScreen extends StatelessWidget {
  const CustomerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerRegisterCubit>();
    return AuthScaffold(
      title: LocaleKeys.customerRegisterTitle.tr(),
      subtitle: LocaleKeys.customerRegisterDesc.tr(),
      onBack: () => context.pop(),
      child: Form(
        key: cubit.formKey,
        child: BlocConsumer<CustomerRegisterCubit, CustomerRegisterState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (msg) => showFlashMessage(
                message: msg,
                type: FlashMessageType.error,
                context: context,
              ),
              success: (user) => context.pushNamed(
                Routes.otpVerification,
                arguments: {
                  'identifier': cubit.phoneController.text.trim(),
                  'purpose': OtpPurpose.register,
                  'user': user,
                  'role': 'customer',
                },
              ),
            );
          },
          builder: (context, state) {
            final loading =
                state.maybeWhen(loading: () => true, orElse: () => false);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfileImagePicker(
                    image: cubit.profileImage,
                    onTap: cubit.pickProfileImage,
                    label: LocaleKeys.optionalProfileImage.tr(),
                  ),
                ),
                SizedBox(height: 20.h),
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
                  textInputAction: TextInputAction.done,
                  validator: (v) => Validators.confirmPassword(
                    v,
                    cubit.passwordController.text,
                  ),
                ),
                SizedBox(height: 16.h),
                AnimatedCheckbox(
                  value: cubit.agreeTerms,
                  onChanged: cubit.toggleTerms,
                  label: Text(
                    LocaleKeys.agreeTerms.tr(),
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.createNewAccount.tr(),
                  loading: loading,
                  onPressed: () {
                    if (!cubit.formKey.currentState!.validate()) return;
                    if (!cubit.agreeTerms) {
                      showFlashMessage(
                        message: LocaleKeys.mustAcceptTerms.tr(),
                        type: FlashMessageType.warning,
                        context: context,
                      );
                      return;
                    }
                    cubit.register();
                  },
                ),
                SizedBox(height: 8.h),
                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      LocaleKeys.haveAccountLogin.tr(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.navy,
                        fontFamily: FontFamily.tajawalMedium,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
