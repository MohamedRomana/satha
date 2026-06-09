import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/cache/cache_helper.dart';
import '../../../core/helper/extentions.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/auth_background.dart';
import '../../../core/widgets/lang_toggle.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/models/onboarding_item_model.dart';
import '../logic/onboarding_cubit.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_scenes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  List<OnboardingItem> _items() => const [
    OnboardingItem(
      title: LocaleKeys.onboarding1Title,
      description: LocaleKeys.onboarding1Desc,
      scene: RescueScene(),
    ),
    OnboardingItem(
      title: LocaleKeys.onboarding2Title,
      description: LocaleKeys.onboarding2Desc,
      scene: ChooseServiceScene(),
    ),
    OnboardingItem(
      title: LocaleKeys.onboarding3Title,
      description: LocaleKeys.onboarding3Desc,
      scene: TrackScene(),
    ),
  ];

  Future<void> _finish(BuildContext context) async {
    await CacheHelper.setShowIntro(true);
    if (context.mounted) {
      context.pushReplacementNamed(Routes.roleSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _items();
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: AnimatedAuthBackground(
          child: SafeArea(
            child: BlocBuilder<OnboardingCubit, int>(
              builder: (context, page) {
                final cubit = context.read<OnboardingCubit>();
                final isLast = page == items.length - 1;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _finish(context),
                            child: Text(
                              LocaleKeys.skip.tr(),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 14.sp,
                                fontFamily: FontFamily.tajawalMedium,
                              ),
                            ),
                          ),
                          const LangToggle(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: cubit.pageController,
                        onPageChanged: cubit.onPageChanged,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                item.scene,
                                SizedBox(height: 36.h),
                                Text(
                                  item.title.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontFamily: FontFamily.tajawalBold,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  item.description.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.75),
                                    fontSize: 14.sp,
                                    height: 1.6,
                                    fontFamily: FontFamily.tajawalRegular,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                      child: Column(
                        children: [
                          OnboardingIndicator(
                            count: items.length,
                            current: page,
                          ),
                          SizedBox(height: 24.h),
                          PrimaryButton(
                            text: isLast
                                ? LocaleKeys.start_now.tr()
                                : LocaleKeys.next.tr(),
                            onPressed: () {
                              if (isLast) {
                                _finish(context);
                              } else {
                                cubit.goTo(page + 1);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
