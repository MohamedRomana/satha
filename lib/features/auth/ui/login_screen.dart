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
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/satha_field.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/models/user_role.dart';
import '../logic/login/login_cubit.dart';
import '../logic/login/login_state.dart';
import 'widgets/auth_scaffold.dart';

/// شاشة تسجيل دخول مشتركة للعميل والسائق (الدور يُحقن عبر [LoginCubit]).
class LoginScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String successRoute;
  final String registerRoute;

  const LoginScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.successRoute,
    required this.registerRoute,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return AuthScaffold(
      title: title.tr(),
      subtitle: subtitle.tr(),
      onBack: () => context.pop(),
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
                successRoute,
                predicate: (_) => false,
              ),
            );
          },
          builder: (context, state) {
            final loading =
                state.maybeWhen(loading: () => true, orElse: () => false);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SathaField(
                  controller: cubit.identifierController,
                  label: LocaleKeys.phoneOrEmail.tr(),
                  hint: LocaleKeys.phoneOrEmail.tr(),
                  prefixIcon: Icons.alternate_email_rounded,
                  validator: Validators.phoneOrEmail,
                ),
                SizedBox(height: 16.h),
                SathaPasswordField(
                  controller: cubit.passwordController,
                  label: LocaleKeys.password.tr(),
                  hint: LocaleKeys.password.tr(),
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedCheckbox(
                        value: cubit.rememberMe,
                        onChanged: cubit.toggleRemember,
                        label: Text(
                          LocaleKeys.rememberMe.tr(),
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: AppColors.secondaryText,
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => context.pushNamed(
                        Routes.forgotPassword,
                        arguments: {'role': cubit.role.key},
                      ),
                      child: Text(
                        LocaleKeys.forgot_password.tr(),
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          color: AppColors.orange,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.loginTitle.tr(),
                  loading: loading,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.login();
                    }
                  },
                ),
                SizedBox(height: 14.h),
                SecondaryButton(
                  text: LocaleKeys.createNewAccount.tr(),
                  onPressed: () => context.pushNamed(registerRoute),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
