import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/helper/theme_x.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/core/widgets/auth_background.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/lang_toggle.dart';
import 'package:satha/core/widgets/theme_toggle.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_state.dart';
import 'package:satha/features/auth/driver_register/ui/widgets/driver_register_nav_bar.dart';
import 'package:satha/features/auth/driver_register/ui/widgets/driver_step_documents.dart';
import 'package:satha/features/auth/driver_register/ui/widgets/driver_step_personal.dart';
import 'package:satha/features/auth/driver_register/ui/widgets/driver_step_review.dart';
import 'package:satha/features/auth/driver_register/ui/widgets/driver_step_tow.dart';
import 'package:satha/features/auth/widgets/driver_steps_progress.dart';

/// شاشة تسجيل السائق متعدّدة الخطوات (4 خطوات + مؤشّر تقدّم متحرّك).
/// الشاشة تجميع فقط — كل خطوة widget مستقل في ui/widgets/.
class DriverRegisterScreen extends StatelessWidget {
  const DriverRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverRegisterCubit>();
    final stepTitles = [
      LocaleKeys.driverPersonalInfo.tr(),
      LocaleKeys.driverTowInfo.tr(),
      LocaleKeys.driverDocuments.tr(),
      LocaleKeys.driverReview.tr(),
    ];

    return Scaffold(
      body: AnimatedAuthBackground(
        child: SafeArea(
          child: BlocConsumer<DriverRegisterCubit, DriverRegisterState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (msg) => showFlashMessage(
                  message: msg,
                  type: FlashMessageType.error,
                  context: context,
                ),
                success: () =>
                    context.pushReplacementNamed(Routes.driverRegisterPending),
              );
            },
            builder: (context, state) {
              final loading =
                  state.maybeWhen(loading: () => true, orElse: () => false);
              final step = cubit.currentStep;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLogo(size: 44, hero: false),
                        Row(
                          children: [
                            ThemeToggle(),
                            SizedBox(width: 8),
                            LangToggle(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    stepTitles[step],
                    style: TextStyle(
                      color: context.onBrand,
                      fontSize: 18.sp,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                    child: DriverStepsProgress(
                      currentStep: step,
                      steps: stepTitles,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(28.r)),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0.15, 0),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        ),
                        child: SingleChildScrollView(
                          key: ValueKey(step),
                          physics: const BouncingScrollPhysics(),
                          child: switch (step) {
                            0 => DriverStepPersonal(cubit: cubit),
                            1 => DriverStepTow(cubit: cubit),
                            2 => DriverStepDocuments(cubit: cubit),
                            _ => DriverStepReview(cubit: cubit),
                          },
                        ),
                      ),
                    ),
                  ),
                  DriverRegisterNavBar(
                    isFirst: step == 0,
                    isLast: step == DriverRegisterCubit.totalSteps - 1,
                    loading: loading,
                    onBack: () => step == 0 ? context.pop() : cubit.prevStep(),
                    onNext: () => _onNext(context, cubit),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// منطق الانتقال للخطوة التالية مع التحقق (ليس بانيًا لويدجت).
  void _onNext(BuildContext context, DriverRegisterCubit cubit) {
    switch (cubit.currentStep) {
      case 0:
        if (!cubit.step1FormKey.currentState!.validate()) return;
        if (cubit.city == null) {
          _warn(context, LocaleKeys.selectCityRequired.tr());
          return;
        }
        cubit.nextStep();
        break;
      case 1:
        if (!cubit.step2FormKey.currentState!.validate()) return;
        if (cubit.towType == null) {
          _warn(context, LocaleKeys.selectTowTypeRequired.tr());
          return;
        }
        cubit.nextStep();
        break;
      case 2:
        if (!cubit.requiredDocsComplete) {
          _warn(context, LocaleKeys.attachRequiredImages.tr());
          return;
        }
        cubit.nextStep();
        break;
      default:
        cubit.submit();
    }
  }

  void _warn(BuildContext context, String message) => showFlashMessage(
        message: message,
        type: FlashMessageType.warning,
        context: context,
      );
}
