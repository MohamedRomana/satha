import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../logic/vehicles/vehicles_cubit.dart';
import '../logic/vehicles/vehicles_state.dart';
import 'widgets/vehicle_card.dart';
import 'widgets/vehicle_delete_dialog.dart';
import 'widgets/vehicles_empty_state.dart';

/// شاشة سيارات العميل (تبويب سياراتي).
class CustomerVehiclesScreen extends StatelessWidget {
  const CustomerVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehiclesCubit(getIt())..load(),
      child: const _VehiclesView(),
    );
  }
}

class _VehiclesView extends StatelessWidget {
  const _VehiclesView();

  Future<void> _openAdd(BuildContext context) async {
    final cubit = context.read<VehiclesCubit>();
    final added = await context.pushNamed(Routes.addVehicle);
    if (added == true) cubit.load(silent: true);
  }

  Future<void> _openDetails(BuildContext context, id) async {
    final cubit = context.read<VehiclesCubit>();
    final vehicle = cubit.vehicles.firstWhere((v) => v.id == id);
    final changed = await context.pushNamed(
      Routes.vehicleDetails,
      arguments: {'vehicle': vehicle},
    );
    if (changed == true) cubit.load(silent: true);
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final cubit = context.read<VehiclesCubit>();
    final confirmed = await VehicleDeleteDialog.show(context);
    if (confirmed) cubit.deleteVehicle(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.navVehicles.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<VehiclesCubit, VehiclesState>(
        builder: (context, state) {
          final cubit = context.read<VehiclesCubit>();
          if (cubit.vehicles.isEmpty) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => _openAdd(context),
            backgroundColor: AppColors.orange,
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: Text(
              LocaleKeys.addNewVehicle.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<VehiclesCubit, VehiclesState>(
        listener: (context, state) {
          state.whenOrNull(
            actionSuccess: (msg) => showFlashMessage(
              message: msg.tr(),
              type: FlashMessageType.success,
              context: context,
            ),
            error: (msg) => showFlashMessage(
              message: msg,
              type: FlashMessageType.error,
              context: context,
            ),
          );
        },
        builder: (context, state) {
          final cubit = context.read<VehiclesCubit>();
          final loading =
              state.maybeWhen(loading: () => true, orElse: () => false);
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }
          if (cubit.vehicles.isEmpty) {
            return VehiclesEmptyState(onAdd: () => _openAdd(context));
          }
          return RefreshIndicator(
            color: AppColors.orange,
            onRefresh: () => cubit.load(silent: true),
            child: AnimationLimiter(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 90.h),
                itemCount: cubit.vehicles.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final v = cubit.vehicles[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 350),
                    child: SlideAnimation(
                      verticalOffset: 40,
                      child: FadeInAnimation(
                        child: VehicleCard(
                          vehicle: v,
                          onTap: () => _openDetails(context, v.id),
                          onSetDefault: () => cubit.setDefault(v.id),
                          onDelete: () => _confirmDelete(context, v.id),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
