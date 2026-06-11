import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';

/// عرض محتوى نصّي ثابت (من نحن / الخصوصية / الشروط).
class StaticContentView extends StatelessWidget {
  final String title;
  final String content;
  const StaticContentView({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.9,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ),
      ),
    );
  }
}
