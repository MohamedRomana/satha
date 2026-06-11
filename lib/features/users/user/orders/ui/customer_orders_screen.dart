import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/order_model.dart';
import '../logic/orders_list/orders_cubit.dart';
import '../logic/orders_list/orders_state.dart';
import 'widgets/orders_tab_view.dart';

/// شاشة طلبات العميل بثلاثة تبويبات (الحالية/السابقة/الملغاة).
class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit(getIt())..getOrders(),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatelessWidget {
  const _OrdersView();

  Future<void> _openDetails(BuildContext context, OrderModel order) async {
    final cubit = context.read<OrdersCubit>();
    await context.pushNamed(
      Routes.orderDetails,
      arguments: {'orderId': order.id},
    );
    if (context.mounted) cubit.getOrders(silent: true);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            LocaleKeys.navOrders.tr(),
            style: TextStyle(
              fontSize: 17.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          bottom: TabBar(
            labelColor: AppColors.orange,
            unselectedLabelColor: AppColors.secondaryText,
            indicatorColor: AppColors.orange,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.tajawalBold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.tajawalRegular,
            ),
            tabs: [
              Tab(text: LocaleKeys.currentOrders.tr()),
              Tab(text: LocaleKeys.completedOrders.tr()),
              Tab(text: LocaleKeys.cancelledOrders.tr()),
            ],
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              initial: () => true,
              orElse: () => false,
            );
            final error = state.maybeWhen(
              error: (m) => m,
              orElse: () => null,
            );
            return TabBarView(
              children: [
                OrdersTabView(
                  loading: isLoading,
                  error: error,
                  orders: cubit.currentOrders,
                  emptyMessage: LocaleKeys.no_current_orders.tr(),
                  onRefresh: () => cubit.getOrders(silent: true),
                  onTapOrder: (o) => _openDetails(context, o),
                ),
                OrdersTabView(
                  loading: isLoading,
                  error: error,
                  orders: cubit.previousOrders,
                  emptyMessage: LocaleKeys.no_previous_orders.tr(),
                  onRefresh: () => cubit.getOrders(silent: true),
                  onTapOrder: (o) => _openDetails(context, o),
                ),
                OrdersTabView(
                  loading: isLoading,
                  error: error,
                  orders: cubit.canceledOrders,
                  emptyMessage: LocaleKeys.no_cancelled_orders.tr(),
                  onRefresh: () => cubit.getOrders(silent: true),
                  onTapOrder: (o) => _openDetails(context, o),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
