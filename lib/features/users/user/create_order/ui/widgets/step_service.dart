import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/order_flow_models.dart';
import '../../logic/create_order_cubit.dart';
import 'order_step_header.dart';
import 'selectable_service_card.dart';

/// الخطوة 1: اختيار نوع الخدمة.
class StepService extends StatelessWidget {
  final CreateOrderCubit cubit;
  const StepService({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      children: [
        OrderStepHeader(
          title: LocaleKeys.chooseTowType.tr(),
          description: LocaleKeys.chooseTowTypeDesc.tr(),
        ),
        for (final s in kOrderServices) ...[
          SelectableServiceCard(
            service: s,
            selected: cubit.service == s.type,
            onTap: () => cubit.selectService(s.type),
          ),
          SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
