import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/custom_shimmer.dart';
import 'package:satha/core/widgets/empty_data_widget.dart';
import 'package:satha/gen/assets.gen.dart';
import '../../data/models/order_model.dart';
import 'order_card.dart';

/// عرض تبويب واحد من قائمة الطلبات (مع حالات التحميل/الفراغ/الخطأ).
class OrdersTabView extends StatelessWidget {
  final bool loading;
  final String? error;
  final List<OrderModel> orders;
  final String emptyMessage;
  final Future<void> Function() onRefresh;
  final void Function(OrderModel order) onTapOrder;

  const OrdersTabView({
    super.key,
    required this.loading,
    required this.error,
    required this.orders,
    required this.emptyMessage,
    required this.onRefresh,
    required this.onTapOrder,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) return const _OrdersShimmer();
    if (error != null) {
      return EmptyDataWidget(message: error!, lottieName: Assets.img.error);
    }
    if (orders.isEmpty) {
      return EmptyDataWidget(message: emptyMessage);
    }
    return RefreshIndicator(
      color: AppColors.orange,
      onRefresh: onRefresh,
      child: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: orders.length,
          itemBuilder: (context, i) {
            return AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 40,
                child: FadeInAnimation(
                  child: OrderCard(
                    order: orders[i],
                    onTap: () => onTapOrder(orders[i]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrdersShimmer extends StatelessWidget {
  const _OrdersShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemCount: 4,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: CustomShimmer(
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
        ),
      ),
    );
  }
}
