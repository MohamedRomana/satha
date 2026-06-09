import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extentions.dart';
import '../../../core/helper/validators.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/satha_field.dart';
import '../../../generated/locale_keys.g.dart';
import '../logic/login/login_cubit.dart';
import '../logic/login/login_state.dart';
import 'widgets/auth_scaffold.dart';

/// شاشة دخول الإدارة — أكثر رسمية (إيميل + كلمة مرور فقط).
class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return AuthScaffold(
      title: LocaleKeys.adminLogin.tr(),
      subtitle: LocaleKeys.adminLoginDesc.tr(),
      onBack: () => context.pop(),
      showLangToggle: false,
      child: Form(
        key: cubit.formKey,
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (msg) => showFlashMessage(
                message: msg,
                type: FlashMessageType.error,
                context: context,
              ),
              success: (_) => context.pushNamedAndRemoveUntil(
                Routes.adminHome,
                predicate: (_) => false,
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
                  label: LocaleKeys.email.tr(),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 16.h),
                SathaPasswordField(
                  controller: cubit.passwordController,
                  label: LocaleKeys.password.tr(),
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 28.h),
                PrimaryButton(
                  text: LocaleKeys.loginTitle.tr(),
                  loading: loading,
                  icon: Icons.lock_open_rounded,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.login();
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
