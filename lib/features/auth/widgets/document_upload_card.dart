import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// بطاقة رفع مستند: أيقونة + اسم + معاينة + استبدال/إزالة + حالة نجاح.
class DocumentUploadCard extends StatelessWidget {
  final String title;
  final File? file;
  final bool isRequired;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const DocumentUploadCard({
    super.key,
    required this.title,
    required this.file,
    required this.onPick,
    required this.onRemove,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = file != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: hasFile ? AppColors.softOrange.withValues(alpha: 0.5) : AppColors.lightBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: hasFile ? AppColors.orange : AppColors.border,
          width: hasFile ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          _thumb(hasFile),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.mainText,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    ),
                    if (isRequired)
                      Text(
                        ' *',
                        style: TextStyle(color: AppColors.error, fontSize: 13.sp),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: hasFile
                      ? Row(
                          key: const ValueKey('done'),
                          children: [
                            Icon(Icons.check_circle_rounded,
                                color: AppColors.success, size: 15.w),
                            SizedBox(width: 4.w),
                            Text(
                              LocaleKeys.uploadSuccess.tr(),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          LocaleKeys.tapToUpload.tr(),
                          key: const ValueKey('empty'),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.secondaryText,
                          ),
                        ),
                ),
              ],
            ),
          ),
          if (hasFile)
            Row(
              children: [
                _action(Icons.refresh_rounded, AppColors.navy, onPick),
                SizedBox(width: 4.w),
                _action(Icons.delete_outline_rounded, AppColors.error, onRemove),
              ],
            )
          else
            _action(Icons.upload_rounded, AppColors.orange, onPick),
        ],
      ),
    );
  }

  Widget _thumb(bool hasFile) {
    return Container(
      width: 48.w,
      height: 48.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: hasFile
          ? Image.file(file!, fit: BoxFit.cover)
          : Icon(Icons.description_outlined,
              color: AppColors.secondaryText, size: 22.w),
    );
  }

  Widget _action(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: color, size: 18.w),
      ),
    );
  }
}
