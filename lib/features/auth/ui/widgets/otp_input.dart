import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/colors.dart';
import '../../../../gen/fonts.gen.dart';

/// حقل إدخال رمز التحقق (6 خانات) بأنميشن سلس عند الكتابة.
class SathaOtpInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const SathaOtpInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        controller: controller,
        autoDisposeControllers: false,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        animationType: AnimationType.scale,
        animationDuration: const Duration(milliseconds: 250),
        enableActiveFill: true,
        cursorColor: AppColors.orange,
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: AppColors.mainText,
          fontFamily: FontFamily.tajawalBold,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(14.r),
          fieldHeight: 54.h,
          fieldWidth: 46.w,
          borderWidth: 1.4,
          activeColor: AppColors.orange,
          selectedColor: AppColors.orange,
          inactiveColor: AppColors.border,
          activeFillColor: AppColors.softOrange,
          selectedFillColor: Colors.white,
          inactiveFillColor: AppColors.lightBg,
        ),
        onChanged: onChanged ?? (_) {},
        onCompleted: onCompleted,
      ),
    );
  }
}
