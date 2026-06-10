import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';

/// عنوان ووصف موحّد لكل خطوة في تدفّق الطلب.
class OrderStepHeader extends StatelessWidget {
  final String title;
  final String description;
  const OrderStepHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 19.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          description,
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.5,
            color: AppColors.secondaryText,
            fontFamily: FontFamily.tajawalRegular,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
