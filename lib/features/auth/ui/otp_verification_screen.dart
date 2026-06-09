import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helper/extentions.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/models/user_role.dart';
import '../logic/otp/otp_cubit.dart';
import '../logic/otp/otp_state.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/otp_input.dart';

/// شاشة تأكيد رمز التحقق (تسجيل عميل أو استعادة كلمة مرور).
class OtpVerificationScreen extends StatelessWidget {
  final String role;
  const OtpVerificationScreen({super.key, required this.role});

  String _homeRoute() {
    switch (UserRoleX.fromKey(role)) {
      case UserRole.driver:
        return Routes.driverHome;
      case UserRole.admin:
        return Routes.adminHome;
      case UserRole.customer:
        return Routes.customerHome;
    }
  }

  void _onVerified(BuildContext context, OtpCubit cubit) {
    if (cubit.purpose == OtpPurpose.register) {
      context.pushNamedAndRemoveUntil(_homeRoute(), predicate: (_) => false);
    } else {
      context.pushReplacementNamed(
        Routes.resetPassword,
        arguments: {
          'identifier': cubit.identifier,
          'code': cubit.codeController.text.trim(),
          'role': role,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();
    return AuthScaffold(
      title: LocaleKeys.otpTitle.tr(),
      subtitle: '${LocaleKeys.otpDesc.tr()}\n${cubit.identifier}',
      onBack: () => context.pop(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (msg) => showFlashMessage(
              message: msg,
              type: FlashMessageType.error,
              context: context,
            ),
            verified: () => _onVerified(context, cubit),
          );
        },
        builder: (context, state) {
          final loading =
              state.maybeWhen(loading: () => true, orElse: () => false);
          return Column(
            children: [
              SathaOtpInput(controller: cubit.codeController),
              SizedBox(height: 16.h),
              _resendRow(context, cubit),
              SizedBox(height: 24.h),
              PrimaryButton(
                text: LocaleKeys.verify.tr(),
                loading: loading,
                onPressed: () {
                  if (cubit.codeController.text.trim().length < 6) {
                    showFlashMessage(
                      message: LocaleKeys.otpRequired.tr(),
                      type: FlashMessageType.warning,
                      context: context,
                    );
                    return;
                  }
                  cubit.verify();
                },
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  LocaleKeys.changePhoneEmail.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.navy,
                    fontFamily: FontFamily.tajawalMedium,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _resendRow(BuildContext context, OtpCubit cubit) {
    return cubit.canResend
        ? TextButton(
            onPressed: cubit.resend,
            child: Text(
              LocaleKeys.resendCode.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.orange,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          )
        : Text(
            '${LocaleKeys.resendCodeIn.tr()} ${cubit.remainingSeconds}',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          );
  }
}
