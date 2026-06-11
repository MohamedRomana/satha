import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/empty_data_widget.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/gen/assets.gen.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../create_order/data/services/map_marker_factory.dart';
import '../data/models/offer_model.dart';
import '../logic/offers/offers_cubit.dart';
import '../logic/offers/offers_state.dart';
import 'widgets/accept_offer_dialog.dart';
import 'widgets/offer_card.dart';

/// شاشة عروض الطلب (خريطة + قائمة عروض متحرّكة).
class CustomerOrderOffersScreen extends StatelessWidget {
  final String orderId;
  const CustomerOrderOffersScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OffersCubit(getIt(), getIt(), orderId)..load(),
      child: const _OffersView(),
    );
  }
}

class _OffersView extends StatelessWidget {
  const _OffersView();

  Future<void> _accept(BuildContext context, OfferModel offer) async {
    final cubit = context.read<OffersCubit>();
    final confirm = await AcceptOfferDialog.show(context);
    if (confirm == true) cubit.acceptOffer(offer.id);
  }

  void _viewDriver(BuildContext context, OfferModel offer) {
    context.pushNamed(Routes.driverProfile, arguments: {'driver': offer.driver});
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OffersCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.offersTitle.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<OffersCubit, OffersState>(
        listener: (context, state) {
          state.whenOrNull(
            accepted: (offer) {
              showFlashMessage(
                message: LocaleKeys.offerAcceptedMsg.tr(),
                type: FlashMessageType.success,
                context: context,
              );
              Navigator.of(context).pushReplacementNamed(
                Routes.liveTracking,
                arguments: {'order': cubit.order},
              );
            },
            actionError: (_) => showFlashMessage(
              message: LocaleKeys.something_went_wrong.tr(),
              type: FlashMessageType.error,
              context: context,
            ),
          );
        },
        builder: (context, state) {
          if (state is OffersLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }
          if (state is OffersError) {
            return EmptyDataWidget(
              message: LocaleKeys.no_results.tr(),
              lottieName: Assets.img.error,
            );
          }
          final order = cubit.order;
          final offers = cubit.visibleOffers;
          final busy = state is OffersAccepting;
          return Stack(
            children: [
              if (order != null)
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: order.pickup.latLng,
                    zoom: 12.5,
                  ),
                  markers: {
                    MapMarkerFactory.pickup(order.pickup.latLng),
                    MapMarkerFactory.destination(order.destination.latLng),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: order.route.polyline,
                      color: AppColors.orange,
                      width: 5,
                    ),
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
              DraggableScrollableSheet(
                initialChildSize: 0.55,
                minChildSize: 0.3,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBg,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          width: 44.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.availableOffers.tr(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.mainText,
                                  fontFamily: FontFamily.tajawalBold,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softOrange,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '${offers.length}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.orange,
                                    fontFamily: FontFamily.tajawalBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: offers.isEmpty
                              ? EmptyDataWidget(
                                  message: LocaleKeys.waiting_drivers_approval
                                      .tr(),
                                )
                              : ListView.builder(
                                  controller: scrollController,
                                  padding: EdgeInsets.fromLTRB(
                                    16.w,
                                    0,
                                    16.w,
                                    20.h,
                                  ),
                                  itemCount: offers.length,
                                  itemBuilder: (context, i) {
                                    final offer = offers[i];
                                    return OfferCard(
                                      offer: offer,
                                      remainingSec:
                                          cubit.remainingFor(offer.id),
                                      busy: busy,
                                      onViewDriver: () =>
                                          _viewDriver(context, offer),
                                      onAccept: () => _accept(context, offer),
                                      onReject: () =>
                                          cubit.rejectOffer(offer.id),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (busy)
                Container(
                  color: Colors.black.withValues(alpha: 0.2),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
