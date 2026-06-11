import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/empty_data_widget.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/gen/assets.gen.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/order_model.dart';
import '../logic/order_details/order_details_cubit.dart';
import '../logic/order_details/order_details_state.dart';
import 'widgets/order_details_actions.dart';
import 'widgets/order_driver_card.dart';
import 'widgets/order_status_header.dart';
import 'widgets/order_summary_content.dart';
import 'widgets/order_timeline.dart';
import 'widgets/section_card.dart';

/// شاشة تفاصيل طلب العميل.
class CustomerOrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const CustomerOrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderDetailsCubit(getIt(), orderId)..load(),
      child: const _DetailsView(),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView();

  Future<void> _viewOffers(BuildContext context, OrderModel order) async {
    final cubit = context.read<OrderDetailsCubit>();
    await context.pushNamed(
      Routes.orderOffers,
      arguments: {'orderId': order.id},
    );
    if (context.mounted) cubit.load(silent: true);
  }

  Future<void> _track(BuildContext context, OrderModel order) async {
    final cubit = context.read<OrderDetailsCubit>();
    await context.pushNamed(Routes.liveTracking, arguments: {'order': order});
    if (context.mounted) cubit.load(silent: true);
  }

  Future<void> _cancel(BuildContext context) async {
    final cubit = context.read<OrderDetailsCubit>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        title: Text(
          LocaleKeys.cancelOrderTitle.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        content: Text(
          LocaleKeys.cancelOrderDesc.tr(),
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
              LocaleKeys.cancelOrderBtn.tr(),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) cubit.cancelOrder();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderDetailsCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.orderDetailsTitle.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          state.whenOrNull(
            actionSuccess: (_) => showFlashMessage(
              message: LocaleKeys.orderCanceled.tr(),
              type: FlashMessageType.success,
              context: context,
            ),
            actionError: (_) => showFlashMessage(
              message: LocaleKeys.something_went_wrong.tr(),
              type: FlashMessageType.error,
              context: context,
            ),
          );
        },
        builder: (context, state) {
          final order = cubit.order;
          final loading = state is OrderDetailsLoading || order == null;
          if (state is OrderDetailsError && order == null) {
            return EmptyDataWidget(
              message: LocaleKeys.no_results.tr(),
              lottieName: Assets.img.error,
            );
          }
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }
          final cancelling = state is OrderDetailsActionLoading;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderStatusHeader(order: order),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionCard(
                              title: LocaleKeys.timelineTitle.tr(),
                              child: OrderTimeline(status: order.status),
                            ),
                            SizedBox(height: 16.h),
                            if (order.driverName != null) ...[
                              OrderDriverCard(
                                driverName: order.driverName!,
                                onCall: () {},
                                onChat: () {},
                              ),
                              SizedBox(height: 16.h),
                            ],
                            OrderSummaryContent(order: order),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OrderDetailsActions(
                order: order,
                canCancel: cubit.canCancel,
                cancelling: cancelling,
                onViewOffers: () => _viewOffers(context, order),
                onTrack: () => _track(context, order),
                onInvoice: () => context.pushNamed(
                  Routes.orderInvoice,
                  arguments: {'order': order},
                ),
                onRate: () => context.pushNamed(
                  Routes.rateDriver,
                  arguments: {'order': order},
                ),
                onCancel: () => _cancel(context),
                onReport: () => showFlashMessage(
                  message: LocaleKeys.comingSoon.tr(),
                  type: FlashMessageType.warning,
                  context: context,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
