import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/location_models.dart';
import '../data/models/order_flow_models.dart';
import '../logic/create_order_cubit.dart';
import 'widgets/order_progress_indicator.dart';
import 'widgets/step_problem.dart';
import 'widgets/step_service.dart';
import 'widgets/step_vehicle.dart';

/// تدفّق إنشاء طلب سطحة (خطوات متعددة بـ PageView).
class CreateOrderFlowScreen extends StatelessWidget {
  final OrderServiceType? initialService;
  const CreateOrderFlowScreen({super.key, this.initialService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = CreateOrderCubit(getIt());
        if (initialService != null) cubit.selectService(initialService!);
        return cubit;
      },
      child: const _CreateOrderView(),
    );
  }
}

class _CreateOrderView extends StatelessWidget {
  const _CreateOrderView();

  // صفحات الـ PageView (الخدمة/السيارة/المشكلة) — الموقع شاشة مستقلة.
  static const int _pages = 3;

  static const _stepLabels = [
    LocaleKeys.stepService,
    LocaleKeys.stepVehicle,
    LocaleKeys.stepProblem,
    LocaleKeys.stepLocation,
    LocaleKeys.stepConfirm,
  ];

  Future<bool> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
        title: Text(
          LocaleKeys.leaveOrderTitle.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        content: Text(
          LocaleKeys.leaveOrderDesc.tr(),
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.5,
            color: AppColors.secondaryText,
            fontFamily: FontFamily.tajawalRegular,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              LocaleKeys.stayBtn.tr(),
              style: const TextStyle(color: AppColors.navy),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              LocaleKeys.leaveBtn.tr(),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  Future<void> _addVehicle(BuildContext context) async {
    final cubit = context.read<CreateOrderCubit>();
    final added = await context.pushNamed(Routes.addVehicle);
    if (added == true) cubit.loadVehicles();
  }

  void _onNext(BuildContext context) {
    final cubit = context.read<CreateOrderCubit>();
    final step = cubit.currentStep;
    if (!cubit.canProceed(step)) {
      const msgs = [
        LocaleKeys.selectServiceRequired,
        LocaleKeys.selectVehicleRequired,
        LocaleKeys.selectProblemRequired,
      ];
      showFlashMessage(
        message: msgs[step].tr(),
        type: FlashMessageType.warning,
        context: context,
      );
      return;
    }
    if (step >= _pages - 1) {
      _openLocations(context);
      return;
    }
    cubit.next();
  }

  Future<void> _openLocations(BuildContext context) async {
    final cubit = context.read<CreateOrderCubit>();
    final result = await context.pushNamed(Routes.selectOrderLocations);
    if (result is! Map || !context.mounted) return;
    cubit.setLocations(
      pickup: result['pickup'] as LocationModel?,
      destination: result['destination'] as LocationModel?,
      route: result['route'] as RouteInfoModel?,
    );
    if (!cubit.hasLocations) return;
    // شاشة ملخّص الطلب قبل الإرسال.
    context.pushNamed(
      Routes.orderSummary,
      arguments: {'draft': cubit.buildDraft()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOrderCubit>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (cubit.currentStep > 0) {
          cubit.back();
          return;
        }
        final leave = await _confirmExit(context);
        if (leave && context.mounted) context.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.requestTowNow.tr(),
            style: TextStyle(
              fontSize: 17.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
        ),
        body: BlocBuilder<CreateOrderCubit, int>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                  child: OrderProgressIndicator(
                    currentStep: cubit.currentStep,
                    steps: _stepLabels.map((k) => k.tr()).toList(),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: cubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StepService(cubit: cubit),
                      StepVehicle(
                        cubit: cubit,
                        onAddVehicle: () => _addVehicle(context),
                      ),
                      StepProblem(cubit: cubit),
                    ],
                  ),
                ),
                _BottomBar(
                  showBack: cubit.currentStep > 0,
                  onBack: cubit.back,
                  onNext: () => _onNext(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onNext;
  const _BottomBar({
    required this.showBack,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (showBack) ...[
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(0, 54.h),
                    side: BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.previous.tr(),
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 15.sp,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              flex: 3,
              child: PrimaryButton(
                text: LocaleKeys.next.tr(),
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
