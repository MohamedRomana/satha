import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/services/map_marker_factory.dart';
import '../logic/select_locations/select_locations_cubit.dart';
import '../logic/select_locations/select_locations_state.dart';
import 'widgets/animated_center_pin.dart';
import 'widgets/location_permission_view.dart';

/// شاشة اختيار نقطة البداية والوصول على خريطة Google.
class SelectOrderLocationsScreen extends StatelessWidget {
  const SelectOrderLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectLocationsCubit(getIt(), getIt(), getIt(), getIt())
        ..init(),
      child: const _LocationsBody(),
    );
  }
}

class _LocationsBody extends StatelessWidget {
  const _LocationsBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectLocationsCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: BlocBuilder<SelectLocationsCubit, SelectLocationsState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            ),
            servicesDisabled: () => LocationPermissionView(
              message: LocaleKeys.servicesDisabledMsg.tr(),
              primaryLabel: LocaleKeys.openSettingsBtn.tr(),
              onPrimary: cubit.openSettings,
              onManual: cubit.useManual,
            ),
            permissionDenied: (forever) => LocationPermissionView(
              message: forever
                  ? LocaleKeys.permDeniedMsg.tr()
                  : LocaleKeys.permNeedAccess.tr(),
              primaryLabel: forever
                  ? LocaleKeys.openSettingsBtn.tr()
                  : LocaleKeys.allowLocationBtn.tr(),
              onPrimary: forever
                  ? cubit.openSettings
                  : cubit.requestPermissionAgain,
              onManual: cubit.useManual,
            ),
            error: (msg) => Center(child: Text(msg)),
            ready: (_) => const _MapView(),
          );
        },
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView();

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  GoogleMapController? _controller;
  LatLng _center = SelectLocationsCubit.defaultCenter;

  Future<void> _goToCurrent(SelectLocationsCubit cubit) async {
    await cubit.useCurrentLocation();
    final c = cubit.current;
    if (c != null) {
      await _controller?.animateCamera(CameraUpdate.newLatLng(c.latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectLocationsCubit>();
    final initial = cubit.pickup?.latLng ??
        cubit.current?.latLng ??
        SelectLocationsCubit.defaultCenter;

    final markers = <Marker>{
      if (cubit.pickup != null) MapMarkerFactory.pickup(cubit.pickup!.latLng),
      if (cubit.destination != null)
        MapMarkerFactory.destination(cubit.destination!.latLng),
    };
    final polylines = <Polyline>{
      if (cubit.route != null)
        Polyline(
          polylineId: const PolylineId('route'),
          points: cubit.route!.polyline,
          color: AppColors.orange,
          width: 5,
        ),
    };

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(target: initial, zoom: 13),
          onMapCreated: (c) => _controller = c,
          onCameraMove: (pos) => _center = pos.target,
          markers: markers,
          polylines: polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        ),
        const Center(child: AnimatedCenterPin()),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: _TopSelectors(cubit: cubit),
            ),
          ),
        ),
        PositionedDirectional(
          end: 16.w,
          bottom: cubit.canConfirm ? 180.h : 220.h,
          child: _RoundButton(
            icon: Icons.my_location_rounded,
            onTap: () => _goToCurrent(cubit),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _BottomPanel(
            cubit: cubit,
            onConfirmCenter: () => cubit.confirmCenter(_center),
            onConfirmLocations: () => context.pop({
              'pickup': cubit.pickup,
              'destination': cubit.destination,
              'route': cubit.route,
            }),
          ),
        ),
      ],
    );
  }
}

class _TopSelectors extends StatelessWidget {
  final SelectLocationsCubit cubit;
  const _TopSelectors({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.w),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectorRow(
                  active: !cubit.selectingDestination,
                  color: AppColors.orange,
                  label: cubit.pickup?.address ??
                      LocaleKeys.selectPickupHint.tr(),
                  onTap: () => cubit.setActive(false),
                ),
                Divider(height: 12.h, color: AppColors.border),
                _selectorRow(
                  active: cubit.selectingDestination,
                  color: AppColors.navy,
                  label: cubit.destination?.address ??
                      LocaleKeys.selectDestHint.tr(),
                  onTap: () => cubit.setActive(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectorRow({
    required bool active,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: active ? AppColors.mainText : AppColors.secondaryText,
                fontFamily:
                    active ? FontFamily.tajawalBold : FontFamily.tajawalRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  final SelectLocationsCubit cubit;
  final VoidCallback onConfirmCenter;
  final VoidCallback onConfirmLocations;
  const _BottomPanel({
    required this.cubit,
    required this.onConfirmCenter,
    required this.onConfirmLocations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: cubit.canConfirm
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _info(
                        LocaleKeys.distanceLabel.tr(),
                        '${cubit.route!.distanceKm} ${LocaleKeys.kmUnit.tr()}',
                      ),
                      Container(width: 1, height: 34.h, color: AppColors.border),
                      _info(
                        LocaleKeys.durationLabel.tr(),
                        '${cubit.route!.durationMin} ${LocaleKeys.minUnit.tr()}',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    text: LocaleKeys.confirmLocationsBtn.tr(),
                    loading: cubit.routeLoading,
                    onPressed: onConfirmLocations,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.moveMapToSelect.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  PrimaryButton(
                    text:
                        '${LocaleKeys.confirmLocationBtn.tr()} • ${cubit.selectingDestination ? LocaleKeys.destinationPoint.tr() : LocaleKeys.pickupPoint.tr()}',
                    loading: cubit.routeLoading || cubit.confirming,
                    onPressed: onConfirmCenter,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.orange, size: 24.w),
      ),
    );
  }
}
