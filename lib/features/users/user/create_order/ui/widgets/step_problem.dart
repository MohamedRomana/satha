import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:satha/core/widgets/image_source_sheet.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/order_flow_models.dart';
import '../../logic/create_order_cubit.dart';
import 'order_step_header.dart';
import 'problem_images_picker.dart';
import 'problem_option_card.dart';

/// الخطوة 3: وصف المشكلة.
class StepProblem extends StatelessWidget {
  final CreateOrderCubit cubit;
  const StepProblem({super.key, required this.cubit});

  Future<void> _addImage(BuildContext context) async {
    final source = await ImageSourceSheet.show(context);
    if (source == null) return;
    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 70);
    if (picked != null) cubit.addImage(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      children: [
        OrderStepHeader(
          title: LocaleKeys.problemTitle.tr(),
          description: LocaleKeys.problemDesc.tr(),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kOrderProblems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            mainAxisExtent: 56.h,
          ),
          itemBuilder: (context, i) {
            final p = kOrderProblems[i];
            return ProblemOptionCard(
              problem: p,
              selected: cubit.problem == p.type,
              onTap: () => cubit.selectProblem(p.type),
            );
          },
        ),
        SizedBox(height: 18.h),
        SathaField(
          controller: cubit.descriptionController,
          label: LocaleKeys.additionalDetails.tr(),
          hint: LocaleKeys.additionalDetails.tr(),
          maxLines: 3,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 16.h),
        ProblemImagesPicker(
          images: cubit.problemImages,
          onAdd: () => _addImage(context),
          onRemove: cubit.removeImage,
        ),
      ],
    );
  }
}
