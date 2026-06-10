import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/create_order/data/models/order_flow_models.dart';
import 'package:satha/features/users/user/home/data/models/home_models.dart';
import 'package:satha/features/users/user/home/logic/home_cubit.dart';
import 'package:satha/features/users/user/home/logic/home_state.dart';
import 'package:satha/features/users/user/main_layout/logic/main_layout_cubit.dart';
import 'widgets/active_order_preview.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_slider.dart';
import 'widgets/quick_rescue_card.dart';
import 'widgets/recent_orders_preview.dart';
import 'widgets/service_cards.dart';
import 'widgets/support_card.dart';

/// شاشة الهوم للعميل (تبويب الرئيسية).
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..load(),
      child: const _CustomerHomeView(),
    );
  }
}

class _CustomerHomeView extends StatelessWidget {
  const _CustomerHomeView();

  void _comingSoon(BuildContext context) => showFlashMessage(
        message: LocaleKeys.comingSoon.tr(),
        type: FlashMessageType.warning,
        context: context,
      );

  void _goToTab(BuildContext context, int index) =>
      context.read<MainLayoutCubit>().changeTab(index);

  void _openOrder(BuildContext context, {OrderServiceType? service}) {
    context.pushNamed(
      Routes.createOrderFlow,
      arguments: service == null ? null : {'service': service},
    );
  }

  OrderServiceType _mapService(CustomerServiceType type) =>
      type == CustomerServiceType.hydraulic
          ? OrderServiceType.hydraulic
          : OrderServiceType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.map(
              loading: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.orange),
              ),
              loaded: (s) => _content(context, s.data),
            );
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context, HomeData data) {
    final sections = <Widget>[
      HomeHeader(
        customerName: data.customerName,
        unreadCount: data.unreadNotifications,
        onNotifications: () => _comingSoon(context),
      ),
      SizedBox(height: 18.h),
      PromoSlider(promos: data.promos),
      if (data.activeOrder != null) ...[
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: _sectionTitle(LocaleKeys.activeOrderTitle.tr()),
        ),
        ActiveOrderPreview(
          order: data.activeOrder!,
          onTap: () => _comingSoon(context),
        ),
      ],
      SizedBox(height: 22.h),
      _sectionTitle(LocaleKeys.ourServices.tr()),
      SizedBox(height: 12.h),
      ServiceCards(
        services: data.services,
        onSelect: (type) => _openOrder(context, service: _mapService(type)),
      ),
      SizedBox(height: 18.h),
      QuickRescueCard(onTap: () => _openOrder(context)),
      SizedBox(height: 24.h),
      RecentOrdersPreview(
        orders: data.recentOrders,
        onViewAll: () => _goToTab(context, 1),
        onOrderTap: (_) => _comingSoon(context),
      ),
      SizedBox(height: 20.h),
      SupportCard(onTap: () => _comingSoon(context)),
      SizedBox(height: 24.h),
    ];

    return RefreshIndicator(
      color: AppColors.orange,
      onRefresh: () => context.read<HomeCubit>().load(),
      child: AnimationLimiter(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 400),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(child: widget),
            ),
            children: sections,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Builder(
        builder: (context) => Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      );
}
