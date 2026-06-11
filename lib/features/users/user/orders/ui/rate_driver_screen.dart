import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/order_model.dart';
import '../logic/rating/rating_cubit.dart';
import '../logic/rating/rating_state.dart';
import 'widgets/animated_star_rating.dart';

/// شاشة تقييم السائق بعد إتمام الرحلة.
class RateDriverScreen extends StatelessWidget {
  final OrderModel order;
  const RateDriverScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RatingCubit(),
      child: _RatingView(order: order),
    );
  }
}

class _RatingView extends StatefulWidget {
  final OrderModel order;
  const _RatingView({required this.order});

  @override
  State<_RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<_RatingView> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _goHome() {
    Navigator.of(
      context,
    ).popUntil((r) => r.settings.name == Routes.customerHome);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RatingCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.rateDriver.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<RatingCubit, RatingState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              showFlashMessage(
                message: LocaleKeys.ratingSuccess.tr(),
                type: FlashMessageType.success,
                context: context,
              );
              _goHome();
            },
            error: (code) {
              if (code == 'no_stars') {
                showFlashMessage(
                  message: LocaleKeys.selectRatingRequired.tr(),
                  type: FlashMessageType.warning,
                  context: context,
                );
              }
            },
          );
        },
        builder: (context, state) {
          final submitting = state is RatingSubmitting;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
            child: Column(
              children: [
                Container(
                  width: 84.w,
                  height: 84.w,
                  decoration: const BoxDecoration(
                    color: AppColors.softOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: AppColors.orange,
                    size: 44.w,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  widget.order.driverName ?? LocaleKeys.assignedDriver.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  LocaleKeys.howWasExperience.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  LocaleKeys.ratingHelps.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.5,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
                SizedBox(height: 24.h),
                AnimatedStarRating(
                  value: cubit.stars,
                  onChanged: cubit.setStars,
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  onChanged: (v) => cubit.comment = v,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.additional_comments.tr(),
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
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.submit_review.tr(),
                  loading: submitting,
                  onPressed: cubit.submit,
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: _goHome,
                  child: Text(
                    LocaleKeys.skip.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
