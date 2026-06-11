import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../create_order/data/services/map_marker_factory.dart';
import '../data/models/order_model.dart';
import '../logic/tracking/live_tracking_cubit.dart';
import '../logic/tracking/live_tracking_state.dart';
import 'widgets/order_otp_verification_bottom_sheet.dart';
import 'widgets/tracking_bottom_panel.dart';

/// شاشة التتبّع المباشر للطلب.
class CustomerLiveTrackingScreen extends StatelessWidget {
  final OrderModel order;
  const CustomerLiveTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LiveTrackingCubit(getIt(), getIt(), order)..start(),
      child: const _TrackingView(),
    );
  }
}

class _TrackingView extends StatefulWidget {
  const _TrackingView();

  @override
  State<_TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<_TrackingView> {
  GoogleMapController? _controller;
  bool _arrivalAsked = false;
  bool _completionAsked = false;

  Future<void> _recenter(LatLng? pos) async {
    if (pos != null) {
      await _controller?.animateCamera(CameraUpdate.newLatLng(pos));
    }
  }

  Future<void> _onStatusChange(BuildContext context, LiveTrackingCubit cubit) async {
    if (cubit.currentStatus == OrderStatus.driverArrived && !_arrivalAsked) {
      _arrivalAsked = true;
      final ok = await OrderOtpVerificationBottomSheet.show(
        context,
        title: LocaleKeys.confirmArrivalTitle.tr(),
        subtitle: LocaleKeys.confirmArrivalDesc.tr(),
      );
      if (ok == true) cubit.confirmArrival();
    } else if (cubit.currentStatus == OrderStatus.destinationReached &&
        !_completionAsked) {
      _completionAsked = true;
      final ok = await OrderOtpVerificationBottomSheet.show(
        context,
        title: LocaleKeys.confirmCompletionTitle.tr(),
        subtitle: LocaleKeys.confirmCompletionDesc.tr(),
      );
      if (ok == true) {
        await cubit.completeTrip();
        if (!context.mounted) return;
        Navigator.of(context).pushReplacementNamed(
          Routes.rateDriver,
          arguments: {'order': cubit.order},
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveTrackingCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.trackOrderBtn.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<LiveTrackingCubit, LiveTrackingState>(
        listener: (context, state) => _onStatusChange(context, cubit),
        builder: (context, state) {
          final driver = cubit.driverPosition ?? cubit.order.pickup.latLng;
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target: driver, zoom: 14),
                onMapCreated: (c) => _controller = c,
                markers: {
                  MapMarkerFactory.pickup(cubit.order.pickup.latLng),
                  MapMarkerFactory.destination(cubit.order.destination.latLng),
                  Marker(
                    markerId: const MarkerId('driver'),
                    position: driver,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen,
                    ),
                    infoWindow: InfoWindow(
                      title: cubit.order.driverName ?? '',
                    ),
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('path'),
                    points: cubit.path,
                    color: AppColors.orange,
                    width: 5,
                  ),
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
              PositionedDirectional(
                bottom: 200.h,
                end: 16.w,
                child: FloatingActionButton(
                  heroTag: 'recenter',
                  mini: true,
                  backgroundColor: AppColors.card,
                  onPressed: () => _recenter(cubit.driverPosition),
                  child: const Icon(
                    Icons.my_location_rounded,
                    color: AppColors.navy,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TrackingBottomPanel(
                  order: cubit.order,
                  etaMin: cubit.etaMin,
                  distanceRemainingKm: cubit.distanceRemainingKm,
                  status: cubit.currentStatus,
                  onCall: () {},
                  onChat: () {},
                  onReport: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
