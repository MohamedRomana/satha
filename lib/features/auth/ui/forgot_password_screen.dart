import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extentions.dart';
import '../../../core/helper/validators.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/satha_field.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/models/user_role.dart';
import '../logic/forgot_password/forgot_password_cubit.dart';
import '../logic/forgot_password/forgot_password_state.dart';
import '../logic/otp/otp_cubit.dart';
import 'widgets/auth_scaffold.dart';

/// شاشة استعادة كلمة المرور (مشتركة بين الأدوار).
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    return AuthScaffold(
      title: LocaleKeys.resetPasswordTitle.tr(),
      subtitle: LocaleKeys.resetPasswordDesc.tr(),
      onBack: () => context.pop(),
      child: Form(
        key: cubit.formKey,
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (msg) => showFlashMessage(
                message: msg,
                type: FlashMessageType.error,
                context: context,
              ),
              success: (identifier) => context.pushNamed(
                Routes.otpVerification,
                arguments: {
                  'identifier': identifier,
                  'purpose': OtpPurpose.reset,
                  'role': cubit.role.key,
                },
              ),
            );
          },
          builder: (context, state) {
            final loading =
                state.maybeWhen(loading: () => true, orElse: () => false);
            return Column(
              children: [
                SathaField(
                  controller: cubit.identifierController,
                  label: LocaleKeys.phoneOrEmail.tr(),
                  prefixIcon: Icons.alternate_email_rounded,
                  textInputAction: TextInputAction.done,
                  validator: Validators.phoneOrEmail,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.sendOtp.tr(),
                  loading: loading,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.sendCode();
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
