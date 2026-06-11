import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/empty_data_widget.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/notification_model.dart';
import '../logic/notifications_cubit.dart';
import '../logic/notifications_state.dart';
import 'widgets/notification_tile.dart';

/// شاشة إشعارات العميل.
class CustomerNotificationsScreen extends StatelessWidget {
  const CustomerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(getIt())..load(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  void _onTap(BuildContext context, NotificationModel n) {
    final cubit = context.read<NotificationsCubit>();
    cubit.markRead(n.id);
    if (n.orderId != null) {
      context.pushNamed(Routes.orderDetails, arguments: {'orderId': n.orderId});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.notifications.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (cubit.unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: cubit.markAllRead,
                child: Text(
                  LocaleKeys.markAllRead.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.orange,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }
          final items = cubit.items;
          if (items.isEmpty) {
            return EmptyDataWidget(message: LocaleKeys.no_notifications.tr());
          }
          return AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final n = items[i];
                return AnimationConfiguration.staggeredList(
                  position: i,
                  duration: const Duration(milliseconds: 350),
                  child: SlideAnimation(
                    verticalOffset: 30,
                    child: FadeInAnimation(
                      child: Dismissible(
                        key: ValueKey(n.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => cubit.delete(n.id),
                        background: Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.error,
                          ),
                        ),
                        child: NotificationTile(
                          notification: n,
                          onTap: () => _onTap(context, n),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
