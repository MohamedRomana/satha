import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/helper/validators.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/password_field.dart';
import 'package:satha/core/widgets/password_strength_bar.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/auth/reset_password/logic/reset_password_cubit.dart';
import 'package:satha/features/auth/reset_password/logic/reset_password_state.dart';
import 'package:satha/features/auth/widgets/animated_success_dialog.dart';
import 'package:satha/features/auth/widgets/auth_scaffold.dart';

/// شاشة إنشاء كلمة مرور جديدة بعد التحقق.
class ResetPasswordScreen extends StatelessWidget {
  final String role;
  const ResetPasswordScreen({super.key, required this.role});

  String _loginRoute() {
    switch (UserRoleX.fromKey(role)) {
      case UserRole.driver:
        return Routes.driverLogin;
      case UserRole.admin:
        return Routes.adminLogin;
      case UserRole.customer:
        return Routes.customerLogin;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    return AuthScaffold(
      title: LocaleKeys.newPasswordTitle.tr(),
      subtitle: LocaleKeys.create_new_password.tr(),
      onBack: () => context.pop(),
      child: Form(
        key: cubit.formKey,
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (msg) => showFlashMessage(
                message: msg,
                type: FlashMessageType.error,
                context: context,
              ),
              success: () => AnimatedSuccessSheet.show(
                context,
                message: LocaleKeys.passwordUpdated.tr(),
                buttonText: LocaleKeys.backToLoginScreen.tr(),
                onButtonPressed: () => context.pushNamedAndRemoveUntil(
                  _loginRoute(),
                  predicate: (route) => route.settings.name == Routes.roleSelection,
                ),
              ),
            );
          },
          builder: (context, state) {
            final loading =
                state.maybeWhen(loading: () => true, orElse: () => false);
            return Column(
              children: [
                SathaPasswordField(
                  controller: cubit.passwordController,
                  label: LocaleKeys.newPasswordField.tr(),
                  validator: Validators.password,
                  onChanged: cubit.onPasswordChanged,
                ),
                PasswordStrengthBar(password: cubit.passwordController.text),
                SizedBox(height: 14.h),
                SathaPasswordField(
                  controller: cubit.confirmController,
                  label: LocaleKeys.confirmNewPassword.tr(),
                  textInputAction: TextInputAction.done,
                  validator: (v) => Validators.confirmPassword(
                    v,
                    cubit.passwordController.text,
                  ),
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.savePassword.tr(),
                  loading: loading,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.submit();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
