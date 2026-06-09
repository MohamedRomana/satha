import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/gradients.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/helper/theme_x.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/core/widgets/auth_background.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/core/widgets/lang_toggle.dart';
import 'package:satha/core/widgets/theme_toggle.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'widgets/role_selection_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedAuthBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ThemeToggle(),
                      SizedBox(width: 8),
                      LangToggle(),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                const FadeSlideIn(
                  from: SlideFrom.top,
                  child: AnimatedAppLogo(size: 110, glow: true),
                ),
                SizedBox(height: 18.h),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 120),
                  child: Text(
                    LocaleKeys.welcomeToSatha.tr(),
                    style: TextStyle(
                      color: context.onBrand,
                      fontSize: 24.sp,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    LocaleKeys.chooseLoginMethod.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.onBrandMuted,
                      fontSize: 14.sp,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ),
                const Spacer(),
                AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 60,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        RoleSelectionCard(
                          title: LocaleKeys.loginAsCustomer.tr(),
                          description: LocaleKeys.loginAsCustomerDesc.tr(),
                          icon: Icons.directions_car_filled_rounded,
                          gradient: AppGradients.orange,
                          onTap: () =>
                              context.pushNamed(Routes.customerLogin),
                        ),
                        SizedBox(height: 16.h),
                        RoleSelectionCard(
                          title: LocaleKeys.loginAsDriver.tr(),
                          description: LocaleKeys.loginAsDriverDesc.tr(),
                          icon: Icons.local_shipping_rounded,
                          gradient: AppGradients.primary,
                          onTap: () => context.pushNamed(Routes.driverLogin),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 400),
                  child: TextButton.icon(
                    onPressed: () => context.pushNamed(Routes.adminLogin),
                    icon: Icon(
                      Icons.admin_panel_settings_outlined,
                      color: context.onBrandMuted,
                      size: 18.w,
                    ),
                    label: Text(
                      LocaleKeys.adminLogin.tr(),
                      style: TextStyle(
                        color: context.onBrandMuted,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.tajawalMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
