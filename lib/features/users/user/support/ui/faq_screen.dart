import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/repos/support_repository.dart';
import 'widgets/faq_card.dart';

/// شاشة الأسئلة الشائعة.
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = getIt<SupportRepository>().getFaqs();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.faq.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: faqs.length,
          itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
            position: i,
            duration: const Duration(milliseconds: 350),
            child: SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(child: FaqCard(faq: faqs[i])),
            ),
          ),
        ),
      ),
    );
  }
}
