import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/logic/action_state.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../logic/contact_us_cubit.dart';

/// شاشة "تواصل معنا".
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactUsCubit(getIt()),
      child: const _ContactUsView(),
    );
  }
}

class _ContactUsView extends StatelessWidget {
  const _ContactUsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.contact_us.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<ContactUsCubit, ActionState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              showFlashMessage(
                message: LocaleKeys.messageSentSuccess.tr(),
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
                    controller: cubit.nameController,
                    label: LocaleKeys.fullName.tr(),
                    prefixIcon: Icons.person_outline_rounded,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? LocaleKeys.fullNameRequired.tr()
                        : null,
                  ),
                  SizedBox(height: 14.h),
                  SathaField(
                    controller: cubit.emailController,
                    label: LocaleKeys.email.tr(),
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? LocaleKeys.emailRequired.tr()
                        : null,
                  ),
                  SizedBox(height: 14.h),
                  SathaField(
                    controller: cubit.messageController,
                    label: LocaleKeys.messageText.tr(),
                    prefixIcon: Icons.message_outlined,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? LocaleKeys.messageValidate.tr()
                        : null,
                  ),
                  SizedBox(height: 28.h),
                  PrimaryButton(
                    text: LocaleKeys.send.tr(),
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
