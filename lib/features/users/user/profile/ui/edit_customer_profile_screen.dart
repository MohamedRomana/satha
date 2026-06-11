import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/logic/action_state.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/image_source_sheet.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../logic/edit_profile_cubit.dart';

/// شاشة تعديل الملف الشخصي.
class EditCustomerProfileScreen extends StatelessWidget {
  const EditCustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  Future<void> _pickAvatar(BuildContext context) async {
    final cubit = context.read<EditProfileCubit>();
    final source = await ImageSourceSheet.show(context);
    if (source == null) return;
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) cubit.setAvatar(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.editProfileMenu.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<EditProfileCubit, ActionState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              showFlashMessage(
                message: LocaleKeys.profileUpdated.tr(),
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
                  GestureDetector(
                    onTap: () => _pickAvatar(context),
                    child: Stack(
                      children: [
                        Container(
                          width: 96.w,
                          height: 96.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.softOrange,
                            shape: BoxShape.circle,
                          ),
                          child: cubit.avatar != null
                              ? Image.file(cubit.avatar!, fit: BoxFit.cover)
                              : Icon(Icons.person_rounded,
                                  color: AppColors.orange, size: 50.w),
                        ),
                        PositionedDirectional(
                          end: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              color: AppColors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.camera_alt_rounded,
                                color: Colors.white, size: 16.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
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
                    controller: cubit.phoneController,
                    label: LocaleKeys.phone.tr(),
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 14.h),
                  SathaField(
                    controller: cubit.emailController,
                    label: LocaleKeys.email.tr(),
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 28.h),
                  PrimaryButton(
                    text: LocaleKeys.save_changes.tr(),
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
