import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/logic/action_state.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../logic/change_password_cubit.dart';

/// شاشة تغيير كلمة المرور.
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatelessWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.changePasswordMenu.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<ChangePasswordCubit, ActionState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              showFlashMessage(
                message: LocaleKeys.password_changed_successfully.tr(),
                type: FlashMessageType.success,
                context: context,
              );
              context.pop();
            },
          );
        },
        builder: (context, state) {
          final submitting = state is ActionLoading;
          return Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
              child: Column(
                children: [
                  SathaField(
                    controller: cubit.currentController,
                    label: LocaleKeys.currentPassword.tr(),
                    prefixIcon: Icons.lock_outline_rounded,
                    obscure: true,
                    validator: (v) => (v == null || v.isEmpty)
                        ? LocaleKeys.passwordValidate.tr()
                        : null,
                  ),
                  SizedBox(height: 14.h),
                  SathaField(
                    controller: cubit.newController,
                    label: LocaleKeys.newPasswordField.tr(),
                    prefixIcon: Icons.lock_reset_rounded,
                    obscure: true,
                    validator: (v) => (v == null || v.length < 8)
                        ? LocaleKeys.passwordMin8.tr()
                        : null,
                  ),
                  SizedBox(height: 14.h),
                  SathaField(
                    controller: cubit.confirmController,
                    label: LocaleKeys.confirmNewPassword.tr(),
                    prefixIcon: Icons.lock_reset_rounded,
                    obscure: true,
                    textInputAction: TextInputAction.done,
                    validator: (v) => v != cubit.newController.text
                        ? LocaleKeys.passwordsNotMatch.tr()
                        : null,
                  ),
                  SizedBox(height: 28.h),
                  PrimaryButton(
                    text: LocaleKeys.savePassword.tr(),
                    loading: submitting,
                    onPressed: cubit.submit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
