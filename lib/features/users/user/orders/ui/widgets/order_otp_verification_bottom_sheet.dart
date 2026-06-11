import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/features/auth/widgets/otp_input.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../logic/otp_confirm/otp_confirm_cubit.dart';
import '../../logic/otp_confirm/otp_confirm_state.dart';

/// شيت تأكيد رمز التحقق (وصول السائق / إتمام الرحلة). يرجع true عند النجاح.
class OrderOtpVerificationBottomSheet {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => OtpConfirmCubit(),
        child: _OtpSheet(title: title, subtitle: subtitle),
      ),
    );
  }
}

class _OtpSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  const _OtpSheet({required this.title, required this.subtitle});

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
        ),
        child: BlocConsumer<OtpConfirmCubit, OtpConfirmState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () => Navigator.of(context).pop(true),
              error: (_) {
                showFlashMessage(
                  message: LocaleKeys.invalidOtp.tr(),
                  type: FlashMessageType.error,
                  context: context,
                );
                _controller.clear();
                context.read<OtpConfirmCubit>().reset();
              },
            );
          },
          builder: (context, state) {
            final verifying = state is OtpConfirmVerifying;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_rounded,
                    color: AppColors.orange,
                    size: 30.w,
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.5,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
                SizedBox(height: 20.h),
                SathaOtpInput(
                  controller: _controller,
                  onCompleted: (code) =>
                      context.read<OtpConfirmCubit>().verify(code),
                ),
                SizedBox(height: 22.h),
                PrimaryButton(
                  text: LocaleKeys.verify.tr(),
                  loading: verifying,
                  onPressed: () =>
                      context.read<OtpConfirmCubit>().verify(_controller.text),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
