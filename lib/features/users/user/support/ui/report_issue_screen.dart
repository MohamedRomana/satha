import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/logic/action_state.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/image_source_sheet.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/support_models.dart';
import '../logic/report_issue_cubit.dart';

/// شاشة الإبلاغ عن مشكلة.
class ReportIssueScreen extends StatelessWidget {
  final String? orderId;
  const ReportIssueScreen({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportIssueCubit(getIt())..orderId = orderId,
      child: const _ReportIssueView(),
    );
  }
}

class _ReportIssueView extends StatefulWidget {
  const _ReportIssueView();

  @override
  State<_ReportIssueView> createState() => _ReportIssueViewState();
}

class _ReportIssueViewState extends State<_ReportIssueView> {
  Future<void> _pickScreenshot(BuildContext context) async {
    final cubit = context.read<ReportIssueCubit>();
    final source = await ImageSourceSheet.show(context);
    if (source == null) return;
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) cubit.addScreenshot(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportIssueCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.reportIssue.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<ReportIssueCubit, ActionState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) => _showSuccess(context),
            error: (code) {
              final msg = code == 'category'
                  ? LocaleKeys.selectCategoryRequired.tr()
                  : code == 'description'
                  ? LocaleKeys.descriptionRequired.tr()
                  : LocaleKeys.something_went_wrong.tr();
              showFlashMessage(
                message: msg,
                type: FlashMessageType.warning,
                context: context,
              );
            },
          );
        },
        builder: (context, state) {
          final submitting = state is ActionLoading;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.complaintCategory.tr(),
                  style: _labelStyle,
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    for (final c in ComplaintCategory.values)
                      _categoryChip(context, cubit, c),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(LocaleKeys.complaintDescription.tr(), style: _labelStyle),
                SizedBox(height: 12.h),
                TextField(
                  maxLines: 5,
                  onChanged: (v) => cubit.description = v,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.complaintDescriptionHint.tr(),
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                    filled: true,
                    fillColor: AppColors.card,
                    contentPadding: EdgeInsets.all(14.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: AppColors.orange),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(LocaleKeys.attachScreenshots.tr(), style: _labelStyle),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: [
                    for (var i = 0; i < cubit.screenshots.length; i++)
                      _thumb(cubit, i),
                    if (cubit.screenshots.length < 3)
                      GestureDetector(
                        onTap: () => _pickScreenshot(context),
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.border,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Icon(Icons.add_a_photo_outlined,
                              color: AppColors.secondaryText, size: 24.w),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 28.h),
                PrimaryButton(
                  text: LocaleKeys.submitReport.tr(),
                  loading: submitting,
                  onPressed: cubit.submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _categoryChip(
    BuildContext context,
    ReportIssueCubit cubit,
    ComplaintCategory c,
  ) {
    final selected = cubit.category == c;
    return GestureDetector(
      onTap: () => cubit.selectCategory(c),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.orange : AppColors.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.border,
          ),
        ),
        child: Text(
          c.labelKey.tr(),
          style: TextStyle(
            fontSize: 13.sp,
            color: selected ? Colors.white : AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
    );
  }

  Widget _thumb(ReportIssueCubit cubit, int i) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.file(
            cubit.screenshots[i],
            width: 70.w,
            height: 70.w,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 2.h,
          end: 2.w,
          child: GestureDetector(
            onTap: () => cubit.removeScreenshot(i),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 12.w),
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded,
                    color: AppColors.success, size: 36.w),
              ),
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.reportSentTitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                LocaleKeys.reportSentDesc.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
              SizedBox(height: 20.h),
              PrimaryButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(
    fontSize: 14.sp,
    color: AppColors.mainText,
    fontFamily: FontFamily.tajawalBold,
  );
}
